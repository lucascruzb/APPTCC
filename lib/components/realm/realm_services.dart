import 'package:listy/components/realm/schemas.dart';
import 'package:realm/realm.dart';
import 'package:flutter/material.dart';

class RealmServices with ChangeNotifier {
  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  App app;

  RealmServices(this.app) {
    if (app.currentUser != null && currentUser != app.currentUser) {
      currentUser = app.currentUser;
      realm = Realm(Configuration.flexibleSync(currentUser!, [
        Capacidade.schema,
        CapacidadesUsuario.schema,
        MonitoramentoProduto.schema,
        ObjetosDetectado.schema,
        Perfil.schema,
        PrevisaoProducao.schema,
        Producao.schema,
        ProducaoLocation.schema,
        Produto.schema,
        RelatoriosDeteccao.schema,
        Tela.schema,
        Usuario.schema
      ]));
      if (realm.subscriptions.isEmpty) {
        if (realm.subscriptions.findByName("capacidadeSubscription") == null) {
          startSubscriptions();
          ajustePermissionamento();
        }
      }
    }
  }

  Future<void> startSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      if (realm.isClosed) {
        close();
      }
      mutableSubscriptions.clear();
      mutableSubscriptions.add(realm.all<Capacidade>(),
          name: "capacidadeSubscription");
      mutableSubscriptions.add(realm.all<CapacidadesUsuario>(),
          name: "capacidadesUsuarioSubscription");
      mutableSubscriptions.add(realm.all<MonitoramentoProduto>(),
          name: "monitoramentoProdutoSubscription");
      mutableSubscriptions.add(realm.all<ObjetosDetectado>(),
          name: "ObjetosDetectadosubscription");
      mutableSubscriptions.add(realm.all<Perfil>(), name: "perfilSubscription");
      mutableSubscriptions.add(realm.all<PrevisaoProducao>(),
          name: "previssaoProducaoSubscription");
      mutableSubscriptions.add(realm.all<Producao>(),
          name: "producaoSubscription");
      mutableSubscriptions.add(realm.all<Produto>(),
          name: "produtoSubscription");
      mutableSubscriptions.add(realm.all<RelatoriosDeteccao>(),
          name: "relatorioDeteccaoSubscription");
      mutableSubscriptions.add(realm.all<Tela>(), name: "telaSubscription");
      mutableSubscriptions.add(realm.all<Usuario>(),
          name: "usuarioSubscription");
    });
    await realm.subscriptions.waitForSynchronization();
  }

  Future<void> updateSubscriptions(
      RealmResults<RealmObject> classeRealm, String name) async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(classeRealm, name: name, update: true);
    });
    notifyListeners();
  }

  Future<void> switchSubscription(
      RealmResults<RealmObject> classeRealm, String name) async {
    if (!offlineModeOn) {
      try {
        isWaiting = true;
        notifyListeners();
        await updateSubscriptions(classeRealm, name);
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  Future<void> switchCapacidade() async {
    switchSubscription(realm.query<Capacidade>("TRUEPREDICATE SORT(_id ASC)"),
        "capacidadeSubscription");
  }

  Future<void> switchCapacidadesUsuario() async {
    final usuarioAtual = getUsuario();
    switchSubscription(
        realm.query<CapacidadesUsuario>(
            r'IDUser == $0', [usuarioAtual.first.id.toString()]),
        "capacidadesUsuarioSubscription");
  }

  Future<void> switchMonitoramentoProduto(String produto) async {
    switchSubscription(
        realm.query<RelatoriosDeteccao>(r'IDPlanta == $0', [produto]),
        "monitoramentoProdutoSubscription");
  }

  Future<void> switchObjetosDetectado(List<String> objetos) async {
    if (objetos.isEmpty) {
      switchSubscription(
          realm.query<ObjetosDetectado>(r'probability <= $0', [1.0]),
          "ObjetosDetectadosubscription");
    } else {
      switchSubscription(
          realm.query<ObjetosDetectado>(r'_id IN $0',
              [objetos.map((str) => ObjectId.fromHexString(str)).toList()]),
          "ObjetosDetectadosubscription");
    }
  }

  Future<void> switchPerfil() async {
    final usuarioLogado = getUsuario();
    switchSubscription(
        realm.query<Perfil>(r'Tipo == $0', [usuarioLogado.first.perfil]),
        "perfilSubscription");
  }

  Future<void> switchPrevisaoProducao(String produto) async {
    switchSubscription(
        realm.query<PrevisaoProducao>(r'IDProduto == $0', [produto]),
        "previssaoProducaoSubscription");
  }

  Future<void> switchProducao() async {
    final usuarioAtual = getUsuario();
    switchSubscription(
        realm.query<Producao>(
            'IDUser == \$0', [usuarioAtual.first.id.toString()]),
        "producaoSubscription");
  }

  Future<void> switchProdutos(List<String> produtos) async {
    if (produtos.isEmpty) {
      switchSubscription(realm.query<Produto>(r'IDEspecime != $0', [null]),
          "produtoSubscription");
    } else {
      switchSubscription(
          realm.query<Produto>(r'_id IN $0',
              [produtos.map((str) => ObjectId.fromHexString(str)).toList()]),
          "produtoSubscription");
    }
  }

  Future<void> switchUsuario() async {
    switchSubscription(
        realm.query<Usuario>(r'IDUser == $0', [currentUser?.id.toString()]),
        "usuarioSubscription");
  }

  Future<void> switchTela() async {
    final perfilUsuario = getPerfil();
    final List<ObjectId> telas = perfilUsuario.first.iDTelas
        .map((str) => ObjectId.fromHexString(str))
        .toList();
    switchSubscription(
        realm.query<Tela>(r'_id IN $0', [telas]), "telaSubscription");
  }

  Future<void> switchRelatoriosDeteccao(String produto) async {
    if (produto.isEmpty) {
      switchSubscription(
          realm.query<RelatoriosDeteccao>("TRUEPREDICATE SORT(_id ASC)"),
          "relatorioDeteccaoSubscription");
    } else {
      switchSubscription(
          realm.query<RelatoriosDeteccao>(r'IDProduto == $0', [produto]),
          "relatorioDeteccaoSubscription");
    }
  }

  Future<void> sessionSwitch() async {
    offlineModeOn = !offlineModeOn;
    if (offlineModeOn) {
      realm.syncSession.pause();
    } else {
      try {
        isWaiting = true;
        notifyListeners();
        realm.syncSession.resume();
        await startSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  Future<void> ajustePermissionamento() async {
    await switchCapacidade();
    await switchUsuario();
    await switchPerfil();
    await switchTela();
    await switchProducao();
    await switchCapacidadesUsuario();
  }

  void createCapacidade(String capacidade) {
    final newCapacidade = Capacidade(ObjectId(), capacidade);
    realm.write<Capacidade>(() => realm.add<Capacidade>(newCapacidade));
    notifyListeners();
  }

  void createCapacidadesUsuario(String iDCapacidade, String iDUser) {
    final newCapacidadesUsuario =
        CapacidadesUsuario(ObjectId(), iDCapacidade, iDUser);
    realm.write<CapacidadesUsuario>(
        () => realm.add<CapacidadesUsuario>(newCapacidadesUsuario));
    notifyListeners();
  }

  String createObjetosDetectado(double height, double left, double probability,
      String tagName, double top, double width) {
    final newObjetosDetectado = ObjetosDetectado(
        ObjectId(), height, left, probability, tagName, top, width);
    final id = realm
        .write<ObjetosDetectado>(
            () => realm.add<ObjetosDetectado>(newObjetosDetectado))
        .id
        .toString();
    notifyListeners();
    return id;
  }

  void createPerfil(List<String> iDTelas, String tipo) {
    final newPerfil = Perfil(ObjectId(), tipo, iDTelas: iDTelas);
    realm.write<Perfil>(() => realm.add<Perfil>(newPerfil));
    notifyListeners();
  }

  void createPrevisaoProducao(
      String iDProduto, String tempoColheita, int quantidade) {
    final newPrevissaoProducao = PrevisaoProducao(
        ObjectId(), DateTime.now(), iDProduto, quantidade, tempoColheita);
    realm.write<PrevisaoProducao>(
        () => realm.add<PrevisaoProducao>(newPrevissaoProducao));
    notifyListeners();
  }

  String createProduto(
      String iDEspecime, String nomePlanta, Iterable<String> previsoes) {
    final newProduto =
        Produto(ObjectId(), iDEspecime, nomePlanta, previsoes: previsoes);
    String id = realm
        .write<Produto>(() => realm.add<Produto>(newProduto))
        .id
        .toString();
    notifyListeners();
    return id;
  }

  void createRelatoriosDeteccao(String iDProduto, String imagePath,
      Iterable<String> objetosDetectados, String tipoDeteccao) {
    final newRelatoriosDeteccao = RelatoriosDeteccao(
        ObjectId(), DateTime.now(), iDProduto, imagePath, tipoDeteccao,
        objetosDetectados: objetosDetectados);
    realm.write<RelatoriosDeteccao>(
        () => realm.add<RelatoriosDeteccao>(newRelatoriosDeteccao));
    notifyListeners();
  }

  void createProducao(String iDUser, String descricao,
      ProducaoLocation location, Iterable<String> iDProdutos) {
    final newProducao = Producao(ObjectId(), descricao, iDUser,
        location: location, iDProdutos: iDProdutos);
    realm.write<Producao>(() => realm.add<Producao>(newProducao));
    notifyListeners();
  }

  void createTela(String caminho, String caminhoImagem, String nome) {
    final newTela = Tela(ObjectId(), caminho, caminhoImagem, nome);
    realm.write<Tela>(() => realm.add<Tela>(newTela));
    notifyListeners();
  }

  void createUsuario(String endereco, String iDUser, String nome,
      String imagemPerfil, String perfil, String telefone) {
    final newUsuario = Usuario(
        ObjectId(), endereco, iDUser, nome, perfil, telefone, imagemPerfil);
    realm.write<Usuario>(() => realm.add<Usuario>(newUsuario));
    notifyListeners();
  }

  Future<void> updateCapacidade(Capacidade item, {String? capacidade}) async {
    realm.write(() {
      if (capacidade != null) {
        item.capacidade = capacidade;
      }
    });
    notifyListeners();
  }

  Future<void> updateCapacidadesUsuario(CapacidadesUsuario item,
      {String? iDCapacidade, String? iDUser}) async {
    realm.write(() {
      if (iDCapacidade != null) {
        item.iDCapacidade = iDCapacidade;
      }
      if (iDUser != null) {
        item.iDUser = iDUser;
      }
    });
    notifyListeners();
  }

  Future<void> updateRelatoriosDeteccao(
    RelatoriosDeteccao item, {
    DateTime? data,
    String? iDProduto,
    String? imagemPath,
    Iterable<String>? objetosDetectados,
  }) async {
    realm.write(() {
      if (data != null) {
        item.data = data;
      }
      if (iDProduto != null) {
        item.iDProduto = iDProduto;
      }
      if (imagemPath != null) {
        item.imagemPath = imagemPath;
      }
      if (objetosDetectados != null) {
        item.objetosDetectados = RealmList<String>(objetosDetectados);
      }
    });
    notifyListeners();
  }

  Future<void> updateObjetosDetectado(ObjetosDetectado item,
      {double? height,
      double? left,
      double? probability,
      String? tagName,
      double? top,
      double? width}) async {
    realm.write(() {
      if (height != null) {
        item.height = height;
      }
      if (left != null) {
        item.left = left;
      }
      if (probability != null) {
        item.probability = probability;
      }
      if (tagName != null) {
        item.tagName = tagName;
      }
      if (top != null) {
        item.top = top;
      }
      if (width != null) {
        item.width = width;
      }
    });
    notifyListeners();
  }

  Future<void> updatePerfil(Perfil item,
      {List<String>? iDTelas, String? tipo}) async {
    realm.write(() {
      if (iDTelas != null) {
        item.iDTelas = RealmList<String>(iDTelas);
      }
      if (tipo != null) {
        item.tipo = tipo;
      }
    });
    notifyListeners();
  }

  Future<void> updatePrevisaoProducao(PrevisaoProducao item,
      {String? tempoColheita, int? quantidade}) async {
    realm.write(() {
      item.data = DateTime.now();
      if (tempoColheita != null) {
        item.tempoColheita = tempoColheita;
      }
      if (quantidade != null) {
        item.quantiaFrutos = quantidade;
      }
    });
    notifyListeners();
  }

  Future<void> updateProducao(Producao item,
      {ProducaoLocation? location, Iterable<String>? iDProdutos}) async {
    realm.write(() {
      if (iDProdutos != null) {
        for (var produto in iDProdutos) {
          item.iDProdutos.add(produto);
        }
        if (location != null) {
          item.location = location;
        }
      }
    });
    notifyListeners();
  }

  Future<void> updateProduto(Produto item,
      {String? iDEspecime,
      String? nomePlanta,
      Iterable<String>? previsao}) async {
    realm.write(() {
      if (iDEspecime != null) {
        item.iDEspecime = iDEspecime;
      }
      if (nomePlanta != null) {
        item.nomePlanta = nomePlanta;
      }
      if (previsao != null) {
        for (var previsao in previsao) {
          item.previsoes.add(previsao);
        }
      }
    });
    notifyListeners();
  }

  Future<void> updateTela(Tela item,
      {String? caminho, String? caminhoImagem, String? nome}) async {
    realm.write(() {
      if (caminho != null) {
        item.caminho = caminho;
      }
      if (caminhoImagem != null) {
        item.caminhoImagem = caminhoImagem;
      }
      if (nome != null) {
        item.nome = nome;
      }
    });
    notifyListeners();
  }

  Future<void> updateUsuario(Usuario item,
      {String? endereco,
      String? nome,
      String? imagemPerfil,
      String? perfil,
      String? telefone}) async {
    realm.write(() {
      if (endereco != null) {
        item.endereco = endereco;
      }
      if (nome != null) {
        item.nome = nome;
      }
      if (imagemPerfil != null) {
        item.imagemPerfil = imagemPerfil;
      }
      if (perfil != null) {
        item.perfil = perfil;
      }
      if (telefone != null) {
        item.telefone = telefone;
      }
    });
    notifyListeners();
  }

  void deleteCapacidade(Capacidade capacidade) {
    realm.write(() => realm.delete(capacidade));
    notifyListeners();
  }

  void deleteCapacidadesUsuario(CapacidadesUsuario capacidadesUsuario) {
    realm.write(() => realm.delete(capacidadesUsuario));
    notifyListeners();
  }

  void deleteRelatoriosDeteccao(RelatoriosDeteccao frutosDetectado) {
    realm.write(() => realm.delete(frutosDetectado));
    notifyListeners();
  }

  void deleteObjetosDetectados(ObjetosDetectado objetosDetectado) {
    realm.write(() => realm.delete(objetosDetectado));
    notifyListeners();
  }

  void deletePerfil(Perfil perfil) {
    realm.write(() => realm.delete(perfil));
    notifyListeners();
  }

  void deletePrevisaoProducao(PrevisaoProducao previssaoProducao) {
    realm.write(() => realm.delete(previssaoProducao));
    notifyListeners();
  }

  void deleteProducao(Producao producao) {
    realm.write(() => realm.delete(producao));
    notifyListeners();
  }

  void deleteProduto(Produto produto) {
    realm.write(() => realm.delete(produto));
    notifyListeners();
  }

  void deleteTela(Tela tela) {
    realm.write(() => realm.delete(tela));
    notifyListeners();
  }

  void deleteUsuario(Usuario usuario) {
    realm.write(() => realm.delete(usuario));
    notifyListeners();
  }

  RealmResults<Capacidade> getCapacidades() {
    final capacidades = realm.query<Capacidade>(
        realm.subscriptions.findByName("capacidadeSubscription")!.queryString);
    return capacidades;
  }

  RealmResults<CapacidadesUsuario> getCapacidadesUsuario() {
    final capacidadesUsuario = realm.query<CapacidadesUsuario>(realm
        .subscriptions
        .findByName("capacidadesUsuarioSubscription")!
        .queryString);
    return capacidadesUsuario;
  }

  RealmResults<RelatoriosDeteccao> getRelatoriosDeteccao() {
    return realm.query<RelatoriosDeteccao>(realm.subscriptions
        .findByName("relatorioDeteccaoSubscription")!
        .queryString);
  }

  RealmResults<ObjetosDetectado> getObjetosDetectado() {
    final objetosDetectados = realm.query<ObjetosDetectado>(realm.subscriptions
        .findByName("ObjetosDetectadosubscription")!
        .queryString);
    return objetosDetectados;
  }

  RealmResults<Perfil> getPerfil() {
    final perfil = realm.query<Perfil>(
        realm.subscriptions.findByName("perfilSubscription")!.queryString);
    return perfil;
  }

  RealmResults<PrevisaoProducao> getPrevissaoProducao() {
    final previssao = realm.query<PrevisaoProducao>(realm.subscriptions
        .findByName("previssaoProducaoSubscription")!
        .queryString);
    return previssao;
  }

  RealmResults<Producao> getProducao() {
    final producao = realm.query<Producao>(
        realm.subscriptions.findByName("producaoSubscription")!.queryString);
    return producao;
  }

  RealmResults<Produto> getProdutos() {
    final produtos = realm.query<Produto>(
      realm.subscriptions.findByName("produtoSubscription")!.queryString,
    );
    return produtos;
  }

  RealmResults<Tela> getTelas() {
    final telas = realm.query<Tela>(
        realm.subscriptions.findByName("telaSubscription")!.queryString);
    return telas;
  }

  RealmResults<Usuario> getUsuario() {
    final usuario =
        realm.query<Usuario>(r'IDUser == $0', [currentUser?.id.toString()]);
    return usuario;
  }

  Future<void> close() async {
    if (currentUser != null) {
      await currentUser?.logOut();
      currentUser = null;
    }
    realm.close();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
