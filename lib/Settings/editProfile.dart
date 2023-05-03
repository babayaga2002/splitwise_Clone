import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splitwise/Stores/loginStore.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static String id = 'edit_profile';
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  late LoginStore loginStore;

  @override
  void initState(){
    super.initState();
    loginStore=context.read<LoginStore>();
  }
  @override
  XFile? _image;
  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
      if (_image != null)
        loginStore.saveImageToPrefernces(_image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
      if (_image != null)
        loginStore.saveImageToPrefernces(image!.path);
    });
  }

  final ImagePicker _picker = ImagePicker();
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            color: Colors.grey,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ListTile(
                    leading: new Icon(
                      Icons.photo_library,
                      color: Colors.white,
                    ),
                    title: new Text(
                      'Photo Library',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                    ),
                    title: new Text(
                      'Camera',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                    tileColor: Color(0xff3D83C3),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Observer(builder: (context) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.01 * height,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 20),
                  child: Text(
                    "Edit Account",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Container(
                  color: Colors.grey.shade800,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundImage: (_image == null &&
                                        loginStore.image.value == "")
                                    ? null
                                    : FileImage((_image!=null)?File(_image!.path):
                                        File(loginStore.image.value),
                                      ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: -20,
                                  child: RawMaterialButton(
                                    constraints: BoxConstraints(
                                      minHeight: 45,
                                    ),
                                    onPressed: () {
                                      _showPicker(context);
                                    },
                                    elevation: 2.0,
                                    fillColor: Color(0xff3D83C3),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(9.0),
                                    shape: CircleBorder(),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Name',
                    style: TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                  subtitle: Text(
                    "${loginStore.name.value}",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
