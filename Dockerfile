FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY agent.py tools.py kb.py db.py main.py ui.py ./
COPY kb_articles ./kb_articles

# The database and audit log are written here (mounted as a volume)
RUN mkdir -p /app/data
WORKDIR /app/data

EXPOSE 8000 8501

CMD ["uvicorn", "main:app", "--app-dir", "/app", "--host", "0.0.0.0", "--port", "8000"]
