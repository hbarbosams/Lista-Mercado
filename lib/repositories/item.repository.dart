import 'dart:io';

import 'package:lista_mercado/models/item.model.dart';

class ItemRepository{
  static List<Item> itens = List<Item>();

  void create(Item item){
    itens.add(item);
  }

  List<Item> read(){
    List<Item>comprados = [];
    List<Item>ncomprados = [];
    List<Item>resposta = [];
    
    for(Item x in itens){
      if(x.comprado == true){
        comprados.add(x);
      }
      else{
        ncomprados.add(x);
      }
    }

    for(Item x in ncomprados){
      resposta.add(x);
    }

    for(Item x in comprados){
      resposta.add(x);
    }
    
    return resposta;
  }

  void delete(String texto) {
    final item = itens.singleWhere((i) => i.texto == texto);
    itens.remove(item);
  }

  void update(Item novoItem, Item velhoItem) {
    final item = itens.singleWhere((i) => i.texto == velhoItem.texto);

    item.texto = novoItem.texto;
    item.quantidade = novoItem.quantidade;
    item.disponivel = novoItem.disponivel;
  }
}


