// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Capacidade extends _Capacidade
    with RealmEntity, RealmObjectBase, RealmObject {
  Capacidade(
    ObjectId id,
    String capacidade,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Capacidade', capacidade);
  }

  Capacidade._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get capacidade =>
      RealmObjectBase.get<String>(this, 'Capacidade') as String;
  @override
  set capacidade(String value) =>
      RealmObjectBase.set(this, 'Capacidade', value);

  @override
  Stream<RealmObjectChanges<Capacidade>> get changes =>
      RealmObjectBase.getChanges<Capacidade>(this);

  @override
  Capacidade freeze() => RealmObjectBase.freezeObject<Capacidade>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Capacidade._);
    return const SchemaObject(
        ObjectType.realmObject, Capacidade, 'Capacidade', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('capacidade', RealmPropertyType.string,
          mapTo: 'Capacidade'),
    ]);
  }
}

class CapacidadesUsuario extends _CapacidadesUsuario
    with RealmEntity, RealmObjectBase, RealmObject {
  CapacidadesUsuario(
    ObjectId id,
    String iDCapacidade,
    String iDUser,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'IDCapacidade', iDCapacidade);
    RealmObjectBase.set(this, 'IDUser', iDUser);
  }

  CapacidadesUsuario._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get iDCapacidade =>
      RealmObjectBase.get<String>(this, 'IDCapacidade') as String;
  @override
  set iDCapacidade(String value) =>
      RealmObjectBase.set(this, 'IDCapacidade', value);

  @override
  String get iDUser => RealmObjectBase.get<String>(this, 'IDUser') as String;
  @override
  set iDUser(String value) => RealmObjectBase.set(this, 'IDUser', value);

  @override
  Stream<RealmObjectChanges<CapacidadesUsuario>> get changes =>
      RealmObjectBase.getChanges<CapacidadesUsuario>(this);

  @override
  CapacidadesUsuario freeze() =>
      RealmObjectBase.freezeObject<CapacidadesUsuario>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CapacidadesUsuario._);
    return const SchemaObject(
        ObjectType.realmObject, CapacidadesUsuario, 'CapacidadesUsuario', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('iDCapacidade', RealmPropertyType.string,
          mapTo: 'IDCapacidade'),
      SchemaProperty('iDUser', RealmPropertyType.string, mapTo: 'IDUser'),
    ]);
  }
}

class MonitoramentoProduto extends _MonitoramentoProduto
    with RealmEntity, RealmObjectBase, RealmObject {
  MonitoramentoProduto(
    ObjectId id,
    DateTime dataColheita,
    String iDPlanta,
    int quantidadeFrutos,
    String status, {
    Iterable<String> previsoes = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'DataColheita', dataColheita);
    RealmObjectBase.set(this, 'IDPlanta', iDPlanta);
    RealmObjectBase.set(this, 'QuantidadeFrutos', quantidadeFrutos);
    RealmObjectBase.set(this, 'Status', status);
    RealmObjectBase.set<RealmList<String>>(
        this, 'Previsoes', RealmList<String>(previsoes));
  }

  MonitoramentoProduto._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  DateTime get dataColheita =>
      RealmObjectBase.get<DateTime>(this, 'DataColheita') as DateTime;
  @override
  set dataColheita(DateTime value) =>
      RealmObjectBase.set(this, 'DataColheita', value);

  @override
  String get iDPlanta =>
      RealmObjectBase.get<String>(this, 'IDPlanta') as String;
  @override
  set iDPlanta(String value) => RealmObjectBase.set(this, 'IDPlanta', value);

  @override
  RealmList<String> get previsoes =>
      RealmObjectBase.get<String>(this, 'Previsoes') as RealmList<String>;
  @override
  set previsoes(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  int get quantidadeFrutos =>
      RealmObjectBase.get<int>(this, 'QuantidadeFrutos') as int;
  @override
  set quantidadeFrutos(int value) =>
      RealmObjectBase.set(this, 'QuantidadeFrutos', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'Status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'Status', value);

  @override
  Stream<RealmObjectChanges<MonitoramentoProduto>> get changes =>
      RealmObjectBase.getChanges<MonitoramentoProduto>(this);

  @override
  MonitoramentoProduto freeze() =>
      RealmObjectBase.freezeObject<MonitoramentoProduto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MonitoramentoProduto._);
    return const SchemaObject(
        ObjectType.realmObject, MonitoramentoProduto, 'MonitoramentoProduto', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('dataColheita', RealmPropertyType.timestamp,
          mapTo: 'DataColheita'),
      SchemaProperty('iDPlanta', RealmPropertyType.string, mapTo: 'IDPlanta'),
      SchemaProperty('previsoes', RealmPropertyType.string,
          mapTo: 'Previsoes', collectionType: RealmCollectionType.list),
      SchemaProperty('quantidadeFrutos', RealmPropertyType.int,
          mapTo: 'QuantidadeFrutos'),
      SchemaProperty('status', RealmPropertyType.string, mapTo: 'Status'),
    ]);
  }
}

