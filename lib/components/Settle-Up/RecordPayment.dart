import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:splitwise/Service/api.dart';

class RecordPayment extends StatefulWidget {
  String ower;
  String owerid;
  String borrowerid;
  String groupId;
  String borrower;
  num value;
  static String id="record_payment";
  RecordPayment({Key? key,required this.value,required this.ower, required this.borrower,required this.groupId,required this.borrowerid,required this.owerid}) : super(key: key);

  @override
  State<RecordPayment> createState() => _RecordPaymentState();
}

class _RecordPaymentState extends State<RecordPayment> {
  TextEditingController? controller;
  Razorpay razorpay = new Razorpay();


  void handlerPaymentSuccess() async {
    if(await APIService.settleUp(widget.groupId, widget.borrowerid, widget.owerid, widget.value)) Navigator.pop(context);
    print('Payment Successful');
  }

  void handlerErrorFailure(){
    print('Payment Failed');
  }

  void handlerExternalWallet(){
    print('External Wallet');
  }
  String razorpayAPIKey = 'rzp_test_vNCy1VlDnvuQlI';
  void openCheckOut(){
    var options = {
      "key": razorpayAPIKey,
      "amount": controller!.text+"00",
      "name": widget.borrower,
      "description": "Payment of pending dues",
      "external": {
        "wallets": ["paytm"],
      },
    };
    try{
      razorpay.open(options);
    }
    catch(err){
      print(err.toString());
    }
  }
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value.toString()); // Access the passed value from the widget
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close),
        ),
        title: Text("Record a Payment"),
        actions: [
          GestureDetector(
            onTap: (){
              openCheckOut();
            },
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.check),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.borrower+" paid "+widget.ower,style: TextStyle(color: Colors.grey,fontSize: 18),),
            SizedBox(height: 40,),
            Container(
              width: 100,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
