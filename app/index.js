const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send(`CloudCart sample app — Hello from ${os.hostname()}`);
});

// simple health endpoint for ALB
app.get('/health', (req, res) => res.status(200).send('OK'));

// basic metrics endpoint (not Prometheus; just a placeholder)
app.get('/metrics', (req, res) => {
    res.send('# HELP app_dummy_total A dummy metric\napp_dummy_total 1\n');
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});
