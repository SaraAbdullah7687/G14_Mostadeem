//import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

//const db = admin.firestore();

//const fcm = admin.messaging();

// send a notification when request status updated
/*export const sendToDevice = functions.firestore
  .document('contributor/request')
  .onUpdate(async snapshot => {


    const request = snapshot.after.data();

    const querySnapshot = await db
      .collection('contributor')
      .doc(request.contribId)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title : ' Your request has been updated',
        body : 'Please check your requests list',
       // icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });*/

// from FCM tutorial website 
/*export const sendToDeviceFCM = functions.firestore
  .document('orders/{orderId}')
  .onCreate(async snapshot => {


    const order = snapshot.data();

    const querySnapshot = await db
      .collection('users')
      .doc(order.seller)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'New Order!',
        body: `you sold a ${order.product} for ${order.total}`,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    //return fcm.sendToDevice(tokens, payload);
  });

// From Arabic vidio
export const sendToDevice2 = functions.firestore.document('posts/{postID}').onCreate(async snapshot => {
    const querySnapshot = await db.collection('tokens').get();

    const tokens = new Array();

    querySnapshot.forEach(async tokenDoc => {
        tokens.push(tokenDoc.data().token);
      
    });

    const payload : admin.messaging.MessagingPayload = {
        notification : {
            title : ' Your request has been updated',
            body : 'Please check your requests list',
            click_action : 'FLUTTER_NOTIFICATION_CLICK' 
        }
    };

   // return fcm.sendToDevice(tokens , payload);


});// END sendToDevice

// from Firebase youtube
export const onBostonWeatherUpdate = functions.firestore.document ("cities-weather/boston-ma-us").onUpdate(change => { 
  const after = change.after.data() 
  const payload = {
      data: { 
          temp: String(after.temp), 
          conditions: after.conditions
       }}
        return admin.messaging().sendToTopic("weather_boston-ma-us", payload) 
        .catch(error => { console.error("FCM failed", error) 
      })
  })
*/
/*import * as functions from "firebase-functions";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
 export const helloWorld = functions.https.onRequest((request, response) => {
   functions.logger.info("Hello logs!", {structuredData: true});
   response.send("Hello from Firebase!");
 });
 
 */

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
 /*export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
 });
 */
