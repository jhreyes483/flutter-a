// mateapp
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


import 'package:estados/pages/pagina1_page.dart';
import 'package:estados/pages/pagina2_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'pagina1',
      /*
      forma normal
      routes: {
        'pagina1': (_) => Pagina1Page(),
        'pagina2': (_) => Pagina2Page()
      },
      */
      // forma con getx
      getPages: [
        GetPage(name: '/pagina1', page: () => Pagina1Page() ),
        GetPage(name: '/pagina2', page: () => Pagina2Page() )
      ],
    );
  }
}