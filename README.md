# Peregrinno's Delivery API

API REST para sistema de delivery desenvolvida com Ruby e Sinatra, usando MongoDB Atlas.

## Tecnologias

- Ruby 3.3.0
- Sinatra
- MongoDB Atlas
- JWT
- Swagger/OpenAPI
- BCrypt

## Instalação

1. Instale as dependências:
   bash
   bundle install

2. Configure o ambiente:

```bash
cp .env.example .env
```

3. Execute o servidor:

```bash
# Produção
ruby app.rb

# Desenvolvimento
bundle exec rerun 'ruby app.rb'
```

## Documentação

Acesse: `http://localhost:4567/api-docs`

## Rotas

### Autenticação

- `POST /first-user` - Cria primeiro admin
- `POST /auth/login` - Login admin
- `POST /auth/customer/login` - Login cliente

### Cliente

- `POST /customer/register` - Registro
- `GET /customer/orders` - Lista pedidos
- `POST /customer/orders` - Cria pedido

### Admin

- `GET /admin/users` - Lista usuários
- `POST /admin/users` - Cria usuário
- `PUT /admin/users/:id` - Atualiza usuário
- `DELETE /admin/users/:id` - Remove usuário
- `GET /admin/products` - Lista produtos
- `POST /admin/products` - Cria produto
- `PUT /admin/products/:id` - Atualiza produto
- `DELETE /admin/products/:id` - Remove produto
- `GET /admin/orders` - Lista pedidos
- `PUT /admin/orders/:id/status` - Atualiza status

### Público

- `GET /products` - Lista produtos

## Status dos Pedidos

- Em analise
- Em preparo
- Pronto
- Enviado
- Entregue
- Cancelado

## Autenticação

Inclua o token JWT no header:

```bash
Authorization: Bearer seu_token_aqui
```

## Variáveis de Ambiente (.env)

```
MONGODB_URI=mongodb+srv://...
MONGODB_TEST_URI=mongodb+srv://...
MONGODB_PROD_URI=mongodb+srv://...
JWT_SECRET=sua_chave_jwt
SESSION_SECRET=sua_chave_session
API_NAME=Delivery API
CORS_URL=http://localhost:3000
```

## Estrutura

```
delivery-api/
├── src/
│   ├── config/      # Configurações
│   ├── controllers/ # Controladores
│   ├── lib/         # Bibliotecas
│   ├── middlewares/ # Middlewares
│   ├── models/      # Modelos
│   └── routes/      # Rotas
├── views/           # Views
├── .env.example     # Template
├── app.rb          # Principal
└── swagger.yml     # Docs
```
