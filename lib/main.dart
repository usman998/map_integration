import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_testing/mainScreen.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      home : HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child : AppBar(
            flexibleSpace: Container(
              color: Colors.blueAccent  ,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: (){
                  print('for closing drawer');
                },
                icon: Icon(Icons.help),
                iconSize: 40,
              ),
            ),
          ),
        ),
        body: MainScreen(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 15,
                  color: Colors.black.withOpacity(1),
                )
              ]
          ),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: ()=>print('nav bar btn'), icon: Icon(Icons.favorite)),
              IconButton(onPressed: ()=>print('nav bar btn'), icon: Icon(Icons.call)),
              IconButton(onPressed: ()=>print('nav bar btn'), icon: Icon(Icons.map)),
              IconButton(onPressed: ()=>print('nav bar btn'), icon: Icon(Icons.people)),

            ],
          ),
        ),
        drawer: buildDrawer(context),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueAccent,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left:20, top: 20),
          child: ListView(
            children: <Widget>[
                Container(
                  height: 80,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10,top: 20,bottom: 20),
                        child: Text(
                          'Side-Bar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10,top: 20,bottom: 20),
                        child: IconButton(
                         onPressed: (){
                           print('for closing drawer');
                           Navigator.pop(context);
                         },
                          icon: Icon(Icons.close),
                          iconSize: 20,
                        )
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    print('first listile');
                  },
                  leading: Icon(Icons.people),
                  title: Text(
                    'Account',
                     style: TextStyle(
                       fontSize: 30
                     ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}


// AIzaSyDRUCkSVuBu29xd8F2d-XffLros0q6YVNg

