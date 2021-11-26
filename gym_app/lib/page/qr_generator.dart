import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: QrImage(
          data: "dota",
          version: QrVersions.auto,
          size: 250.0,
        ),
      ),
    );
  }
}