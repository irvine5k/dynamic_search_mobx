import 'package:dynamic_search_mobx/app/modules/home/home_controller.dart';
import 'package:dynamic_search_mobx/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Inject<HomeModule>.of().get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          return Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Github...',
                ),
                style: TextStyle(
                  fontSize: 36.0,
                  fontFamily: "Hind",
                  decoration: TextDecoration.none,
                ),
                onChanged: _homeController.search,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _homeController.result?.length ?? 0,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(
                        _homeController.result[index].title,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
