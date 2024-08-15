//
import 'dart:io';

import 'package:aplication/src/models/band.dart';
import 'package:aplication/src/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<Band> bands = [];

  /*
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 5),
    Band(id: '3', name: 'Heroes del silencio', votes: 5),
  ];
  */

  @override
  void initState() {
    
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on('active-bands', _handleActiveBands );
    super.initState();
  }

  _handleActiveBands( dynamic payload ) {

    this.bands = (payload as List)
        .map( (band) => Band.fromMap(band) )
        .toList();

    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen:  false);
    socketService.socket.off('active-bands');
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Bandas', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10),
            child: (socketService.serverStatus == ServerStatus.Online ) ? Icon( Icons.check_circle, color: Colors.blue[300]) : Icon( Icons.offline_bolt, color: Colors.red) 
          )
        ],
      ),
      body: Column(
        children: [

          _showGraph(),

          Expanded(
            child: ListView.builder(
            // aca recorre la lista
              itemCount   : this.bands.length,
              itemBuilder : (context, i) => _banTitle(bands[i])),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBans,
      ),
    );
  }

  Widget _banTitle(Band band) {
    final socketService = Provider.of<SocketService>(context, listen:  false);

    final bandName = band?.name ?? 'Unknown';
    final inicialesBand = bandName.substring(0, 2);

    return Dismissible( // esto hace que se quite el item jalando hacia derecha o izquerda
      key        : Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( _ ) => socketService.emit('delete-band', { 'id': band.id } ),
      background : Container(
        padding: EdgeInsets.only(left: 8.0),
        color  :Colors.red,
        child  : Align(
          alignment : Alignment.centerLeft,
          child     : Text('Eliminar banda', style: TextStyle(color: Colors.white) ),
        )
      ),
      child : ListTile(
          leading: CircleAvatar(
            child: Text(inicialesBand),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(bandName),
          trailing: Text(
            '${band.votes}',
            style: TextStyle(fontSize: 20),
          ),
            onTap: () => socketService.emit('vote-band', { 'id': band.id } )
          ),
    );
  }



  addNewBans() {
    final TextEditingController textController = new TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (_) =>  AlertDialog(

            title: Text('Nueva banda'),
            content: TextField(controller: textController),
            actions: <Widget>[
              MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text))
            ],

          )
      );
    }

    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
              title: Text('New band name:'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Dismiss'),
                    onPressed: () => Navigator.pop(context)
                )
              ],
            )
      );
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      final socketService = Provider.of<SocketService>(context, listen:  false);
      socketService.emit('add-band', { 'name': name } );

      //this.bands.add( Band(id: DateTime.now().toString(), name: name  ));
      setState(() {});
    }
    Navigator.pop(context);
    // cierra la alerta
  }

  Widget _showGraph(){
    Map<String, double> dataMap = new Map();
    bands.forEach((band) {
      dataMap.putIfAbsent( band.name, () => band.votes.toDouble() );
    });

/*
  dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };*/


  final List<Color> colorList = [
    Colors.blue[50] ?? Colors.blue,     // Proporciona un valor predeterminado
    Colors.blue[200] ?? Colors.blue,    // Proporciona un valor predeterminado
    Colors.pink[50] ?? Colors.pink,     // Proporciona un valor predeterminado
    Colors.pink[200] ?? Colors.pink,    // Proporciona un valor predeterminado
    Colors.yellow[50] ?? Colors.yellow, // Proporciona un valor predeterminado
    Colors.yellow[200] ?? Colors.yellow // Proporciona un valor predeterminado
  ];

  return  Container(
    padding : EdgeInsets.only(top: 10),
    width   : double.infinity,
    height  : 200,

    child: PieChart(
        dataMap              : dataMap,
        animationDuration    : Duration(milliseconds: 800),
        chartLegendSpacing   : 32,
        chartRadius          : MediaQuery.of(context).size.width / 3.2,
        colorList            : colorList,
        initialAngleInDegree : 0,
        chartType            : ChartType.ring,
        ringStrokeWidth      : 32,
        centerText           : "HYBRID",
        legendOptions : LegendOptions(
          showLegendsInRow : false,
          legendPosition   : LegendPosition.right,
          showLegends      : true,
          legendTextStyle  : TextStyle(
            fontWeight     : FontWeight.bold,
          ),
        ),
        chartValuesOptions : ChartValuesOptions(
          showChartValueBackground    : false,
          showChartValues             : true,
          showChartValuesInPercentage : false,
          showChartValuesOutside      : false,
          decimalPlaces               : 1,
        )
        // gradientList: ---To add gradient colors---
        // emptyColorGradient: ---Empty Color gradient---
      ),
  );
/*
    return PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 20,
        );
        */
  }

}
