FROM python:3.12-slim

WORKDIR /app

COPY app.py .
COPY test_app.py .

RUN pip install pytest

RUN pytest

CMD ["python", "app.py"]