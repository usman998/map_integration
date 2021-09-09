import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:map_testing/services/getlocation.dart';
import 'package:geolocator/geolocator.dart';


// import 'package:google_maps/google_maps.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();

}


class _MainScreenState extends State<MainScreen> {
  // set initialcameraposition(LatLng initialcameraposition) {}



  // static const LatLng _center = const LatLng(24.94235843065317, 67.04104091500756);
  //
  // late GoogleMapController _controller;
  //
  // late CameraPosition initialCameraPosition = CameraPosition(target: LatLng(24.942382751111072, 67.04100872849946), zoom: 19);

  // getLatLong()async{
  //   GetLocation _getLocation = GetLocation();
  //   await _getLocation.getCurrentLocation();
  //   return LatLng(_getLocation.latitude,_getLocation.longitude);
  // }
  //  var latitude;
  //  var longitude;

  // set initialcameraposition(LatLng initialcameraposition) {}
  // getLatLong(){
  //   Position position =  Geolocator.getCurrentPosition() as Position;
  // latitude = position.latitude;
  // longitude = position.longitude;
  // }

  LatLng _initialcameraposition = LatLng(24.942382751111072, 67.04100872849946);
  late GoogleMapController _controller;
  Location _location = Location();

  // late LatLng changePosition;


  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude! ),zoom: 15),
        ),
      );
    });
  }

  bool textFieldFocus = false;
  @override
  Widget build(BuildContext context) {
    bool isKeyboard = MediaQuery.of(context).viewInsets.bottom !=0;
    return Column(
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
        Container(
        height: 50,
        color: Colors.white30,
        width: double.infinity,
        ),
        Container(
          width: double.infinity,
          height: textFieldFocus == false ? 300 : 200,
          // child: GoogleMap(
          //   onMapCreated: (controller){
          //     setState(() {
          //       _controller = controller ;
          //     });
          //   },
          //   initialCameraPosition: initialCameraPosition,
          //   mapType: MapType.normal,
          //   onTap: (coordinates){
          //     _controller.animateCamera(CameraUpdate.newLatLng(coordinates));
          //   },
          // ),
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
          ),
        ),
        // Container(
        //   height: 300,
        //   width: double.infinity,
        //   // child: GoogleMap(
        //   //   onMapCreated: (controller){
        //   //     setState(() {
        //   //       _controller = controller ;
        //   //     });
        //   //   },
        //   //   initialCameraPosition: initialCameraPosition,
        //   //   mapType: MapType.normal,
        //   //   onTap: (coordinates){
        //   //     _controller.animateCamera(CameraUpdate.newLatLng(coordinates));
        //   //   },
        //   // ),
        //   child: GoogleMap(
        //     initialCameraPosition: CameraPosition(target: _initialcameraposition),
        //     mapType: MapType.normal,
        //     onMapCreated: _onMapCreated,
        //     myLocationEnabled: true,
        //   ),
        // ),
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
                    onTap: (){
                      setState(() {
                        textFieldFocus = true;
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
                onPressed: (){
                  setState(() {
                    textFieldFocus = false;
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
    );
  }
}