class ObjetosDetectado extends _ObjetosDetectado
    with RealmEntity, RealmObjectBase, RealmObject {
  ObjetosDetectado(
    ObjectId id,
    double height,
    double left,
    double probability,
    String tagName,
    double top,
    double width,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'height', height);
    RealmObjectBase.set(this, 'left', left);
    RealmObjectBase.set(this, 'probability', probability);
    RealmObjectBase.set(this, 'tagName', tagName);
    RealmObjectBase.set(this, 'top', top);
    RealmObjectBase.set(this, 'width', width);
  }

  ObjetosDetectado._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  double get height => RealmObjectBase.get<double>(this, 'height') as double;
  @override
  set height(double value) => RealmObjectBase.set(this, 'height', value);

  @override
  double get left => RealmObjectBase.get<double>(this, 'left') as double;
  @override
  set left(double value) => RealmObjectBase.set(this, 'left', value);

  @override
  double get probability =>
      RealmObjectBase.get<double>(this, 'probability') as double;
  @override
  set probability(double value) =>
      RealmObjectBase.set(this, 'probability', value);

  @override
  String get tagName => RealmObjectBase.get<String>(this, 'tagName') as String;
  @override
  set tagName(String value) => RealmObjectBase.set(this, 'tagName', value);

  @override
  double get top => RealmObjectBase.get<double>(this, 'top') as double;
  @override
  set top(double value) => RealmObjectBase.set(this, 'top', value);

  @override
  double get width => RealmObjectBase.get<double>(this, 'width') as double;
  @override
  set width(double value) => RealmObjectBase.set(this, 'width', value);

  @override
  Stream<RealmObjectChanges<ObjetosDetectado>> get changes =>
      RealmObjectBase.getChanges<ObjetosDetectado>(this);

  @override
  ObjetosDetectado freeze() =>
      RealmObjectBase.freezeObject<ObjetosDetectado>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ObjetosDetectado._);
    return const SchemaObject(
        ObjectType.realmObject, ObjetosDetectado, 'ObjetosDetectado', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('height', RealmPropertyType.double),
      SchemaProperty('left', RealmPropertyType.double),
      SchemaProperty('probability', RealmPropertyType.double),
      SchemaProperty('tagName', RealmPropertyType.string),
      SchemaProperty('top', RealmPropertyType.double),
      SchemaProperty('width', RealmPropertyType.double),
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

class PrevisaoProducao extends _PrevisaoProducao
    with RealmEntity, RealmObjectBase, RealmObject {
  PrevisaoProducao(
    ObjectId id,
    DateTime data,
    String iDProduto,
    int quantiaFrutos,
    String tempoColheita,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Data', data);
    RealmObjectBase.set(this, 'IDProduto', iDProduto);
    RealmObjectBase.set(this, 'QuantiaFrutos', quantiaFrutos);
    RealmObjectBase.set(this, 'TempoColheita', tempoColheita);
  }

  PrevisaoProducao._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  DateTime get data => RealmObjectBase.get<DateTime>(this, 'Data') as DateTime;
  @override
  set data(DateTime value) => RealmObjectBase.set(this, 'Data', value);

  @override
  String get iDProduto =>
      RealmObjectBase.get<String>(this, 'IDProduto') as String;
  @override
  set iDProduto(String value) => RealmObjectBase.set(this, 'IDProduto', value);

  @override
  int get quantiaFrutos =>
      RealmObjectBase.get<int>(this, 'QuantiaFrutos') as int;
  @override
  set quantiaFrutos(int value) =>
      RealmObjectBase.set(this, 'QuantiaFrutos', value);

  @override
  String get tempoColheita =>
      RealmObjectBase.get<String>(this, 'TempoColheita') as String;
  @override
  set tempoColheita(String value) =>
      RealmObjectBase.set(this, 'TempoColheita', value);

  @override
  Stream<RealmObjectChanges<PrevisaoProducao>> get changes =>
      RealmObjectBase.getChanges<PrevisaoProducao>(this);

  @override
  PrevisaoProducao freeze() =>
      RealmObjectBase.freezeObject<PrevisaoProducao>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PrevisaoProducao._);
    return const SchemaObject(
        ObjectType.realmObject, PrevisaoProducao, 'PrevisaoProducao', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('data', RealmPropertyType.timestamp, mapTo: 'Data'),
      SchemaProperty('iDProduto', RealmPropertyType.string, mapTo: 'IDProduto'),
      SchemaProperty('quantiaFrutos', RealmPropertyType.int,
          mapTo: 'QuantiaFrutos'),
      SchemaProperty('tempoColheita', RealmPropertyType.string,
          mapTo: 'TempoColheita'),
    ]);
  }
}

