const { response }  = require('express');
const { validarGoogleIdToken } = require('../helpers/google-verify-token');


const googleAuth = async ( req , res = response ) => {
    const token = req.body.token;
    if(!token){
        return res.json({
            ok: false,
            msg: 'No hay token en la petición'
        });
    }
    const googleUser = validarGoogleIdToken(token);

    res.json({
        ok: true,
        token
    });
}

module.exports = {  googleAuth };