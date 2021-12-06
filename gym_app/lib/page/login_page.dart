import 'package:flutter/material.dart';
import 'package:gym_app/data/provider.dart';
import 'package:gym_app/page/register_page.dart';
import 'package:gym_app/page/trainer_main_page.dart';
import 'package:gym_app/page/user_main_page.dart';
import 'package:gym_app/widget/boxes.dart';
import 'package:gym_app/data/repository.dart';
import 'package:gym_app/data/repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  bool failedToLog = false;
  String username = "";
  String password = "";
  Repository rep = Repository();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 51, 51,1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Center(
            child: Column(
              children: [
                const Text(
                  'Login to your account',
                  style: TextStyle(
                    color: Color.fromRGBO(225, 100, 40,1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
                const SizedBox(height: 10),
                if(failedToLog)
                  const Text(
                    'Please try again',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
                  ),
                const SizedBox(height: 50),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f1f5),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    onChanged: (value) => setState(() {
                      username = value;
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
                const SizedBox(height: 24),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xff94959b),
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
                const SizedBox(height: 25),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(39, 33, 33,1)),
                    onPressed: (){
                      final client = Boxes.getClient(password);
                      if(client == null){
                        setState(() {
                          failedToLog = true;
                        });
                      }else{
                        setState(() {
                          failedToLog = false;
                        });
                        if(client.userName != username || client.password != password){
                          failedToLog = true;
                        }else{
                          if(client.isTrainer) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TrainerMainPage(trainerPassword: client.password))
                            );
                           }else{
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserMainPage(userPassword: client.password)
                            ));
                          }
                        }
                      }
                    }, 
                    child: const Text('Login', style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)))
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ).copyWith(color: const Color(0xff94959b)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage()));
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Color.fromRGBO(225, 100, 40,1)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

