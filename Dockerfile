
# Fixing the Dockerfile to expose a TCP port
# Added EXPOSE directive to expose port 8000

FROM python:3.11

ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN python3 -m pip install --upgrade pip "poetry==1.5.1"
RUN poetry config virtualenvs.create false --local
COPY pyproject.toml poetry.lock ./
RUN poetry install

COPY mysite .

EXPOSE 8000  # Expose port 8000 for listening TCP connections

CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
