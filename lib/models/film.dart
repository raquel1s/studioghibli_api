class Film {
  final String title;
  final String original_title;
  final String image;
  final String movie_banner;
  final String description;
  final String release_date;
  final String running_time;
  final List<dynamic> characters;

  Film({
    required this.title,
    required this.original_title,
    required this.image,
    required this.movie_banner,
    required this.description,
    required this.release_date,
    required this.running_time,
    required this.characters,
  });

  factory Film.fromJson(Map<String, dynamic> json){
    return Film(
      title: json['title'], 
      original_title: json['original_title'], 
      image: json['image'],
      movie_banner: json['movie_banner'], 
      description: json['description'], 
      release_date: json['release_date'], 
      running_time: json['running_time'],
      characters: json['people']
    );
  }
}