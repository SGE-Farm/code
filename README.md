# SGFarm

## Ambiente de desenvolvimento

O `uv` gerencia as dependências pelo `trabalhoFinal/pyproject.toml`. O Docker usa as mesmas versões registradas em `trabalhoFinal/uv.lock`.

Se o `.env` ainda não existir, copie `.env.example` para `.env` na raiz do repositório. Gere uma chave com `uv run --project trabalhoFinal python -c 'from secrets import token_urlsafe; print(token_urlsafe(48))'` e preencha `DJANGO_SECRET_KEY`. O `.env` é ignorado pelo Git.

Com o Docker e o Docker Compose disponíveis, execute na raiz do repositório:

```bash
docker compose up --build
```

O Django aguarda o PostgreSQL aceitar conexões e aplica as migrações antes de iniciar. Acesse [http://localhost:8000](http://localhost:8000). As alterações em `trabalhoFinal/` são refletidas automaticamente no servidor de desenvolvimento.

Para criar um usuário para o painel em `/admin/`, execute em outro terminal:

```bash
docker compose exec web uv run --no-sync python manage.py createsuperuser
```

Para executar o mesmo comando com `uv` no seu computador, inicie o banco e entre na pasta do Django:

```bash
docker compose up -d --wait db
cd trabalhoFinal
uv run --locked --env-file ../.env python manage.py migrate
uv run --locked --env-file ../.env python manage.py createsuperuser
```

O Django conecta ao banco `sgfarm` em `127.0.0.1:5433` ao rodar com `uv`, ou em `db:5432` dentro do Compose. O usuário e a senha padrão do PostgreSQL são `admin`. O comando `createsuperuser` solicita credenciais próprias para entrar no painel do Django.

O Compose carrega o `.env` da raiz automaticamente. No comando local, `--env-file ../.env` carrega o mesmo arquivo. Para alterar login e senha em um banco já inicializado, atualize também a conta no PostgreSQL. O volume `postgres_data` preserva os dados após `docker compose down`.
