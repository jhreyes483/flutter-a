// 83
const jwt        = require('jsonwebtoken');


const generarJWT = ( uid ) => {


    return new Promise( (resolve, reject) => {

        payload = {
            uid
        }
    
        jwt.sign(payload, process.env.JWT_KEY, {
            expiresIn: '48h'
        }, (err, token) => {
            if(err){
                // no se creo el toquen
                reject('No sepudo generar el JWT')
            }else{
                resolve(token)
            }
        });
    });

} 

const comprobarJWT = ( token = '') => {
    try{
        const { uid } = jwt.verify(token, process.env.JWT_KEY);
        return [true, uid]
    } catch(error){
        return [false, null]
    }
}



module.exports = { generarJWT, comprobarJWT }