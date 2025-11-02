
const cors = require('cors');
const express =require('express')
const app = express();
const Router = require('./routes/router')
app.use(cors());
const db =require('./dbconfig/config');
const body_parser = require('body-parser');
app.use(body_parser.json());
app.use('/',Router);
const createUser = require('./services/createuser')
const port = 3500;
app.get('/',(req,res)=>{
    res.send("Hi This is My Own Server");
})
app.listen(port,'0.0.0.0',()=>{
    console.log(`MY SErVER IS RUNNING ON PORT ${port}`);
})