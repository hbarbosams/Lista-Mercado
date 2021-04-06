import 'package:flutter/material.dart';
import 'package:lista_mercado/views/atualizar.page.dart';
import 'package:lista_mercado/views/lista.page.dart';
import 'package:lista_mercado/views/nova.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //responsável por desenhar na tela do aplicativo.
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      //home: ListaPage(),
      routes: {
        '/' : (context) => ListaPage(),
        '/nova' : (context) => NovaPage(),
        '/atualizar' : (context) => AtualizarPage(),
      },
      initialRoute: '/',
    );
  }
}