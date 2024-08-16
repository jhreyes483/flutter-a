const express = require('express');
const path = require('path');
require('dotenv').config();

// DB Config
const { dbConnection } =require('./database/config').dbConnection();
/*
mongodb+srv://javierreyes:kYX98D2rB6fAlyoW@cluster0.txgwo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
*/

// App de Express
const app = express();

// Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/socket');


// Path público
const publicPath = path.resolve( __dirname, 'public' );
app.use( express.static( publicPath ) );


server.listen( process.env.PORT, ( err ) => {

    if ( err ) throw new Error(err);

    console.log('Servidor corriendo en puerto', process.env.PORT );

});