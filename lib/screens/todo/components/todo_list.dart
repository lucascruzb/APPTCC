// ignore_for_file: avoid_print, dead_code

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'todo_item.dart';
import 'widgets.dart';
import 'package:listy/realm/schemas.dart';
import 'package:provider/provider.dart';
import 'package:listy/realm/realm_services.dart';
import 'package:realm/realm.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../main.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    final String atlasUrl =
        Provider.of<Config>(context, listen: false).atlasUrl;
    bool mudanca = false;

    print("To see your data in Atlas, follow this link: $atlasUrl");

    return Stack(
      children: [
        Column(
          children: [
            styledBox(
              context,
              isHeader: true,
              child: Row(
                children: [
                  const Expanded(
                    child: Text("Show All Tasks", textAlign: TextAlign.right),
                  ),
                  Switch(
                    value: mudanca,
                    onChanged: (value) async {
                      if (realmServices.offlineModeOn) {
                        infoMessageSnackBar(context,
                                "Switching subscriptions does not affect Realm data when the sync is offline.")
                            .show(context);
                      }
                      if (mudanca) {
                        await realmServices.switchSubscription(
                            realmServices.realm.all<Item>(),
                            "getItemsSubscription");
                      } else {
                        await realmServices.switchSubscription(
                            realmServices.realm.query<Item>(r'owner_id == $0',
                                [realmServices.currentUser?.id]),
                            "getItemsSubscription");
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: StreamBuilder<RealmResultsChanges<Item>>(
                  stream: realmServices.realm
                      .query<Item>("TRUEPREDICATE SORT(_id ASC)")
                      .changes,
                  builder: (context, snapshot) {
                    final data = snapshot.data;

                    if (data == null) return waitingIndicator();

                    final results = data.results;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.realm.isClosed ? 0 : results.length,
                      itemBuilder: (context, index) => results[index].isValid
                          ? TodoItem(results[index])
                          : Container(),
                    );
                  },
                ),
              ),
            ),
            styledBox(context,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 40, 15),
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: 'To see your changes in Atlas, ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'tap here.',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 98, 255)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchURL(url: atlasUrl),
                      )
                    ])))),
            styledBox(
              context,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 40, 15),
                  child: const Text(
                    "Log in with the same account on another device to see your list sync in realm-time.",
                    textAlign: TextAlign.left,
                  )),
            ),
          ],
        ),
        realmServices.isWaiting ? waitingIndicator() : Container(),
      ],
    );
  }

  _launchURL({required String url}) async {
    Uri parsedUrl = Uri.parse(url);

    if (url.isNotEmpty) {
      await launchUrl(parsedUrl);
    } else {
      throw 'Could not open $parsedUrl';
    }
  }
}
