/*
    path: api/usuarios
*/
const { Router }           = require('express');
const { validarJWT }       = require('../middlewares/validar-jwt');
const { getUsuarios }      = require('../controlllers/usuarios');

const router               = Router();




router.get('/', validarJWT, getUsuarios);


module.exports = router;