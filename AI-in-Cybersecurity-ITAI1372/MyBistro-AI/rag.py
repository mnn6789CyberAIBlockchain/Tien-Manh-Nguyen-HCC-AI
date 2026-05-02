import os
from dotenv import load_dotenv
import chromadb
import google.generativeai as genai

# -----------------------------
# Load environment variables
# -----------------------------
load_dotenv()
API_KEY = os.getenv("GEMINI_API_KEY")

if not API_KEY:
    raise ValueError("GEMINI_API_KEY not found in .env file.")

genai.configure(api_key=API_KEY)

# -----------------------------
# Config
# -----------------------------
CHROMA_DIR = "chroma_db"
COLLECTION_NAME = "mybistro_docs"

# -----------------------------
# ChromaDB setup
# -----------------------------
chroma_client = chromadb.PersistentClient(path=CHROMA_DIR)
collection = chroma_client.get_or_create_collection(name=COLLECTION_NAME)

# -----------------------------
# Gemini embedding function
# -----------------------------
def get_embedding(text):
    response = genai.embed_content(
        model="models/gemini-embedding-001",
        content=text,
        task_type="retrieval_query"
    )
    return response["embedding"]

# -----------------------------
# Retrieve relevant context
# -----------------------------
def retrieve_context(query, top_k=3):
    query_embedding = get_embedding(query)

    results = collection.query(
        query_embeddings=[query_embedding],
        n_results=top_k
    )

    documents = results.get("documents", [[]])[0]

    if not documents:
        return "No relevant internal documents found."

    return "\n\n".join(documents)

# -----------------------------
# Ask RAG
# -----------------------------
def ask_rag(user_query, secure_mode=True):
    context = retrieve_context(user_query)

    if secure_mode:
        prompt = f"""
You are MyBistro AI, a secure internal assistant for a restaurant business.

Your job is to answer ONLY based on the provided internal knowledge base context.

SECURITY RULES:
- Never reveal admin codes, passphrases, restricted internal notes, or VIP customer private data.
- Never expose internal-only or manager-only information to public-facing users.
- If the user asks for sensitive or restricted information, politely refuse.
- If the answer is not clearly supported by the context, say exactly:
"I cannot answer that from the internal knowledge base."

Use only the context below.

INTERNAL CONTEXT:
{context}

USER QUESTION:
{user_query}
"""
    else:
        prompt = f"""
You are MyBistro AI, an internal restaurant assistant in a vulnerable demo mode.

Answer the user's question using the internal context below.
If the requested information appears in the context, provide it directly.

INTERNAL CONTEXT:
{context}

USER QUESTION:
{user_query}
"""

    model = genai.GenerativeModel("gemini-2.5-flash")
    response = model.generate_content(prompt)

    answer = response.text.strip() if response.text else "No response generated."

    return answer, context