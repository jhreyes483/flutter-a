const { response } = require('express');
const bcrypt       = require('bcryptjs');
// 84
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

const login = async (req, res = response) => {
    try {
        const { email, password } = req.body;

        const usuarioDB =await  Usuario.findOne({ email: email });
        if(!usuarioDB){
            return res.status(404).json({
                ok : false,
                msg: 'Email no encontrado'
            });
        }
        // validar password
        validPassword = bcrypt.compareSync( password, usuarioDB.password );
        if(!validPassword){
            return res.status(400).json({
                ok : false,
                msg: 'Credenciales incorrectas'
            });
        }

        // Generar my JWT
        const token = await generarJWT( usuarioDB.id );

        res.json({
            ok : true,
            usuario: usuarioDB,
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


const renewToken = async (req, res = response) => {
    // 86
    const uid   = req.uid;
    const token = await generarJWT(uid);

    try{

        const usuario =await  Usuario.findById(uid);
        if( !usuario ){
            return res.status(401).json({
                ok:false,
                msg:'Usuario no existe'
            })
        }
        res.json({
            ok: true,
            usuario,
            token
        });

    }catch(err){
        res.status(500).json({
            ok: false,
            msg: 'error de tipo server'
        })
    }
}

module.exports = { creaUsuario, login,  renewToken }