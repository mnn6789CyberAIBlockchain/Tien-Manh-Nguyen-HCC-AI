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
DOCS_DIR = "docs"
CHROMA_DIR = "chroma_db"
COLLECTION_NAME = "mybistro_docs"

# -----------------------------
# Read all .txt documents
# -----------------------------
def read_docs():
    docs = []

    if not os.path.exists(DOCS_DIR):
        raise FileNotFoundError(f"Docs folder not found: {DOCS_DIR}")

    for filename in os.listdir(DOCS_DIR):
        if filename.endswith(".txt"):
            filepath = os.path.join(DOCS_DIR, filename)

            with open(filepath, "r", encoding="utf-8") as f:
                text = f.read().strip()

            if text:
                docs.append({
                    "id": filename,
                    "text": text,
                    "source": filename
                })

    return docs

# -----------------------------
# Split text into chunks
# -----------------------------
def chunk_text(text, chunk_size=500, overlap=100):
    chunks = []
    start = 0

    while start < len(text):
        end = start + chunk_size
        chunk = text[start:end].strip()

        if chunk:
            chunks.append(chunk)

        start += chunk_size - overlap

    return chunks

# -----------------------------
# Gemini embedding function
# -----------------------------
def get_embedding(text):
    response = genai.embed_content(
        model="models/gemini-embedding-001",
        content=text,
        task_type="retrieval_document"
    )
    return response["embedding"]

# -----------------------------
# Build vector database
# -----------------------------
def build_db():
    print("Loading documents...")
    docs = read_docs()
    print(f"Loaded {len(docs)} documents.")

    if len(docs) == 0:
        raise ValueError("No .txt documents found inside the docs folder.")

    chroma_client = chromadb.PersistentClient(path=CHROMA_DIR)

    # Delete old collection if it already exists
    try:
        chroma_client.delete_collection(COLLECTION_NAME)
        print(f"Deleted old collection: {COLLECTION_NAME}")
    except Exception:
        pass

    collection = chroma_client.create_collection(name=COLLECTION_NAME)

    total_chunks = 0

    for doc in docs:
        chunks = chunk_text(doc["text"])

        for i, chunk in enumerate(chunks):
            chunk_id = f"{doc['id']}_chunk_{i}"
            embedding = get_embedding(chunk)

            collection.add(
                ids=[chunk_id],
                embeddings=[embedding],
                documents=[chunk],
                metadatas=[{"source": doc["source"]}]
            )

            total_chunks += 1

    print(f"Created {total_chunks} chunks.")
    print("Vector DB created successfully.")

# -----------------------------
# Main
# -----------------------------
if __name__ == "__main__":
    build_db()