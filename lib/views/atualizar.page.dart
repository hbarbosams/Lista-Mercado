import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_mercado/models/item.model.dart';
import 'package:lista_mercado/repositories/item.repository.dart';
import 'package:lista_mercado/views/lista.page.dart';


class AtualizarPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItemRepository();
  
  onSave(BuildContext context, Item item) {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.update(_item,item);
      Navigator.of(context).popAndPushNamed('/');
    }
  }

  void alteraDisp(Item item){
    item.disponivel = !item.disponivel;
  }

  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar item'),
        backgroundColor: Colors.green,
        centerTitle: false,
      ),

    body: Container(
      margin: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: item.texto,
              decoration: InputDecoration(
                labelText: 'Item',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _item.texto = value,
              validator: (value) => value.isEmpty ? 'Campo obrigatório' : null,
            ),
            Padding(padding: EdgeInsets.only(top: 16)),
            TextFormField(
              initialValue: item.quantidade,
              decoration: InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
              onSaved: (valor) => _item.quantidade = valor,
              validator: (valor) => valor.isEmpty ? 'Campo obrigatório' : null,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 16)),
            TextButton.icon(
              icon: Icon(Icons.update),
              label: Text('Atualizar'),
              onPressed: () => onSave(context, item),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(15)
              )
            ),
          ],
        ),
      ),
    ));
  }
}