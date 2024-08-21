const Usuario = require('../models/usuario')
const Mensaje = require('../models/mesaje');

const usuarioConectado = async ( uid ='' ) => {
    console.log(uid);
    const usuario   = await Usuario.findById(uid);
    console.log(usuario)

    usuario.online = true;
    await usuario.save();
}

const usuarioDesconectado = async ( uid = '' ) => {
    const usuario   = await Usuario.findById(uid);

    usuario.online = false;
    await usuario.save();
}

const grabarMensaje = async( payload ) => {
    /*
    {
        de:'',
        para:'',
        texto:''
    }
    */

    try {

        const mensaje = Mensaje(payload);
        await mensaje.save();

    } catch (error) {
        return false
    }
} 

module.exports = {
    usuarioConectado, 
    usuarioDesconectado,
    grabarMensaje 
}