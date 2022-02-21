import 'dart:async';

import 'package:cryptoapp/Pages/presentation/bitcoin_picker.dart';
import 'package:flutter/material.dart';

class Mode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
          theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
          home: Dark(snapshot.data)),
    );
  }
}

class Dark extends StatelessWidget {
  final bool darkThemeEnabled;

  Dark(this.darkThemeEnabled);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => BitCoin()))),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Dark Theme"),
            trailing: Switch(
              value: darkThemeEnabled,
              onChanged: bloc.changeTheme,
            ),
          ),
          ListTile(
            title: Text("Android View"),
            trailing: Switch(
              value: null,
              onChanged: null,
            ),
          )
        ],
      ),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();

//Using Stateful

// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() {
//     return new MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   bool darkTheme = false;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("App"),
//         ),
//         body: Center(),
//         drawer: Drawer(
//           child: ListView(
//             children: <Widget>[
//               ListTile(
//                 title: Text("Dark Theme"),
//                 trailing: Switch(
//                   value: darkTheme,
//                   onChanged: (changed) {
//                     setState(() {
//                       darkTheme = changed;
//                     });
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       theme: darkTheme ? ThemeData.dark() : ThemeData.light(),
//     );
//   }
// }