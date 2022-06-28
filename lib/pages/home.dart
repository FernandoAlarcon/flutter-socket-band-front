import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vs_code/models/band.dart';

//import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Malambito Efectivo', votes: 5),
    Band(id: '2', name: 'La Quemona', votes: 7),
    Band(id: '3', name: 'La Mua', votes: 2),
    Band(id: '4', name: 'Braulio', votes: 9),
    Band(id: '5', name: 'La viuda del pescao', votes: 6),
    Band(id: '6', name: 'Las rubias de oro', votes: 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Band Names',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          elevation: 1),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, int i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        print(' direction: $direction ');
        print(' id: ${ band.id } ');
        // TODO: llamar al server
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.8 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar ${band.name}', style:TextStyle( color: Colors.white ) ),
          )
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          ' ${band.votes} ',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        }, 
      )
    );
  }

  addNewBand() {

    final textController = new TextEditingController();

    if( Platform.isAndroid ){
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('New band names:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.green,
                onPressed: () => addBandToList(textController.text)
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band name'),
          content: CupertinoTextField(
            controller : textController
          ),
          actions: <Widget> [
            CupertinoDialogAction(
              isDefaultAction: true,
              child:Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child:Text('Dissmis'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );
    
  }// END addNewBand

  void addBandToList( String name ) {

    print(name);
    if( name.length > 1 ){
      this.bands.add( new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }///END addBandToList
}
