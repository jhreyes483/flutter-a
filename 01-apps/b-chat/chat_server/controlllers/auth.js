const { response } = require('express');
const bcrypt       = require('bcryptjs');

const { validationResult } = require('express-validator');

const Usuario = require('./../models/usuario')

const creaUsuario = async (req, res = response) => {

    const { email, password } = req.body;

    try {
        const existeEmail =await  Usuario.findOne({ email: email });

        if(existeEmail){
            return res.status(400).json({
                ok: false,
                msg: 'El correo ya esta registrado'
            })
        }

        // encriptar contraseña
        const salt = bcrypt.genSaltSync();
        const hashedPassword = bcrypt.hashSync(password, salt);

        const usuario    = new Usuario( req.body );
        usuario.password = hashedPassword;
        console.log(usuario)
        usuario.save(); 
    
    
        res.json({
            ok      : true,
            usuario : usuario
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            ok: false,
            msg: 'error de tipo server'
        })
        
    }

  
}


module.exports = { creaUsuario }