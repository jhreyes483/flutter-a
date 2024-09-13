const { OAuth2Client } = require('google-auth-library');
const CLIENT_ID = '621528570083-mrk4bjumb5kv4c0gaf88sgctshfdv5ja.apps.googleusercontent.com';

const client = new OAuth2Client(CLIENT_ID);

const validarGoogleIdToken = async ( token ) => {

    try {
        const ticket = await client.verifyIdToken({
            idToken: token,
            audience: [
                CLIENT_ID,
                //'372165893061-lpvt6d5mc2dqhmkjb32p1r0r1hd18kr9.apps.googleusercontent.com',
                '621528570083-erd27a795dcf3bgl6821jq804kqi0b5f.apps.googleusercontent.com' // debe ser el de https://console.cloud.google.com/apis/credentials?project=flutter-signin-6510d
            ],  
        });
        const payload = ticket.getPayload();

        console.log('============ PAYLOAD ============= ');
        console.log( payload );
    
        return {
            name: payload['name'],
            picture: payload['picture'],
            email: payload['email'],
        }
    } catch (error) {
        return null;
    }

   
}

module.exports = {
    validarGoogleIdToken
}
