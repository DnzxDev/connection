const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const app = express();
const PORT = 8080;
var cors = require('cors');
app.use(cors());
app.use(bodyParser.json());


const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root', 
  password: '', 
  database: 'fivem'
});


app.post('/addVehicle', (req, res) => {
    const { discordId, carro } = req.body;

    if (!discordId || !carro) {
        return res.status(400).json({ message: 'Precisa da porra do discord id e do vehicle' });
    }
    TriggerEvent('website:Addcar', discordId, carro);

    return res.status(200).json({ message: `Veículo ${carro} adicionado para o usuário ${discordId}` });
});


app.post('/addHome', (req, res) => {
    const { discordId, home } = req.body;

    if (!discordId || !home) {
        return res.status(400).json({ message: 'Precisa da porra do discord id e do home' });
    }
    TriggerEvent('website:AddHome', discordId, home);

    return res.status(200).json({ message: `Casa ${home} adicionada para o usuário ${discordId}` });
});


app.post('/setVip', (req, res) => {
    const { discordId, index } = req.body;

    if (!discordId || !index) {
        return res.status(400).json({ message: 'Precisa da porra do discord id' });
    }
    TriggerEvent('website:SetVip', discordId, index);

    return res.status(200).json({ message: `VIP ${index} definido para o usuário ${discordId}` });
});


app.get('/bannedRecords', (req, res) => {
    const query = 'SELECT * FROM banned_records'; 

    connection.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Erro ao acessar os dados do banco de dados', error: err });
        }

        return res.status(200).json(results);
    });
});

app.get('/getIdentities', (req, res) => {
    const query = 'SELECT * FROM user_identities';

    connection.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Erro ao acessar os dados do banco de dados', error: err });
        }

        return res.status(200).json(results);
    });
});

app.listen(PORT, () => {
    console.log(`Servidor API rodando na porta ${PORT}`);
});
