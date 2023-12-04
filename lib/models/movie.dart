import 'dart:convert';
import 'actor.dart';

class Movie {
  int id;
  String name;
  String profilePath;
  double popularity;
  List<Actor> actorMovie;
  


  Movie({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.actorMovie,

  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      actorMovie: [],

    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
