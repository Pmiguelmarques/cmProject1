import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/data/model/client.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/page/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gym_app/data/provider.dart';

Future main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.connect();
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
      home: LoginPage(),
    );
  }
}