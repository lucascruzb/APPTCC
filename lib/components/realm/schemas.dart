import 'package:realm/realm.dart';

part 'schemas.g.dart';

// NOTE: These models are private and therefore should be copied into the same .dart file.

@RealmModel()
class _Capacidade {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('Capacidade')
  late String capacidade;
}

@RealmModel()
class _CapacidadesUsuario {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('IDCapacidade')
  late String iDCapacidade;

  @MapTo('IDUser')
  late String iDUser;
}

@RealmModel()
class _MonitoramentoProduto {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('DataColheita')
  late DateTime dataColheita;

  @MapTo('IDPlanta')
  late String iDPlanta;

  @MapTo('Previsoes')
  late List<String> previsoes;

  @MapTo('QuantidadeFrutos')
  late int quantidadeFrutos;

  @MapTo('Status')
  late String status;
}

@RealmModel()
class _ObjetosDetectado {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late double height;

  late double left;

  late double probability;

  late String tagName;

  late double top;

  late double width;
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
class _PrevisaoProducao {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('Data')
  late DateTime data;

  @MapTo('IDProduto')
  late String iDProduto;

  @MapTo('QuantiaFrutos')
  late int quantiaFrutos;

  @MapTo('TempoColheita')
  late String tempoColheita;
}

@RealmModel()
class _Producao {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('Descricao')
  late String descricao;

  @MapTo('IDProdutos')
  late List<String> iDProdutos;

  @MapTo('IDUser')
  late String iDUser;

  _ProducaoLocation? location;
}

@RealmModel(ObjectType.embeddedObject)
@MapTo('Producao_location')
class _ProducaoLocation {
  late List<double> coordinates;

  String? type;
}

@RealmModel()
class _Produto {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('IDEspecime')
  late String iDEspecime;

  @MapTo('NomePlanta')
  late String nomePlanta;

  @MapTo('Previsoes')
  late List<String> previsoes;
}

@RealmModel()
class _RelatoriosDeteccao {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('Data')
  late DateTime data;

  @MapTo('IDProduto')
  late String iDProduto;

  @MapTo('ImagemPath')
  late String imagemPath;

  @MapTo('ObjetosDetectados')
  late List<String> objetosDetectados;

  @MapTo('TipoDeteccao')
  late String tipoDeteccao;
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

  late String imagemPerfil;
}
