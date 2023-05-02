import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitwise/Service/api.dart';
import 'package:splitwise/Stores/homeStore.dart';
import 'package:splitwise/Stores/loginStore.dart';

import '../../Models/GroupModel.dart';

class AddNewMembersToGroup extends StatefulWidget {
  static String id = "add_new_members_to_group";
  GroupModel? model;
  AddNewMembersToGroup({Key? key,required this.model}) : super(key: key);

  @override
  State<AddNewMembersToGroup> createState() => _AddNewMembersToGroupState();
}

class _AddNewMembersToGroupState extends State<AddNewMembersToGroup> {
  @override
  int selected = 0;
  Widget build(BuildContext context) {
    var homeStore = context.read<HomeStore>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: (selected == 0)
                            ? Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        )
                            : null,
                      ),
                      child: Text('Scan Code'),
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: (selected == 1)
                            ? Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        )
                            : null,
                      ),
                      child: Text('MyCode'),
                    )),
              ],
            ),
            (selected == 0)
                ? Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(
                  left: 25, right: 25, top: 40, bottom: 15),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QrImage(
                    data: widget.model!.sId!,
                    version: QrVersions.auto,
                    size: 320,
                    gapless: false,
                    embeddedImage: AssetImage(
                        'assets/images/my_embedded_image.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(80, 80),
                    ),
                  ),
                  Text(widget.model!.title!),
                ],
              )
            )
                : QRViewExample(),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late HomeStore homeStore;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void initState() {
    homeStore = context.read<HomeStore>();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  addNewMemberToGroup(String groupId) async {
    String uid = homeStore.uid.value;
    if (await APIService.addNewUserToGroup(groupId, uid) == true) {
      Navigator.pop(context);
    }else{
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) addNewMemberToGroup(result!.code.toString());
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         if (result != null)
          //           Text(
          //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
          //         else
          //           const Text('Scan a code'),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
