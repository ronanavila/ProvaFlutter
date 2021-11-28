import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({Key? key}) : super(key: key);

  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  late CollectionReference tarefas;

  @override
  void initState() {
    super.initState();
    tarefas = FirebaseFirestore.instance.collection('tarefas');
  }

  Widget itemLista(item) {
    String nome = item.data()['nome'];
    return ListTile(
      title: Text(nome, style: const TextStyle(fontSize: 30)),
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            tarefas.doc(item.id).delete();
          }),
      onTap: () {
        Navigator.pushNamed(context, '/inserir', arguments: item.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: tarefas.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                    child: Text('Não foi possível conectar ao Firebase'));

              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              //dados recebidos
              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      return itemLista(dados.docs[index]);
                    });
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/inserir');
        },
      ),
    );
  }
}
