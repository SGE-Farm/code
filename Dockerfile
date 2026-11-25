FROM python:3.14-slim

COPY --from=ghcr.io/astral-sh/uv:0.10.6 /uv /usr/local/bin/uv

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    UV_PYTHON_DOWNLOADS=never

WORKDIR /app

COPY trabalhoFinal/pyproject.toml trabalhoFinal/uv.lock ./
RUN uv sync --locked --no-install-project --no-cache

COPY trabalhoFinal/ .
