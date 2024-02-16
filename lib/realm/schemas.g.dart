// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Item extends _Item with RealmEntity, RealmObjectBase, RealmObject {
  Item(
    ObjectId id,
    bool isComplete,
    String ownerId,
    String summary,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'isComplete', isComplete);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'summary', summary);
  }

  Item._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  bool get isComplete => RealmObjectBase.get<bool>(this, 'isComplete') as bool;
  @override
  set isComplete(bool value) => RealmObjectBase.set(this, 'isComplete', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  String get summary => RealmObjectBase.get<String>(this, 'summary') as String;
  @override
  set summary(String value) => RealmObjectBase.set(this, 'summary', value);

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObjectBase.getChanges<Item>(this);

  @override
  Item freeze() => RealmObjectBase.freezeObject<Item>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Item._);
    return const SchemaObject(ObjectType.realmObject, Item, 'Item', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('isComplete', RealmPropertyType.bool),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
      SchemaProperty('summary', RealmPropertyType.string),
    ]);
  }
}

class Perfil extends _Perfil with RealmEntity, RealmObjectBase, RealmObject {
  Perfil(
    ObjectId id,
    String tipo, {
    Iterable<String> iDTelas = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Tipo', tipo);
    RealmObjectBase.set<RealmList<String>>(
        this, 'IDTelas', RealmList<String>(iDTelas));
  }

  Perfil._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  RealmList<String> get iDTelas =>
      RealmObjectBase.get<String>(this, 'IDTelas') as RealmList<String>;
  @override
  set iDTelas(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get tipo => RealmObjectBase.get<String>(this, 'Tipo') as String;
  @override
  set tipo(String value) => RealmObjectBase.set(this, 'Tipo', value);

  @override
  Stream<RealmObjectChanges<Perfil>> get changes =>
      RealmObjectBase.getChanges<Perfil>(this);

  @override
  Perfil freeze() => RealmObjectBase.freezeObject<Perfil>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Perfil._);
    return const SchemaObject(ObjectType.realmObject, Perfil, 'Perfil', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('iDTelas', RealmPropertyType.string,
          mapTo: 'IDTelas', collectionType: RealmCollectionType.list),
      SchemaProperty('tipo', RealmPropertyType.string, mapTo: 'Tipo'),
    ]);
  }
}

class Tela extends _Tela with RealmEntity, RealmObjectBase, RealmObject {
  Tela(
    ObjectId id,
    String caminho,
    String caminhoImagem,
    String nome,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Caminho', caminho);
    RealmObjectBase.set(this, 'CaminhoImagem', caminhoImagem);
    RealmObjectBase.set(this, 'Nome', nome);
  }

  Tela._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get caminho => RealmObjectBase.get<String>(this, 'Caminho') as String;
  @override
  set caminho(String value) => RealmObjectBase.set(this, 'Caminho', value);

  @override
  String get caminhoImagem =>
      RealmObjectBase.get<String>(this, 'CaminhoImagem') as String;
  @override
  set caminhoImagem(String value) =>
      RealmObjectBase.set(this, 'CaminhoImagem', value);

  @override
  String get nome => RealmObjectBase.get<String>(this, 'Nome') as String;
  @override
  set nome(String value) => RealmObjectBase.set(this, 'Nome', value);

  @override
  Stream<RealmObjectChanges<Tela>> get changes =>
      RealmObjectBase.getChanges<Tela>(this);

  @override
  Tela freeze() => RealmObjectBase.freezeObject<Tela>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Tela._);
    return const SchemaObject(ObjectType.realmObject, Tela, 'Tela', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('caminho', RealmPropertyType.string, mapTo: 'Caminho'),
      SchemaProperty('caminhoImagem', RealmPropertyType.string,
          mapTo: 'CaminhoImagem'),
      SchemaProperty('nome', RealmPropertyType.string, mapTo: 'Nome'),
    ]);
  }
}

class Usuario extends _Usuario with RealmEntity, RealmObjectBase, RealmObject {
  Usuario(
    ObjectId id,
    String endereco,
    String iDUser,
    String nome,
    String perfil,
    String telefone,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Endereco', endereco);
    RealmObjectBase.set(this, 'IDUser', iDUser);
    RealmObjectBase.set(this, 'Nome', nome);
    RealmObjectBase.set(this, 'Perfil', perfil);
    RealmObjectBase.set(this, 'Telefone', telefone);
  }

  Usuario._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get endereco =>
      RealmObjectBase.get<String>(this, 'Endereco') as String;
  @override
  set endereco(String value) => RealmObjectBase.set(this, 'Endereco', value);

  @override
  String get iDUser => RealmObjectBase.get<String>(this, 'IDUser') as String;
  @override
  set iDUser(String value) => RealmObjectBase.set(this, 'IDUser', value);

  @override
  String get nome => RealmObjectBase.get<String>(this, 'Nome') as String;
  @override
  set nome(String value) => RealmObjectBase.set(this, 'Nome', value);

  @override
  String get perfil => RealmObjectBase.get<String>(this, 'Perfil') as String;
  @override
  set perfil(String value) => RealmObjectBase.set(this, 'Perfil', value);

  @override
  String get telefone =>
      RealmObjectBase.get<String>(this, 'Telefone') as String;
  @override
  set telefone(String value) => RealmObjectBase.set(this, 'Telefone', value);

  @override
  Stream<RealmObjectChanges<Usuario>> get changes =>
      RealmObjectBase.getChanges<Usuario>(this);

  @override
  Usuario freeze() => RealmObjectBase.freezeObject<Usuario>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Usuario._);
    return const SchemaObject(ObjectType.realmObject, Usuario, 'Usuario', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('endereco', RealmPropertyType.string, mapTo: 'Endereco'),
      SchemaProperty('iDUser', RealmPropertyType.string, mapTo: 'IDUser'),
      SchemaProperty('nome', RealmPropertyType.string, mapTo: 'Nome'),
      SchemaProperty('perfil', RealmPropertyType.string, mapTo: 'Perfil'),
      SchemaProperty('telefone', RealmPropertyType.string, mapTo: 'Telefone'),
    ]);
  }
}