class Producao extends _Producao
    with RealmEntity, RealmObjectBase, RealmObject {
  Producao(
    ObjectId id,
    String descricao,
    String iDUser, {
    ProducaoLocation? location,
    Iterable<String> iDProdutos = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Descricao', descricao);
    RealmObjectBase.set(this, 'IDUser', iDUser);
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set<RealmList<String>>(
        this, 'IDProdutos', RealmList<String>(iDProdutos));
  }

  Producao._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get descricao =>
      RealmObjectBase.get<String>(this, 'Descricao') as String;
  @override
  set descricao(String value) => RealmObjectBase.set(this, 'Descricao', value);

  @override
  RealmList<String> get iDProdutos =>
      RealmObjectBase.get<String>(this, 'IDProdutos') as RealmList<String>;
  @override
  set iDProdutos(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get iDUser => RealmObjectBase.get<String>(this, 'IDUser') as String;
  @override
  set iDUser(String value) => RealmObjectBase.set(this, 'IDUser', value);

  @override
  ProducaoLocation? get location =>
      RealmObjectBase.get<ProducaoLocation>(this, 'location')
          as ProducaoLocation?;
  @override
  set location(covariant ProducaoLocation? value) =>
      RealmObjectBase.set(this, 'location', value);

  @override
  Stream<RealmObjectChanges<Producao>> get changes =>
      RealmObjectBase.getChanges<Producao>(this);

  @override
  Producao freeze() => RealmObjectBase.freezeObject<Producao>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Producao._);
    return const SchemaObject(ObjectType.realmObject, Producao, 'Producao', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('descricao', RealmPropertyType.string, mapTo: 'Descricao'),
      SchemaProperty('iDProdutos', RealmPropertyType.string,
          mapTo: 'IDProdutos', collectionType: RealmCollectionType.list),
      SchemaProperty('iDUser', RealmPropertyType.string, mapTo: 'IDUser'),
      SchemaProperty('location', RealmPropertyType.object,
          optional: true, linkTarget: 'Producao_location'),
    ]);
  }
}

