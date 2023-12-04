import 'dart:convert';

class Actor {
  int id;
  String title;
  String posterPath;
  String releaseDate;

  Actor({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));

  String getFoto() =>
      // ignore: unnecessary_null_comparison
      posterPath == null
          ? 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg'
          : 'https://image.tmdb.org/t/p/w500/$posterPath';

}