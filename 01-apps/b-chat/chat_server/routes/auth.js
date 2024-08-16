/*
    path: api/login
*/
const { Router, response } = require('express');
const { check }            = require('express-validator');

const { creaUsuario }      = require('../controlllers/auth');
const { validarCampos } = require('../middlewares/validar-cambpos');

const router               = Router();


router.post('/new', [
    check('nombre','El nombre es requerido').not().isEmpty(),
    check('password','La contraseña es requerida').not().isEmpty(),
    check('email','El correo esta en formato incorrecto').isEmail(),
    validarCampos
], creaUsuario);


module.exports = router;

