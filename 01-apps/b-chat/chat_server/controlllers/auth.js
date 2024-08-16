const { response } = require('express');
const { validationResult } = require('express-validator');

const creaUsuario = (req, res = response) => {

    const errores =  validationResult(req);

    if(!errores.isEmpty()){
        return res.status(400).json({
            ok: false,
            errores: errores.mapped()
        })
    }

    res.json({
        ok: true,
        msg: 'Crear usuario'
    });
}


module.exports = { creaUsuario }