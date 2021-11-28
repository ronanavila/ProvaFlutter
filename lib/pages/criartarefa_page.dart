import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prova/pages/tarefas_page.dart';

import 'menu_page.dart';

class CriarTarefa extends StatefulWidget {
  const CriarTarefa({Key? key}) : super(key: key);

  @override
  _CriarTarefaState createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<CriarTarefa> {
  var txtNome = TextEditingController();

  getDocumentById(id) async {
    await FirebaseFirestore.instance
        .collection('tarefas')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtNome.text.isEmpty) {
        getDocumentById(id);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Criar Tarefa",
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
                    controller: txtNome,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Nome da Tarefa',
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  ElevatedButton(
                      onPressed: () {
                        if (id == null) {
                          criarTarefa(txtNome);
                        } else {
                          atualizarTarefa(txtNome.text, id.toString());
                        }
                      },
                      child: const Text('Salvar')),
                  const SizedBox(
                    height: 30,
                  ),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MenuPage()));
                      },
                      child: const Text('Menu')),
                ],
              ),
            )),
      ),
    );
  }

  void criarTarefa(nome) {
    FirebaseFirestore.instance
        .collection('tarefas')
        .add({'nome': txtNome.text});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Tarefa criada com sucesso.'),
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MenuPage()));
  }

  void atualizarTarefa(nome, id) {
    FirebaseFirestore.instance
        .collection('tarefas')
        .doc(id)
        .set({'nome': txtNome.text});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Tarefa atualizada com sucesso.'),
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ListaTarefas()));
  }
}
