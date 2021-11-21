

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner_app/components/advancedAlert.dart';
//import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:qr_scanner_app/services/database.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({ Key key }) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  GlobalKey qrKey= GlobalKey();
  var qrText="";
  QRViewController controller;
  Barcode myBarcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack (children: <Widget>[
        
          QRView(key: qrKey,
          overlay: QrScannerOverlayShape(
            borderRadius: 10,
            borderColor: Colors.green[800],
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 300,

          ),
          onQRViewCreated:onQRViewCreate,),
        
        Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height:MediaQuery.of(context).size.height * .2, // maybe width
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(48, 126, 80, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight:Radius.circular(40), 
        ),
        
    ),
    child: Center(
      child: Text(qrText!=""? "Scan result: $qrText":"Scan the QR code", style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.orange, // added 
              ),
            ),
    ),
  ),
  ),
 /*       Expanded(
          
          flex:1,
          child: Container(
            //color: Color.fromRGBO(48, 126, 80, 1),
             decoration: BoxDecoration(
        color: new Color.fromRGBO(48, 126, 80, 0.2),
        borderRadius: BorderRadius.all(
        Radius.circular(10.0) //                 <--- border radius here
    ),
      ),
            child: Center(
              child:Text("Scan result: $qrText", style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Colors.orange[700], // added 
            ),
          ),
            ),
          )),
*/
      ],),
      
    );
  }
 @override
  void reassemble() {
    super.reassemble();
    controller.pauseCamera();
    
  }
  @override
  void dispose() {
    controller.dispose();
    qrText="";
    super.dispose();
  }

  void onQRViewCreate(QRViewController controller,) {
    this.controller=controller;
    print(" 111111 in print stm"); 
    controller.scannedDataStream.listen((scanData) async { // check status first 
                                                           // ( status == used ) then display(This QR has been used)
                                                           // else display(Amount is)
                                                           // then change status
     // myBarcode=scanData;
      
      String dataScanned=scanData.code;       
      //print(dataScanned + " in print stm");                                              
      String status= await database().checkStatus(dataScanned);
      print("status is $status");
      if(status == "valid"){
      setState(() {
        print("in valid setState");
        qrText="Amount is "+database().convertToList(dataScanned)[1]+" SR"; // amount 
      });
     /*    showDialog(
                    context: context,
                    builder: (BuildContext context) {
return    
AdvanceCustomAlertNew(
icon: Icons.check,
msgContent:qrText,
btnContent:"Ok",
btnColor:Colors.orange[700],
backGCircle: Color.fromRGBO(48, 126, 80, 1),
press: (){Navigator.of(context).pop();}
);
                    });
      */
      database().updateCodeStatus(dataScanned, DateTime.now()); // .code 
      }
      else // status == used
      {
        setState(() {
          print("in used setState");
        qrText="This QR has been used!!";
      });
        /* showDialog(
                    context: context,
                    builder: (BuildContext context) {
return    
AdvanceCustomAlertNew(
icon: Icons.error_outline,
msgContent:qrText,
btnContent:"Ok",
btnColor:Colors.red[600],
backGCircle: Colors.red[600],
press: (){Navigator.of(context).pop();}
);
                    });
     */
      }
     await Future.delayed(const Duration(seconds: 5), (){
       setState(() {
         qrText="";
       });
     });

    });
  }



}