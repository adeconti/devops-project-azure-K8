FROM python:3.9-slim

WORKDIR /app

COPY app.py .
COPY templates/ templates/

EXPOSE 80

# Execute um servidor web simples que serve o arquivo HTML
CMD ["python", "-m", "http.server", "80"]