// @dart=2.9

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/services/base.dart';
import 'package:map_testing/mainScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http ;
import 'package:geocoder/geocoder.dart';
import 'package:map_testing/services/Network.dart';


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
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng _initialcameraposition = LatLng(24.942382751111072, 67.04100872849946);
  GoogleMapController _controller;
  Location _location = Location();

  // late LatLng changePosition;


  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude ),zoom: 15),
        ),
      );
    });
  }
  Future<dynamic> getCityWeather(dynamic cityName) async {
    NetworkHelper network = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=8dcf2f5e718575040563de1034de3823&units=metric');
    var result = await network.getloc();
    return result;
  }

  var latString = '';
  var longString = '' ;

  String addressText = '';


  String seacrhAddress = '';


  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=0;
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
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
              onTap: ()=> FocusScope.of(context).unfocus(),
              child:  Column(
                children: <Widget>[
                  if(!isKeyboard)Container(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Your Location',
                        style: TextStyle(
                          fontSize: 50,
                          letterSpacing: -4,
                        ),

                      ),
                    ),
                  ),
                  if(!isKeyboard)Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      '$addressText',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: isKeyboard==true ? 200 : 300 ,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 15),
                      mapType: MapType.normal,
                      // onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      onCameraMove: (CameraPosition position){
                        setState(() {
                          _initialcameraposition = position.target;
                        });
                      },
                      onTap: (coordinates)async{
                        var cordinates = new Coordinates(coordinates.latitude, coordinates.longitude);
                        var addresses = await Geocoder.local.findAddressesFromCoordinates(cordinates);
                        var first = addresses.first;
                        print(" ${first.addressLine}");
                        print(first);
                        setState(() {
                          // latString = coordinates.latitude.toString();
                          // longString = coordinates.longitude.toString();
                          addressText = first.addressLine;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Icon(Icons.search, size: 25,),
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black
                              ),
                            onChanged: (value){
                              setState(() {
                                seacrhAddress = value;
                              });
                            },
                              decoration: InputDecoration(
                                hintText: 'Seacrh location',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                // prefixIcon: SvgPicture.asset("assets/search.svg"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55, right: 55),
                    child: Material(
                        color: Colors.white30,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        elevation: 5,
                        child: MaterialButton(
                          onPressed: ()async{
                               var adress2 = await getCityWeather(seacrhAddress);
                               setState(() {
                                 print(adress2["coord"]["lat"]);
                                 print(adress2["coord"]["lon"]);
                                 _initialcameraposition = LatLng(adress2["coord"]["lat"], adress2["coord"]["lon"]);
                               });
                            },
                          minWidth:150,
                          height: 42.0,
                          child: Text(
                            'Proceed with assistance',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        )
                    ),
                  )
                ],
              ),
          ),
        ),
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
          height: 60,
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

