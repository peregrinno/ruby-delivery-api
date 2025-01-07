Os métodos implementados para a API foram organizados em controladores e cobrem as principais operações para o sistema de delivery. Aqui está um resumo das rotas e métodos:

---

### **Autenticação**

1. **Login** (`POST /login`)
   - Autentica o cliente usando **email** e **senha**.
   - Retorna um token JWT válido por 1 hora se as credenciais forem corretas.

---

### **Clientes**

1. **Criar Cliente** (`POST /customers`)
   - Cria um novo cliente com os campos: `name`, `phone`, `email` e `password`.

---

### **Produtos**

1. **Listar Produtos** (`GET /products`)

   - Retorna todos os produtos cadastrados.
2. **Criar Produto** (`POST /products`)

   - Cria um novo produto com os campos: `name` e `price`.

---

### **Ordens**

1. **Criar Ordem** (`POST /orders`)

   - Cria uma nova ordem para um cliente com:
     - `customer_id`
     - `total` (valor total da ordem calculado no frontend ou no backend)
     - `order_date` (data automática gerada pelo sistema).
2. **Listar ordens** (`GET /orders`)

   - Listar ordens

---

### **Atualização da Ordem**

1. **Atualiza status da ordemCriar Detalhe da Ordem** (`PUT /orders/{id}/status`)
   - Atualize uma ordem com:
     - `id` (referência à ordem a ser atualizada).
     - `status` (status a ser definido na ordem).

---

### **Resumo dos Métodos HTTP**

| Método | Endpoint                | Função                                    |
| ------- | ----------------------- | ------------------------------------------- |
| POST    | `/login`              | Autentica o cliente e retorna um token JWT. |
| POST    | `/customers`          | Cria um novo cliente.                       |
| GET     | `/products`           | Retorna a lista de todos os produtos.       |
| POST    | `/products`           | Cria um novo produto.                       |
| POST    | `/orders`             | Cria uma nova ordem para um cliente.        |
| GET     | `/orders`             | Listar ordens                               |
| PUT     | `/orders/{id}/status` | Atualiza status da ordem                    |

---

Essa estrutura cobre as operações principais. Você pode expandir adicionando funcionalidades, como edição ou exclusão de recursos (usando os métodos **PUT** e **DELETE**) ou listagem filtrada, conforme necessário.

# Excução da API

### **Pré-requisitos**

- Instale as dependências do projeto:
  `bundle install`

### **Ubuntu**

- Na raiz do projeto, execute (preferencialmente com sudo):

  `ruby app.rb `
- Em desenvolvimento:

  `rerun app.rb`
