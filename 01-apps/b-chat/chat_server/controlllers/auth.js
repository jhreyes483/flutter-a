const { response } = require('express');
const { validationResult } = require('express-validator');

const Usuario = require('./../models/usuario')

const creaUsuario = async (req, res = response) => {

    const { email } = req.body;

    try {
        const existeEmail =await  Usuario.findOne({ email: email });

        if(existeEmail){
            return res.status(400).json({
                ok: false,
                msg: 'El correo ya esta registrado'
            })
        }

        const usuario = new Usuario(req.body);
        usuario.save(); 
    
        res.json({
            ok   : true,
            body : usuario
        });

    } catch (error) {
        // console.log(error);
        res.status(500).json({
            ok: false,
            msg: 'error de tipo server'
        })
        
    }

  
}


module.exports = { creaUsuario }