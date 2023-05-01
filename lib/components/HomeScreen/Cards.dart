import 'package:flutter/material.dart';

class CardOne extends StatefulWidget {
  const CardOne({Key? key}) : super(key: key);

  @override
  State<CardOne> createState() => _CardOneState();
}

class _CardOneState extends State<CardOne> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width / 2 - 40,
                child: Column(
                  children: [
                    Text(
                      "You Have Multiple promos ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 2 - 30,
                child: Image.asset(""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardTwo extends StatefulWidget {
  const CardTwo({Key? key}) : super(key: key);

  @override
  State<CardTwo> createState() => _CardTwoState();
}

class _CardTwoState extends State<CardTwo> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey.shade800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: (width - 75) / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "4",
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Feilds",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Container(
              width: (width - 75) / 4,
              child: Image.asset(""),
            ),
          ],
        ),
      ),
    );
  }
}

class CardThree extends StatefulWidget {
  const CardThree({Key? key}) : super(key: key);

  @override
  State<CardThree> createState() => _CardThreeState();
}

class _CardThreeState extends State<CardThree> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.grey.shade800,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width - 50,
                child: SizedBox(
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardFour extends StatefulWidget {
  const CardFour({Key? key}) : super(key: key);

  @override
  State<CardFour> createState() => _CardFourState();
}

class _CardFourState extends State<CardFour> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 25, 15, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Row(
          children: [
            Text("Around You", style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
