FROM python:3.10-slim

WORKDIR /app

COPY app.py .

RUN pip install Flask

EXPOSE 80

CMD ["python", "app.py"]
