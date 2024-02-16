import 'package:listy/realm/schemas.dart';
import 'package:realm/realm.dart';
import 'package:flutter/material.dart';

class RealmServices with ChangeNotifier {
  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  App app;

  RealmServices(this.app) {
    if (app.currentUser != null || currentUser != app.currentUser) {
      currentUser ??= app.currentUser;
      realm = Realm(Configuration.flexibleSync(currentUser!,
          [Item.schema, Perfil.schema, Tela.schema, Usuario.schema]));

      if (realm.subscriptions.isEmpty) {
        startSubscriptions();
      }
    }
  }

  Future<void> startSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      mutableSubscriptions.add(realm.all<Item>(), name: "getItemsSubscription");
      mutableSubscriptions.add(realm.all<Perfil>(), name: "perfilSubscription");
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

  void createItem(String summary, bool isComplete) {
    final newItem = Item(ObjectId(), isComplete, currentUser!.id, summary);
    realm.write<Item>(() => realm.add<Item>(newItem));
    notifyListeners();
  }

  void deleteItem(Item item) {
    realm.write(() => realm.delete(item));
    notifyListeners();
  }

  Future<void> updateItem(Item item,
      {String? summary, bool? isComplete}) async {
    realm.write(() {
      if (summary != null) {
        item.summary = summary;
      }
      if (isComplete != null) {
        item.isComplete = isComplete;
      }
    });
    notifyListeners();
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
