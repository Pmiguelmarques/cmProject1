import 'package:flutter/material.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/data/model/client.dart';

enum ClientType {client, trainer}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
  
  String firstName = '';
  String lastName = '';
  String userName = '';
  String password = '';

  ClientType? cType = ClientType.client;
  bool isTrainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75),
          Center(
            child: Column(
              children: [
                const Text(
                  'Register your account',
                  style: TextStyle(
                    color: Color.fromRGBO(225, 100, 40,1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      firstName = value;
                    }),
                    decoration: const InputDecoration(
                      hintText: 'First name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      lastName = value;
                    }),
                    decoration: const InputDecoration(
                      hintText: 'Second name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      userName = value;
                    }),
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      password = value;
                    }),
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        color: const Color(0xff94959b),
                        splashRadius: 1,
                        icon: Icon(passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: togglePassword,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      title: const Text("Regular user", style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
                      leading: Radio<ClientType>(
                        activeColor: const Color.fromRGBO(225, 100, 40,1),
                        value: ClientType.client,
                        groupValue: cType,
                        onChanged: (ClientType? value){
                          setState(() {
                            cType = value;
                            isTrainer = false;
                          });
                        }
                      ),
                    ),
                    ListTile(
                      title: const Text("Trainer", style: TextStyle(color: Color.fromRGBO(225, 100, 40,1))),
                      leading: Radio<ClientType>(
                        activeColor: const Color.fromRGBO(225, 100, 40,1),
                        value: ClientType.trainer,
                        groupValue: cType,
                        onChanged: (ClientType? value){
                          setState(() {
                            cType = value;
                            isTrainer = true;
                          });
                        }
                      ),
                    ), 
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                        onPressed: () {
                          if(firstName != "" && lastName != "" && userName != "" && password != "") {
                            addTransaction(firstName, lastName, userName, password, isTrainer);
                          }
                        }, 
                        child: const Text('Register', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                      ),
                    ),
                  ],
                )   
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future addTransaction(String firstName, String lastName, String userName, String password, bool isTrainer) async {

  final client = Client()
  ..firstName = firstName
  ..lastName = lastName
  ..userName = userName
  ..password = password
  ..isTrainer = isTrainer
  ..events = [];

  final box = Boxes.getClients();
  box.put(password, client);

}

