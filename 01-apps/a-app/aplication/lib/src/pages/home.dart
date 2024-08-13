//
import 'dart:io';

import 'package:aplication/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 5),
    Band(id: '3', name: 'Heroes del silencio', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Bandas nombre 222', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          // aca recorre la lista
          itemCount: bands.length,
          itemBuilder: (context, i) => _banTitle(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBans,
      ),
    );
  }

  Widget _banTitle(Band band) {
    final bandName = band?.name ?? 'Unknown';
    final inicialesBand = bandName.substring(0, 2);

    return Dismissible( // esto hace que se quite el item jalando hacia derecha o izquerda
      key        : Key(band.id),
      direction  : DismissDirection.startToEnd,
      background : Container(
        color  :Colors.red,
        child  : Text('Delete Band'),
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
          onTap: () {
            /// esto es como el onClick
            print(band.name);
          }),
    );
  }

  addNewBans() {
    final TextEditingController textController = new TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name'),
            content: TextField(controller: textController),
            actions: <Widget>[
              MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text))
            ],
          );
        },
      );
    }

    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
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
            );
          }
      );
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add( Band(id: DateTime.now().toString(), name: name  ));
      setState(() {});
    }
   Navigator.pop(context);
    // cierra la alerta
  }

}
