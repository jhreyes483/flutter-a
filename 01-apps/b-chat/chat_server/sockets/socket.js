const { io } = require('../index');
const { comprobarJWT } = require('../helpers/jwt');

/*
const Bands  = require('../models/bands');
const Band   = require('../models/band');
const bands = new Bands();

bands.addBand( new Band('Queen') );
bands.addBand( new Band('Bon Jovi') );
bands.addBand( new Band('Heroes del Silencio') );
bands.addBand( new Band('Metalica') );

console.log(bands)
*/

// Mensajes de Sockets
io.on('connection', client => {

    console.log('Cliente conectado');
    
    const [valido,uid] = comprobarJWT(client.handshake.headers['x-token']);
    console.log(valido, uid);

    if(!valido){
        return client.disconnect();
    }

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });
    console.log('cliente autenticado')

/*
    client.emit('active-bands', bands.getBands())
    
    console.log('Cliente conectado');



    client.on('mensaje', ( payload ) => {
        console.log('Mensaje', payload);

        io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );

    });

    client.on('emitir-mensaje',(payload) => {
        // io.emit('nuevo-mensaje',payload) // emite a todas
        client.broadcast.emit('nuevo-mensaje',payload); // emite solo a todos menos el que lo emitio  
    })

    client.on('vote-band',(payload) => {
        bands.voteBand(payload.id);
        io.emit('active-bands', bands.getBands());
        console.log('vote-band', payload)
    })

    client.on('add-band',(payload) => {
        const newBand = new Band(payload.name)
        bands.addBand(newBand)
        io.emit('active-bands', bands.getBands());
        console.log('add band ok');
    });



    client.on('delete-band',(payload) => {
        bands.deleteBand(payload.id)
        console.log(bands)
        io.emit('active-bands', bands.getBands());
        console.log('delete band ok');
    });
    */
});
