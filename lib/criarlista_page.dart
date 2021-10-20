import 'package:flutter/material.dart';

import 'menu_page.dart';

class CriarLista extends StatefulWidget {
  const CriarLista({Key? key}) : super(key: key);

  @override
  _CriarListaState createState() => _CriarListaState();
}

String usuario = '';
String senha = '';

class _CriarListaState extends State<CriarLista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Criar Lista",
        ),
        iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {})
        ],
      ),
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
                  // ignore: prefer_const_constructors
                  TextField(
                    onChanged: (text) {
                      usuario = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Nome da Lista',
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextField(
                    onChanged: (text) {
                      usuario = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Item da lista',
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 60,
                  ),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MenuPage()));
                      },
                      child: const Text('Voltar')),
                ],
              ),
            )),
      ),
    );
  }
}
