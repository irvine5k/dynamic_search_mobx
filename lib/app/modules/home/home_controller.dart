import 'dart:async';
import 'package:async/async.dart';

import 'package:dynamic_search_mobx/app/modules/home/services/movie_service.dart';
import 'package:mobx/mobx.dart';

import 'models/movie_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  _HomeBase(this.movieService);

  final MovieService movieService;

  Timer _debounceTimer;
  CancelableOperation<List<MovieModel>> _operation;

  @observable
  int value = 0;

  @observable
  ObservableList<MovieModel> result = ObservableList<MovieModel>();

  @action
  void search(String term) {
    if (term.isEmpty || term.length < 3) {
      result = null;
    }

    _debounceTimer?.cancel();
    _operation?.cancel();

    _debounceTimer = Timer(Duration(milliseconds: 500), () async {
      result = null;

      _operation = CancelableOperation.fromFuture(movieService.search(term, 1));

      try {
        final _result = await _operation.value;

        if (_result.isEmpty) {
          result = null;
        } else {
          result = _result.asObservable();
        }
      } catch (e) {
        result = null;
      }
    });
  }
}
