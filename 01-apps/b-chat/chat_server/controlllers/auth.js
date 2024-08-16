const { response } = require('express');
const bcrypt       = require('bcryptjs');

const { validationResult } = require('express-validator');

const Usuario = require('./../models/usuario');
const { generarJWT } = require('../helpers/jwt');

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
        const usuario    = new Usuario( req.body );

        // encriptar contraseña
        const salt       = bcrypt.genSaltSync();  
        usuario.password = bcrypt.hashSync(password, salt);
        console.log(usuario)

        usuario.save(); 

        // Generar my JWT
        const token = await generarJWT( usuario.id );
        
        res.json({
            ok : true,
            usuario,
            token
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