import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtCPF = TextEditingController();
  var txtTelefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cadastro de Usuários'),
          centerTitle: true,
          backgroundColor: Colors.blue),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtNome,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtCPF,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'CPF',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtTelefone,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Telefone',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtEmail,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w300),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: txtSenha,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Senha',
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: const Text('criar'),
                    onPressed: () {
                      createAccount(txtNome.text, txtCPF.text, txtTelefone.text,
                          txtEmail.text, txtSenha.text);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: const Text('cancelar'),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  //
  // CRIAR CONTA no Firebase Auth
  //
  void createAccount(nome, cpf, telefone, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário criado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }).catchError((erro) {
      if (erro.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ERRO: O email informado já está em uso.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ERRO: ${erro.message}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }
}
