// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prova/pages/create_account.dart';
import 'package:prova/pages/menu_page.dart';
import 'package:prova/pages/sobre_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

var txtUser = TextEditingController();
var txtPassword = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Image.asset('assets/images/Icon-192.png'),
                  // ignore: prefer_const_constructors
                  TextField(
                    controller: txtUser,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // ignore: prefer_const_constructors
                  TextField(
                    controller: txtPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        login(txtUser.text, txtPassword.text);
                      },
                      child: Text('Entrar')),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateAccountPage()));
                      },
                      child: Text('Criar Conta')),
                  SizedBox(
                    height: 15,
                  ),
                  IconButton(
                    icon: const Icon(Icons.info),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SobrePage()));
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void login(email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MenuPage()));
    }).catchError((erro) {
      var mensagem = '';
      if (erro.code == 'iser-not-found') {
        mensagem = 'ERRO: Usuário não encontrado';
      } else if (erro.code == 'wrong-password') {
        mensagem = 'ERRO: ERRO: Usuário ou Senha incorreta';
      } else if (erro.code == 'invalid-email') {
        mensagem = 'ERRO: Usuário ou Senha incorreta';
      } else {
        mensagem = erro.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensagem), duration: Duration(seconds: 2)));
    });
  }
}
