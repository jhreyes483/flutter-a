const Usuario = require('../models/usuario')

const usuarioConectado = async ( uid = '' ) => {
    const usuario   = await Usuario.findById(uid);

    usuario.online = true;
    await usuario.save();
}

const usuarioDesconectado = async ( uid = '' ) => {
    const usuario   = await Usuario.findById(uid);

    usuario.online = false;
    await usuario.save();
}

module.exports = {
    usuarioConectado, 
    usuarioDesconectado
}