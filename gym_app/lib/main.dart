import 'dart:async';
import 'package:flutter/material.dart';



import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gym_app/model/event.dart';
import 'package:gym_app/model/client.dart';
import 'package:gym_app/model/example.dart';

import 'package:gym_app/widget/boxes.dart';

import 'package:gym_app/page/trainer_event_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:gym_app/page/main_page.dart';
import 'package:gym_app/page/login_page.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(EventAdapter());
  await Hive.openBox<Event>('event');
  

  Hive.registerAdapter(ClientAdapter());
  await Hive.openBox<Client>('client');

  runApp(const MyHome());
}
class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginPage()
      ),
    );
  }
}