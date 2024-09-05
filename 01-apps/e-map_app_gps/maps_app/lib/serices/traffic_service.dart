import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/models/traffic_response.dart';
import 'package:maps_app/serices/places_interceptor.dart';
import 'package:maps_app/serices/traffic_interceptor.dart';


class TrafficService {

  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService()
    : _dioTraffic = Dio()..interceptors.add( TrafficInterceptor() ),
      _dioPlaces = Dio()..interceptors.add( PlacesInterceptor() ); 


  Future<TrafficResponse> getCoorsStartToEnd( LatLng start, LatLng end ) async {


    final coorsString = '${ start.longitude },${ start.latitude };${ end.longitude },${ end.latitude }';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url); // OJO FALLA ACÀ PORQUE FALTA EL TOKEN

    final data = TrafficResponse.fromMap(resp.data);
    
    return data;

  }

  Future <List<Feature>> getResultsByQuery( LatLng proximity, String query ) async {
    if(query.isEmpty) return [];
    final url = '$_basePlacesUrl/$query.json';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'proximity': '${ proximity.longitude} , ${ proximity.latitude}'
    });

    final placesResponse = PlacesResponse.fromJson(resp.data);
    return placesResponse.features;
  } 

}