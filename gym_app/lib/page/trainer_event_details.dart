import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/logic/qr_check/qr_check_bloc.dart';
import 'package:gym_app/logic/qr_check/qr_check_event.dart';
import 'package:gym_app/logic/qr_check/qr_check_state.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';

class TrainerEventDetails extends StatelessWidget {

  const TrainerEventDetails({
    Key?key,
    required this.eventName
  }) : super(key: key);

  final String eventName;


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(39, 33, 33,1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(225, 100, 40,1)
        ),
      ),
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: Center(
        child: SizedBox(
          width: 250,
          height: 75,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QRViewExample(name: eventName)
              ));
            }, 
            child: const Text('Check participant QRcode', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
          ),
        )
      )
    );
  }
}


class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key, required this.name}) : super(key: key);

  final String name;
  
  @override
  State<StatefulWidget> createState() => _QRViewExampleState(name: name);
}

class _QRViewExampleState extends State<QRViewExample> {

  _QRViewExampleState({required this.name});

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final name;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrCheckBloc(),
      child: BlocListener<QrCheckBloc, QrCheckState>(
        listener: (context, state){
          if(state.status == QrCheckStatus.success){
            print('cota');
          }else if(state.status ==QrCheckStatus.denied){
            print('aiiiiee');
          }
        },
        child: BlocBuilder<QrCheckBloc, QrCheckState>(
          builder: (context, state){
            if(result != null){
              print(result.toString());
              context.read<QrCheckBloc>().add(QrFound(result: result!.code));
            }
            return Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(flex: 4, child: _buildQrView(context)),
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (result != null)
                            Text('${result!.code}')
                          else
                            const Text('Scan a code'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}