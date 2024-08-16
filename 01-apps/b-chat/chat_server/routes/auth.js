/*
    path: api/login
*/
const { Router }           = require('express');
const { check }            = require('express-validator');

const { creaUsuario, login } = require('../controlllers/auth');
const { validarCampos }      = require('../middlewares/validar-cambpos');

const router               = Router();


router.post('/new', [
    check('nombre','El nombre es requerido').not().isEmpty(),
    check('password','La contraseña es requerida').not().isEmpty(),
    check('email','El correo esta en formato incorrecto').isEmail(),
    validarCampos
], creaUsuario);

router.post('/', [
    check('email','El correo esta en formato incorrecto').isEmail(),
    check('password','La contraseña es requerida').not().isEmpty(),
    validarCampos
], login);


module.exports = router;

