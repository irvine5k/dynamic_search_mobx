import 'package:dio/dio.dart';
import 'package:dynamic_search_mobx/app/modules/home/models/movie_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieService extends Disposable {
  final _apiKey = '060e7c76aff06a20ca4a875981216f3f';
  final Dio client;

  MovieService(this.client);

  Future<List<MovieModel>> search(String query, int page) async {
    try {
      final response = await client.get(
          "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=$page&include_adult=false");

      final result = List<MovieModel>.from(
        response.data['results'].map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );

     
      return result;
    } on DioError catch (e) {
      print(e.response.data);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getUpcomingMovies(int page) async {
    try {
      final response = await client.get(
          "https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey&language=en-US&page=$page");

      final result = List<MovieModel>.from(
        response.data['results'].map(
          (movie) => MovieModel.fromJson(movie),
        ),
      );

      print(result);

      return result;
    } on DioError catch (e) {
      print(e.response.data);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  @override
  void dispose() {}
}
