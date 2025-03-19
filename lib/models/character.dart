class Character {
  final String id;
  final String name;
  final String gender;
  final String age;

  Character({
    required this.id,
    required this.name,
    required this.gender,
    required this.age
  });

  factory Character.fromJson(Map<String, dynamic> json){
    return Character(
      id: json['id'],
      name: json['name'], 
      gender: json['gender'], 
      age: json['age']
    );
  }
}