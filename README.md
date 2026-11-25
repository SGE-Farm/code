# SGFarm

## Ambiente de desenvolvimento

Com o Docker e o Docker Compose disponíveis, execute na raiz do repositório:

```bash
docker compose up --build
```

O Django aguarda o PostgreSQL aceitar conexões e aplica as migrações antes de iniciar. Acesse [http://localhost:8000](http://localhost:8000). As alterações em `trabalhoFinal/` são refletidas automaticamente no servidor de desenvolvimento.

Para criar um usuário para o painel em `/admin/`, execute em outro terminal:

```bash
docker compose exec web python manage.py createsuperuser
```

Para executar o mesmo comando com `uv` no seu computador, inicie o banco e entre na pasta do Django:

```bash
docker compose up -d --wait db
cd trabalhoFinal
uv run python manage.py migrate
uv run python manage.py createsuperuser
```

O Django conecta ao banco `sgfarm` em `127.0.0.1:5433` ao rodar com `uv`, ou em `db:5432` dentro do Compose. O usuário e a senha padrão do PostgreSQL são `admin`. O comando `createsuperuser` solicita credenciais próprias para entrar no painel do Django.

Para personalizar o banco antes da primeira inicialização, defina `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD` ou `POSTGRES_PORT` em um arquivo `.env` na raiz. Se usar esse arquivo com `uv`, acrescente `--env-file ../.env` após `uv run`. Para alterar login e senha em um banco já inicializado, atualize também a conta no próprio PostgreSQL. O volume `postgres_data` preserva os dados após `docker compose down`.
