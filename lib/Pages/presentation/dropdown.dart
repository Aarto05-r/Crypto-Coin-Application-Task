import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({Key key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDown'),
      ),
      body: Center(
        child: Container(
          height: 300.0,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30.0),
          // color: Colors.white,
          child: DropdownButton<String>(
            value: dropdownValue,
            items: [
              DropdownMenuItem(
                child: Text('One'),
                value: 'One',
              ),
              DropdownMenuItem(
                child: Text('Two'),
                value: 'Two',
              ),
              DropdownMenuItem(
                child: Text('Three'),
                value: 'Three',
              ),
            ],
            onChanged: (value) {
              setState(() {
                dropdownValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
