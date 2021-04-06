import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_mercado/models/item.model.dart';
import 'package:lista_mercado/repositories/item.repository.dart';

class NovaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItemRepository();

  onSave(BuildContext context) {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Novo item'),
        centerTitle: false,
      ),

      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _item.texto = value,
                validator: (value) => value.isEmpty ? 'Campo Obrigatório' : null,
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _item.quantidade = value,
                validator: (value) => value.isEmpty ? 'Campo Obrigatório' : null,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              TextButton.icon(
                icon: Icon(Icons.add),
                label: Text('Adicionar'),
                onPressed: () => onSave(context),
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

      ),
    );
  }
}