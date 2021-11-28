import 'package:flutter/material.dart';
import 'package:prova/pages/criartarefa_page.dart';
import 'pages/login_page.dart';
import 'pages/create_account.dart';
//import 'package:prova/menu_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/create_account': (context) => const CreateAccountPage(),
        '/inserir': (context) => const CriarTarefa(),
      },
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
