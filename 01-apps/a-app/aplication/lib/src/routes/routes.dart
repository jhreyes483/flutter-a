import 'package:aplication/src/pages/home.dart';
import 'package:aplication/src/pages/status.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home'   : (BuildContext context) => HomePage(),
    'status' : (BuildContext context) => StatusPage()
  };
}