class ProducaoLocation extends _ProducaoLocation
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ProducaoLocation({
    String? type,
    Iterable<double> coordinates = const [],
  }) {
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set<RealmList<double>>(
        this, 'coordinates', RealmList<double>(coordinates));
  }

  ProducaoLocation._();

  @override
  RealmList<double> get coordinates =>
      RealmObjectBase.get<double>(this, 'coordinates') as RealmList<double>;
  @override
  set coordinates(covariant RealmList<double> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
  @override
  set type(String? value) => RealmObjectBase.set(this, 'type', value);

  @override
  Stream<RealmObjectChanges<ProducaoLocation>> get changes =>
      RealmObjectBase.getChanges<ProducaoLocation>(this);

  @override
  ProducaoLocation freeze() =>
      RealmObjectBase.freezeObject<ProducaoLocation>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProducaoLocation._);
    return const SchemaObject(
        ObjectType.embeddedObject, ProducaoLocation, 'Producao_location', [
      SchemaProperty('coordinates', RealmPropertyType.double,
          collectionType: RealmCollectionType.list),
      SchemaProperty('type', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Produto extends _Produto with RealmEntity, RealmObjectBase, RealmObject {
  Produto(
    ObjectId id,
    String iDEspecime,
    String nomePlanta, {
    Iterable<String> previsoes = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'IDEspecime', iDEspecime);
    RealmObjectBase.set(this, 'NomePlanta', nomePlanta);
    RealmObjectBase.set<RealmList<String>>(
        this, 'Previsoes', RealmList<String>(previsoes));
  }

  Produto._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get iDEspecime =>
      RealmObjectBase.get<String>(this, 'IDEspecime') as String;
  @override
  set iDEspecime(String value) =>
      RealmObjectBase.set(this, 'IDEspecime', value);

  @override
  String get nomePlanta =>
      RealmObjectBase.get<String>(this, 'NomePlanta') as String;
  @override
  set nomePlanta(String value) =>
      RealmObjectBase.set(this, 'NomePlanta', value);

  @override
  RealmList<String> get previsoes =>
      RealmObjectBase.get<String>(this, 'Previsoes') as RealmList<String>;
  @override
  set previsoes(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Produto>> get changes =>
      RealmObjectBase.getChanges<Produto>(this);

  @override
  Produto freeze() => RealmObjectBase.freezeObject<Produto>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Produto._);
    return const SchemaObject(ObjectType.realmObject, Produto, 'Produto', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('iDEspecime', RealmPropertyType.string,
          mapTo: 'IDEspecime'),
      SchemaProperty('nomePlanta', RealmPropertyType.string,
          mapTo: 'NomePlanta'),
      SchemaProperty('previsoes', RealmPropertyType.string,
          mapTo: 'Previsoes', collectionType: RealmCollectionType.list),
    ]);
  }
}

class RelatoriosDeteccao extends _RelatoriosDeteccao
    with RealmEntity, RealmObjectBase, RealmObject {
  RelatoriosDeteccao(
    ObjectId id,
    DateTime data,
    String iDProduto,
    String imagemPath,
    String tipoDeteccao, {
    Iterable<String> objetosDetectados = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Data', data);
    RealmObjectBase.set(this, 'IDProduto', iDProduto);
    RealmObjectBase.set(this, 'ImagemPath', imagemPath);
    RealmObjectBase.set(this, 'TipoDeteccao', tipoDeteccao);
    RealmObjectBase.set<RealmList<String>>(
        this, 'ObjetosDetectados', RealmList<String>(objetosDetectados));
  }

  RelatoriosDeteccao._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  DateTime get data => RealmObjectBase.get<DateTime>(this, 'Data') as DateTime;
  @override
  set data(DateTime value) => RealmObjectBase.set(this, 'Data', value);

  @override
  String get iDProduto =>
      RealmObjectBase.get<String>(this, 'IDProduto') as String;
  @override
  set iDProduto(String value) => RealmObjectBase.set(this, 'IDProduto', value);

  @override
  String get imagemPath =>
      RealmObjectBase.get<String>(this, 'ImagemPath') as String;
  @override
  set imagemPath(String value) =>
      RealmObjectBase.set(this, 'ImagemPath', value);

  @override
  RealmList<String> get objetosDetectados =>
      RealmObjectBase.get<String>(this, 'ObjetosDetectados')
          as RealmList<String>;
  @override
  set objetosDetectados(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get tipoDeteccao =>
      RealmObjectBase.get<String>(this, 'TipoDeteccao') as String;
  @override
  set tipoDeteccao(String value) =>
      RealmObjectBase.set(this, 'TipoDeteccao', value);

  @override
  Stream<RealmObjectChanges<RelatoriosDeteccao>> get changes =>
      RealmObjectBase.getChanges<RelatoriosDeteccao>(this);

  @override
  RelatoriosDeteccao freeze() =>
      RealmObjectBase.freezeObject<RelatoriosDeteccao>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RelatoriosDeteccao._);
    return const SchemaObject(
        ObjectType.realmObject, RelatoriosDeteccao, 'RelatoriosDeteccao', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('data', RealmPropertyType.timestamp, mapTo: 'Data'),
      SchemaProperty('iDProduto', RealmPropertyType.string, mapTo: 'IDProduto'),
      SchemaProperty('imagemPath', RealmPropertyType.string,
          mapTo: 'ImagemPath'),
      SchemaProperty('objetosDetectados', RealmPropertyType.string,
          mapTo: 'ObjetosDetectados', collectionType: RealmCollectionType.list),
      SchemaProperty('tipoDeteccao', RealmPropertyType.string,
          mapTo: 'TipoDeteccao'),
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
    String imagemPerfil,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'Endereco', endereco);
    RealmObjectBase.set(this, 'IDUser', iDUser);
    RealmObjectBase.set(this, 'Nome', nome);
    RealmObjectBase.set(this, 'Perfil', perfil);
    RealmObjectBase.set(this, 'Telefone', telefone);
    RealmObjectBase.set(this, 'imagemPerfil', imagemPerfil);
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
  String get imagemPerfil =>
      RealmObjectBase.get<String>(this, 'imagemPerfil') as String;
  @override
  set imagemPerfil(String value) =>
      RealmObjectBase.set(this, 'imagemPerfil', value);

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
      SchemaProperty('imagemPerfil', RealmPropertyType.string),
    ]);
  }
}
