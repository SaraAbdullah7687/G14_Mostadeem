import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();

//const fcm = admin.messaging();

// send a notification when request status updated
export const sendToDevice = functions.firestore
  .document('/contributor/{contribId}/request/{reqID}')
  .onUpdate(async (snapshot, context) => {


    const request = snapshot.after.data();

    const querySnapshot = await db
      .collection('contributor')
      .doc(request.contribId)
      .collection('tokens')
      .get();

    const tokens = querySnapshot.docs.map(snap => snap.id);
    if (tokens.length == 0) {
      console.log("No Device");
    } else{
    const payloadData = {
      title: ' Your request has been updated',
      message: 'Please check your requests list',
    };
    const payload = {
      data: payloadData,
    };
    return await admin.messaging().sendToDevice(tokens, payload).then((response) => {
      console.log("Pushed All Notifications");
    });
  }// end else

    /*const payload: admin.messaging.MessagingPayload = {
      notification: {
        title : ' Your request has been updated',
        body : 'Please check your requests list',
       // icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToDevice(tokens, payload).then((response) => {
      console.log("Pushed All Notifications");
    });*/
  });

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
 export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
 });





/*
import * as functions from "firebase-functions"; 
import * as admin from 'firebase-admin'; 
admin.initializeApp(); 
export const sendNotificationToTrainee = functions.firestore.document('Requests/(userid)').onUpdate(async (snapshot, context) =>
 let requestData = snapshot.after.data();
 console.log(`Tid: ${requestData['Tid']}`); 
 let traineeRef = admin.firestore().collection('trainees').doc(requestData['Tid']); 
 let traineeData = (await traineeRef.get()).data(); 
 console.log(`usrData: ${requestData['Status']}`); 
 if (requestData['Status'] == 'D' || requestData['Status'] == 'A') { 
     let tokens = []; 
     console.log(`usrData: ${traineeData}`); 
     console.log(${traineeData["notificationTokens"]}`); 
     if (traineeData['notificationTokens'] != undefined && traineeData['notificationTokens'].length != 0) {
          traineeData['notificationTokens'].forEach((token) => { 
              tokens.push(token); });
          console.log(`Tid: ${requestData['Status']}`); 
          let msg =""; 
          if(requestData['Status'] == "D"){ msg ="yours acccepted !!";
        }else{ msg ="yours rejected !!";}
           // const msg - requestData['Status'] --- 'D' ? 'y go hylb ahds pj' : 'yjI g Jegš ps"; 
           console.log(`Tid: $(msg)`); 
           let payloadData = { 
               title: 'hi', 
               message: msg +' ' + requestData["CoachName"] +' ' + requestData["CoachName2"],
             }; 
             var payload = { data: payloadData, }; 
*/