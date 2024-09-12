const { response }  = require('express');


const googleAuth = ( req , res = response ) => {
    const token = req.body.token;
    if(!token){
        return res.json({
            ok: false,
            msg: 'No hay token'
        });
    }

    res.json({
        ok: true,
        token
    });
}

module.exports = {  googleAuth };