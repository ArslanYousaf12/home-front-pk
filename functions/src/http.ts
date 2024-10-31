import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();


export const basicHTTP = functions.https.onRequest((request, response) => {
    response.send("Hello from Firebase!");
});