import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:listy/realm/realm_services.dart';
import 'components/app_bar.dart';
import 'components/create_item.dart';
import 'components/todo_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : const Scaffold(
            appBar: TodoAppBar(),
            body: TodoList(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: CreateItemAction(),
          );
  }
}
