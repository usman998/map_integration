import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

// import 'package:google_maps/google_maps.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {


  static const LatLng _center = const LatLng(24.94235843065317, 67.04104091500756);

  late GoogleMapController _controller;

  final CameraPosition initialCameraPosition = CameraPosition(target: LatLng(24.942382751111072, 67.04100872849946), zoom: 11);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
        ),
        Container(
          height: 300,
          width: double.infinity,
          color: Colors.black,
          child: GoogleMap(
            onMapCreated: (controller){
              setState(() {
                _controller = controller ;
              });
            },
            initialCameraPosition: initialCameraPosition,
            mapType: MapType.normal,
            onTap: (coordinates){
              _controller.animateCamera(CameraUpdate.newLatLng(coordinates));
            },
          ),
        )
      ],
    );
  }
}
