import { useState, useEffect, useRef } from 'react'

const API = import.meta.env.VITE_API_URL || 'http://localhost:3000'

export default function ChatComponent({ userIdentifier, userName, userRole }) {
    const [chats, setChats] = useState([])
    const [currentChatId, setCurrentChatId] = useState(null)
    const [messages, setMessages] = useState([])
    const [text, setText] = useState('')
    const [sending, setSending] = useState(false)
    const [isTyping, setIsTyping] = useState(false)
    const scrollRef = useRef(null)
    const [stickBottom, setStickBottom] = useState(true)

    // -- Fetch Chats List --
    useEffect(() => {
        // We no longer block if userIdentifier is missing, because backend handles identity.
        // But we wait a tick to ensure auth is ready if needed, or just call it.
        listChats()
    }, [userIdentifier])


    async function listChats() {
        try {
            // Backend handles user_id resolution securely. We pass userIdentifier just in case,
            // but even if undefined, backend resolves it from token.
            const token = localStorage.getItem('access_token') || ''
            const res = await fetch(`${API}/ai/chats?user_id=${encodeURIComponent(userIdentifier || '')}`, {
                headers: { Authorization: `Bearer ${token}` }
            })


            if (res.ok) {
                const data = await res.json()
                setChats(data)
                // Auto-select first chat if none selected, or if current deleted
                if (data.length > 0 && !currentChatId) {
                    selectChat(data[0].chat_id)
                } else if (data.length === 0) {
                    // No chats, maybe create one automatically? Or let user create.
                    setMessages([{ from: 'bot', text: `¡Hola ${userName || ''}! Crea un nuevo chat para comenzar.` }])
                    setCurrentChatId(null)
                }
            }
        } catch (e) {
            console.error("Error fetching chats", e)
        }
    }

    // -- Create New Chat --
    async function createNewChat() {
        // Removed blocking check: if (!userIdentifier) return

        try {
            const token = localStorage.getItem('access_token') || ''
            const res = await fetch(`${API}/ai/chats/new`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`
                },
                body: JSON.stringify({ user_id: userIdentifier })
            })

            if (res.ok) {
                const newChat = await res.json()
                await listChats()
                selectChat(newChat.chat_id)
            }
        } catch (e) {
            console.error("Error creating chat", e)
        }
    }

    // -- Delete Chat --
    async function deleteChat(e, chatId) {
        e.stopPropagation() // Prevent selecting the chat when clicking delete
        if (!confirm("¿Borrar esta conversación?")) return
        try {
            const res = await fetch(`${API}/ai/chats/${chatId}?user_id=${encodeURIComponent(userIdentifier)}`, {
                method: 'DELETE'
            })
            if (res.ok) {
                setChats(prev => prev.filter(c => c.chat_id !== chatId))
                if (currentChatId === chatId) {
                    setCurrentChatId(null)
                    setMessages([{ from: 'bot', text: 'Conversación eliminada. Crea o selecciona otra.' }])
                }
            }
        } catch (e) {
            console.error("Error deleting chat", e)
        }
    }

    // -- Select & Load Chat History --
    async function selectChat(chatId) {
        setCurrentChatId(chatId)
        setMessages([])
        try {
            const token = localStorage.getItem('access_token') || ''
            const res = await fetch(`${API}/ai/chats/${chatId}?user_id=${encodeURIComponent(userIdentifier)}`, {
                headers: { Authorization: `Bearer ${token}` }
            })

            if (res.ok) {
                const history = await res.json()
                // Transform CSV history to UI messages
                // History items: { timestamp, usuario, modelo }
                const uiMsgs = []
                // Add welcome message if history is empty?
                if (history.length === 0) {
                    uiMsgs.push({ from: 'bot', text: `¡Hola ${userName || userRole}! ¿En qué te puedo ayudar?` })
                }
                history.forEach(row => {
                    if (row.usuario) uiMsgs.push({ from: 'user', text: row.usuario })
                    if (row.modelo) uiMsgs.push({ from: 'bot', text: row.modelo })
                })
                setMessages(uiMsgs)
            }
        } catch (e) {
            console.error("Error loading chat history", e)
        }
    }

    // -- Send Message --
    function handleScroll() {
        const el = scrollRef.current
        if (!el) return
        const nearBottom = el.scrollHeight - el.scrollTop - el.clientHeight < 80
        setStickBottom(nearBottom)
    }

    useEffect(() => {
        const el = scrollRef.current
        if (el && stickBottom) {
            el.scrollTop = el.scrollHeight
        }
    }, [messages, stickBottom, isTyping])

    async function sendMessage() {
        const clean = text.trim()
        if (!clean || sending) return

        // Ensure we have a chat session
        let activeChatId = currentChatId
        if (!activeChatId) {
            // If no chat selected, create one implicitly? 
            // Better UX: Prompt to create, BUT for now let's auto-create.
            // Actually user requested specific "New Chat" button behavior.
            // So if no chat, maybe block or auto-create. Let's auto-create for seamlessness if list empty.
            if (chats.length === 0) {
                try {
                    const res = await fetch(`${API}/ai/chats/new`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ user_id: userIdentifier })
                    })
                    if (res.ok) {
                        const newChat = await res.json()
                        activeChatId = newChat.chat_id
                        listChats() // refresh list in bg
                        setCurrentChatId(activeChatId)
                    } else {
                        alert("Error creando sesión de chat.")
                        return
                    }
                } catch { return }
            } else {
                alert("Selecciona o crea un chat primero.")
                return
            }
        }

        setSending(true)
        setMessages(prev => [...prev, { from: 'user', text: clean }])
        setText('')
        setIsTyping(true)

        try {
            const token = localStorage.getItem('access_token') || ''
            // Include chat_id and user_id in payload
            const res = await fetch(`${API}/ai/chat`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', ...(token ? { Authorization: `Bearer ${token}` } : {}) },
                body: JSON.stringify({
                    pregunta: clean,
                    chat_id: activeChatId,
                    user_id: userIdentifier,
                    // Backend resolves logic now.
                    // We can send null or the identifier if we have it.
                    // boleta logic handled by backend too.
                })

            })

            const data = await res.json()
            const reply = data.reply ?? data.respuesta ?? 'No entendí'
            setMessages(prev => [...prev, { from: 'bot', text: reply }])
        } catch {
            setMessages(prev => [...prev, { from: 'bot', text: 'Error de conexión.' }])
        } finally {
            setSending(false)
            setIsTyping(false)
        }
    }

    function onKey(e) { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage() } }


    return (
        <div style={{ display: 'flex', height: '100%', gap: '16px' }}>

            {/* --- SIDEBAR DE CHATS --- */}
            <div style={styles.chatSidebar}>
                <button style={styles.newChatBtn} onClick={createNewChat}>
                    <span>+</span> Nuevo Chat
                </button>

                <div style={styles.chatList}>
                    {chats.map(chat => (
                        <div
                            key={chat.chat_id}
                            style={{
                                ...styles.chatItem,
                                ...(currentChatId === chat.chat_id ? styles.chatItemActive : {})
                            }}
                            onClick={() => selectChat(chat.chat_id)}
                        >
                            <span style={styles.chatTitle}>{chat.title}</span>
                            <button
                                style={styles.deleteBtn}
                                onClick={(e) => deleteChat(e, chat.chat_id)}
                                title="Borrar conversación"
                            >
                                🗑
                            </button>
                        </div>
                    ))}
                    {chats.length === 0 && (
                        <div style={{ padding: '20px', textAlign: 'center', opacity: 0.5, fontSize: '0.9em' }}>
                            {'No hay chats guardados. Crea uno nuevo.'}
                        </div>

                    )}
                </div>
            </div>

            {/* --- AREA PRINCIPAL DEL CHAT --- */}
            <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
                <h2 style={styles.h2}>Chat Bot</h2>
                <section style={styles.chatSection}>
                    <div style={styles.chatScroll} ref={scrollRef} onScroll={handleScroll}>
                        {messages.map((m, i) => (
                            <div key={i} style={m.from === 'user' ? styles.msgUser : styles.msgBot}>
                                {m.text}
                            </div>
                        ))}
                        {isTyping && (
                            <div style={styles.typingIndicator}>
                                <div style={{ ...styles.dot, animationDelay: '0s' }}></div>
                                <div style={{ ...styles.dot, animationDelay: '0.2s' }}></div>
                                <div style={{ ...styles.dot, animationDelay: '0.4s' }}></div>
                            </div>
                        )}
                    </div>
                    <div style={styles.chatInput}>
                        <textarea
                            value={text}
                            onChange={e => setText(e.target.value)}
                            onKeyDown={onKey}
                            placeholder={currentChatId ? "Escribe..." : "Selecciona un chat..."}
                            disabled={sending || !currentChatId}
                            style={styles.textarea}
                        />
                        <button
                            style={styles.sendBtn}
                            onClick={sendMessage}
                            disabled={sending || !currentChatId}
                        >
                            ▶
                        </button>
                    </div>
                </section>
            </div>
        </div>
    )
}

// Reuse styles from existing pages + new ones for sidebar
const styles = {
    h2: {
        fontSize: '32px',
        fontWeight: '700',
        marginBottom: '20px',
        background: 'linear-gradient(135deg, #ffffff 0%, #6a7aae 100%)',
        WebkitBackgroundClip: 'text',
        WebkitTextFillColor: 'transparent',
        backgroundClip: 'text',
        letterSpacing: '-1px',
        textAlign: 'center',
    },
    chatSection: {
        flex: 1,
        display: 'flex',
        flexDirection: 'column',
        background: 'rgba(30, 43, 79, 0.4)',
        backdropFilter: 'blur(10px)',
        borderRadius: '16px',
        border: '1px solid rgba(106, 122, 174, 0.2)',
        overflow: 'hidden',
        boxShadow: '0 8px 32px rgba(0, 0, 0, 0.2)',
    },
    chatScroll: {
        flex: 1,
        padding: '24px',
        overflowY: 'auto',
        display: 'flex',
        flexDirection: 'column',
        gap: '16px',
    },
    msgUser: {
        alignSelf: 'flex-end',
        background: 'linear-gradient(135deg, #4a5a8e 0%, #3a4a7e 100%)',
        color: 'white',
        padding: '12px 18px',
        borderRadius: '18px 18px 2px 18px',
        maxWidth: '80%',
        boxShadow: '0 4px 12px rgba(0,0,0,0.2)',
        fontSize: '15px',
        lineHeight: '1.5',
    },
    msgBot: {
        alignSelf: 'flex-start',
        background: 'rgba(255, 255, 255, 0.1)',
        color: '#e2e8f0',
        padding: '12px 18px',
        borderRadius: '18px 18px 18px 2px',
        maxWidth: '80%',
        border: '1px solid rgba(255, 255, 255, 0.1)',
        fontSize: '15px',
        lineHeight: '1.5',
    },
    chatInput: {
        padding: '16px',
        background: 'rgba(15, 22, 32, 0.3)',
        borderTop: '1px solid rgba(106, 122, 174, 0.2)',
        display: 'flex',
        gap: '12px',
        alignItems: 'center',
    },
    textarea: {
        flex: 1,
        background: 'rgba(255, 255, 255, 0.05)',
        border: '1px solid rgba(106, 122, 174, 0.3)',
        borderRadius: '12px',
        padding: '12px',
        color: 'white',
        fontSize: '14px',
        resize: 'none',
        height: '44px',
        outline: 'none',
        fontFamily: 'inherit',
        transition: 'all 0.2s',
    },
    sendBtn: {
        width: '44px',
        height: '44px',
        borderRadius: '12px',
        border: 'none',
        background: 'linear-gradient(135deg, #6a7aae 0%, #4a5a8e 100%)',
        color: 'white',
        cursor: 'pointer',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        fontSize: '18px',
        transition: 'transform 0.2s',
    },
    typingIndicator: {
        display: 'flex',
        gap: '4px',
        padding: '12px',
        alignSelf: 'flex-start',
        background: 'rgba(255, 255, 255, 0.05)',
        borderRadius: '12px',
    },
    dot: {
        width: '8px',
        height: '8px',
        background: '#a8b2d1',
        borderRadius: '50%',
        animation: 'bounce 1.4s infinite ease-in-out both',
    },

    // Sidebar styles
    chatSidebar: {
        width: '260px',
        background: 'rgba(30, 43, 79, 0.3)',
        borderRadius: '16px',
        border: '1px solid rgba(106, 122, 174, 0.2)',
        display: 'flex',
        flexDirection: 'column',
        overflow: 'hidden',
    },
    newChatBtn: {
        margin: '16px',
        padding: '12px',
        background: 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
        border: 'none',
        borderRadius: '8px',
        color: 'white',
        fontWeight: '600',
        cursor: 'pointer',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        gap: '8px',
        boxShadow: '0 4px 12px rgba(16, 185, 129, 0.3)',
        transition: 'transform 0.1s',
    },
    chatList: {
        flex: 1,
        overflowY: 'auto',
        display: 'flex',
        flexDirection: 'column',
        gap: '4px',
        padding: '0 8px 16px 8px',
    },
    chatItem: {
        padding: '12px 12px',
        borderRadius: '8px',
        cursor: 'pointer',
        color: '#cbd5e1',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        transition: 'background 0.2s',
        fontSize: '14px',
        border: '1px solid transparent',
    },
    chatItemActive: {
        background: 'rgba(106, 122, 174, 0.25)',
        color: 'white',
        borderColor: 'rgba(106, 122, 174, 0.3)',
    },
    chatTitle: {
        overflow: 'hidden',
        textOverflow: 'ellipsis',
        whiteSpace: 'nowrap',
        flex: 1,
        marginRight: '8px',
    },
    deleteBtn: {
        background: 'none',
        border: 'none',
        color: '#ef4444',
        cursor: 'pointer',
        fontSize: '16px',
        opacity: 0.7,
        padding: '4px',
        borderRadius: '4px',
    }
}
