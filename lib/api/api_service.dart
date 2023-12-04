import 'dart:convert';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/models/biographyActor.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/review.dart';

class ApiService {
  static Future<List<Movie>?> getTopRatedActors() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getCustomActor(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}person/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getSearchedActors(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?api_key=${Api.apiKey}&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Actor>> getActor(String actorName) async {
    List<Actor> cast = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));

      var castData = jsonDecode(response.body)['results'];

      var actor = castData.firstWhere(
        (personData) => personData['name']
            .toString()
            .toLowerCase()
            .contains(actorName.toLowerCase()),
        orElse: () => null,
      );

      if (actor != null) {
        var knownFor = actor['known_for'] as List<dynamic>;

        for (var movieData in knownFor) {
          if (movieData['media_type'] == 'movie') {
            cast.add(
              Actor(
                id: movieData['id'] as int,
                title: movieData['title'] ?? '',
                posterPath: movieData['poster_path'] ?? '',
                releaseDate: movieData['release_date'] ?? '',
              ),
            );
          }
        }
      }

      return cast;
    } catch (e) {
      return [];
    }
  }

    static Future<BiographyActor?> getBiography(int actorId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/person/$actorId?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);

      return BiographyActor(
        id: res['id'],
        biography: res['biography'],
      );
    } catch (e) {
      return null;
    }
  }

    static Future<List<Movie>?> getTrending() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}trending/person/day?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getPopular() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

}
