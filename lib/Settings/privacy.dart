import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);
  static String id = 'privacy';
  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.03 * height,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              SizedBox(
                height: 0.03625 * height,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    height: 0.07 * width,
                    width: 0.087 * width,
                    child: Image.asset('images/Vector16.png'),
                  ),
                  SizedBox(
                    width: 0.0833 * width,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Privacy',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              SizedBox(
                height: 0.033 * height,
              ),
              Container(
                width: 0.855 * width,
                height: 0.08125 * height,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  ),
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 0.0555 * width,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          child: Container(
                            height: 0.04 * width,
                            width: 0.02 * width,
                            child: Image.asset('images/Vector17.png'),
                          ),
                        ),
                        SizedBox(
                          width: 0.055 * width,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03625 * height,
              ),
              Container(
                width: 0.855 * width,
                height: 0.08125 * height,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                  ),
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 0.0555 * width,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          child: Container(
                            height: 0.04 * width,
                            width: 0.02 * width,
                            child: Image.asset('images/Vector17.png'),
                          ),
                        ),
                        SizedBox(
                          width: 0.055 * width,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
