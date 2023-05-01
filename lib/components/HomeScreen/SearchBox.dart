import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String _selected = '';
  List<String> _items = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: GestureDetector(
          onTap: () {
            showModal(context);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey.shade800,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: (_selected != "")
                      ? Text("$_selected",style: TextStyle(color: Colors.white,fontSize: 20),)
                      : Text("Select Feild",style:TextStyle(color: Colors.white,fontSize: 20),),
                ),
                SizedBox(width: 20,),
                Icon(Icons.arrow_drop_down_sharp,size: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff232932),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            height: 250,
            child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (context, int) {
                  return Divider(
                    thickness: 2,
                    color: Colors.grey,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Center(child: Text(_items[index],style: TextStyle(color: Colors.white,fontSize: 30),)),
                      onTap: () {
                        setState(() {
                          _selected = _items[index];
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
