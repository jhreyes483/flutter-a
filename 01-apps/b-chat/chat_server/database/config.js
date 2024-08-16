const mongoose = require('mongoose');

const dbConnection = async () => {
    console.log('init db config')

        mongoose.Promise = global.Promise;
        mongoose.connect(process.env.DB_CNN2, {
        }).then(() => {
            console.log('La conexion a la base de datos de mongo se ha realizado');

            // Crear el servidor
        }).catch(error => console.log(error));
    console.log('DB Online');
}

module.exports = {
    dbConnection
}
