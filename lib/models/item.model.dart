class Item{
  String id;
  String texto;
  String quantidade;
  bool comprado;
  bool disponivel;

  Item({this.id, this.texto, this.quantidade = '1', this.comprado = false, this.disponivel = true});
}