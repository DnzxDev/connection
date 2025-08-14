# 🎁 Basic VIP Item Delivery System - FiveM

This project connects an online store with your FiveM server, enabling automatic delivery of **VIP items** purchased by players.  
It uses a **Node.js** (Express) backend to receive purchase requests and a **Lua** script to add the items directly to the in-game inventory.

---

## 🚀 Technologies Used

### 🖥️ Back-End (Node.js)
- **[Express](https://expressjs.com/)**: Web framework for handling HTTP routes.
- **[body-parser](https://www.npmjs.com/package/body-parser)**: Middleware to parse request body data.
- **[mysql2](https://www.npmjs.com/package/mysql2)**: Modern MySQL client for Node.js.
- **[cors](https://www.npmjs.com/package/cors)**: Middleware to enable CORS requests from external domains.

### 🎮 FiveM Server (Lua)
- Lua script connected to the database and server, responsible for delivering items to players.

---

## 📦 Features

- Secure connection between the website and the server.
- HTTP API to register VIP item purchases.
- Checks if the player exists and delivers items automatically.
- Records all deliveries in the database.
- Optimized for use with custom inventory systems.
