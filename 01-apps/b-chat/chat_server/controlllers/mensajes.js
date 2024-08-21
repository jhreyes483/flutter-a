const Mensaje = require('../models/mesaje');

const obtenerChat = async (req, res) => {

    const miId      = req.uid;
    const mensajeDe = req.params.de;


    const last30    = await Mensaje.find({
        $or : [{de: miId, para: mensajeDe }, {de: mensajeDe, para: miId}]
    })
    .sort({ createdAt: 'desc' })
    .limit(30);

    res.json({
        ok: true,
        miId: miId,
        mensajes: last30,
        mensajeDe ,
        msg: 'Hola mensajes'
    });    
}

module.exports = {
    obtenerChat
}