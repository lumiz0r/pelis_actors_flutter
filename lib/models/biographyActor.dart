import 'dart:convert';

class BiographyActor {
  int id;
  String biography;
  

  BiographyActor({
    required this.id,
    required this.biography,
    
  });

  factory BiographyActor.fromMap(Map<String, dynamic> map) {
    return BiographyActor(
      id: map['id'] as int,
      biography: map['biography'] ?? '',
    );
  }

  factory BiographyActor.fromJson(String source) =>
      BiographyActor.fromMap(json.decode(source));
}
