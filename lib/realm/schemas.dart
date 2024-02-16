import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _Item {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late bool isComplete;

  @MapTo('owner_id')
  late String ownerId;

  late String summary;
}

@RealmModel()
class _Perfil {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('IDTelas')
  late List<String> iDTelas;

  @MapTo('Tipo')
  late String tipo;
}

@RealmModel()
class _Tela {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('Caminho')
  late String caminho;

  @MapTo('CaminhoImagem')
  late String caminhoImagem;

  @MapTo('Nome')
  late String nome;
}

@RealmModel()
class _Usuario {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('Endereco')
  late String endereco;

  @MapTo('IDUser')
  late String iDUser;

  @MapTo('Nome')
  late String nome;

  @MapTo('Perfil')
  late String perfil;

  @MapTo('Telefone')
  late String telefone;
}
