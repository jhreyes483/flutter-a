const { io } = require('../index');
const Bands  = require('../models/bands');
const Band   = require('../models/band');


const bands = new Bands();

bands.addBand( new Band('Queen') );
bands.addBand( new Band('Bon Jovi') );
bands.addBand( new Band('Heroes del Silencio') );
bands.addBand( new Band('Metalica') );

console.log(bands)


// Mensajes de Sockets
io.on('connection', client => {

    client.emit('active-bands', bands.getBands())
    
    console.log('Cliente conectado');

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });

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

    
});
