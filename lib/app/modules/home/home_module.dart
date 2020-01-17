import 'package:dio/dio.dart';
import 'package:dynamic_search_mobx/app/modules/home/services/movie_service.dart';
import 'package:dynamic_search_mobx/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dynamic_search_mobx/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MovieService(Dio())),
        Bind((i) => HomeController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
