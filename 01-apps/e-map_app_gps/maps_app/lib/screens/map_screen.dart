import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';


class MapScreen extends StatefulWidget {

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  void initState(){
    super.initState();
      final locationBloc = BlocProvider.of<LocationBloc>(context); 
      locationBloc.getCurrentPosition();
}

  @override
  Widget build(BuildContext context) {
  return const Scaffold(
      body: Center(
        child: Text('MapScreen'),
      ),
  );
  }

}