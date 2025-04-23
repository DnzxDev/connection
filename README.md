# 🎁 Sistema de Entrega de Itens VIP - FiveM

Este projeto conecta um site de compras com seu servidor FiveM, permitindo a entrega automática de **itens VIP** adquiridos pelos jogadores. Ele utiliza um back-end em **Node.js** (Express) para receber os pedidos e um script em **Lua** para adicionar os itens diretamente ao inventário no servidor.

---

## 🚀 Tecnologias Utilizadas

### 🖥️ Back-End (Node.js)
- **[Express](https://expressjs.com/)**: Framework web para lidar com rotas HTTP.
- **[body-parser](https://www.npmjs.com/package/body-parser)**: Middleware para ler dados do corpo das requisições.
- **[mysql2](https://www.npmjs.com/package/mysql2)**: Cliente MySQL moderno para Node.js.
- **[cors](https://www.npmjs.com/package/cors)**: Middleware para habilitar requisições CORS de domínios externos.

### 🎮 FiveM Server (Lua)
- Script em Lua conectado ao banco de dados e ao servidor, responsável por entregar os itens aos jogadores.

---

## 📦 Funcionalidades

- Conexão segura entre o site e o servidor.
- API HTTP para registrar compras de itens VIP.
- Verificação de existência do jogador e entrega automatizada.
- Registro em banco de dados das entregas realizadas.
- Otimizado para uso com inventários customizados.
