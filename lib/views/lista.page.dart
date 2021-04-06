import 'dart:html';
import 'package:flutter/material.dart';
import 'package:lista_mercado/models/item.model.dart';
import 'package:lista_mercado/repositories/item.repository.dart';


class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repository = ItemRepository();

  List<Item> itens;

  @override
  initState() {
    super.initState();
    this.itens = repository.read();
  }

  Future addItem(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    if(result == true) {
      setState(() {
        this.itens = repository.read();
      });
    }
  }

  Future<bool> confirmarDelTodos(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirmar a exclusão de todos os itens?"),
          actions: [
            TextButton(
              child: Text("Não"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () => setState(() {for(Item x in itens){ repository.delete(x.texto); } this.itens = repository.read();
              Navigator.of(context).pop(true);})
            ),
          ],
        );
      }
    );
  }

  Future updateItem(BuildContext context, List<Item> item) async {
    var result = await Navigator.of(context).pushNamed('/atualizar', arguments: item);
    if(result == true) {
      setState(() {
        this.itens = repository.read();
      });
    }
  }

  Future<bool> confirmarExclusao(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirmar a exclusão?"),
          actions: [
            TextButton(
              child: Text("Não"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      }
    );
  }

  Future<bool> confirmarAtualizar(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: Text("Atualizar o item?"),
          actions: [
            TextButton(
              child: Text("Não"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      }
    );
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Lista Mercado"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete_forever),
          onPressed: () => setState(() => confirmarDelTodos(context)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (_, indice) {
          var item = itens[indice];
          return Dismissible(
            key: UniqueKey(), 
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left : 16),
              child: Icon(Icons.delete, color: Colors.white),
              color: Colors.redAccent
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right : 16),
              child: Icon(Icons.update_rounded, color: Colors.white,),
              color: Colors.lightBlue
            ),
            onDismissed: (direction) {
              if(direction == DismissDirection.startToEnd){
                repository.delete(item.texto);
                setState(() => this.itens.remove(item));
              }
              else if(direction == DismissDirection.endToStart) {
                Navigator.of(context).pushNamed('/atualizar', arguments: item);
              }
            },
            confirmDismiss: (direction) {
              if(direction == DismissDirection.startToEnd){
                return confirmarExclusao(context);
              }
              else if(direction == DismissDirection.endToStart){
                return confirmarAtualizar(context);
              }
            },
            
            child: CheckboxListTile(
              title: Container(alignment: Alignment.center ,child: Row(
                children: [
                  Text(
                    item.texto,
                    style: TextStyle(
                      decoration: item.comprado
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                      color: item.comprado
                      ? Colors.red
                      : Colors.black
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right : 16)),
                ],
              )),
              secondary: CircleAvatar(child: Text(item.quantidade), backgroundColor: item.comprado ? Colors.red : Colors.green,) ,
              value: item.comprado,
              onChanged: (value) {
                setState(() { item.comprado = value; this.itens = repository.read(); });
              },
              activeColor: item.comprado
              ? Colors.red
              : Colors.green
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add_shopping_cart),
        onPressed: () => addItem(context)
      )
    );
  }
}