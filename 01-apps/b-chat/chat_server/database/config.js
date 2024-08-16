const mongoose = require('mongoose');

const dbConnection = async () => {
    console.log('init db config')
    try {
        mongoose.Promise = global.Promise;
        mongoose.connect(process.env.DB_CNN2, {
        }).then(() => {
            console.log('La conexion a la base de datos de mongo se ha realizado');

            // Crear el servidor
            app.listen(port, () => {
                console.log('el servidor esta corriendo perfectamente http://localhost:3999 esta funcionando');
            })

        }).catch(error => console.log(error));

    } catch (error) {
        console.error('Error al conectar con la base de datos:', error);
    }

    console.log('DB Online');


}

module.exports = {
    dbConnection
}
