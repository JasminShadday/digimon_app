class Digimon {
  final String name;
  final String image;
  final String level;

  Digimon({required this.name, required this.image, required this.level});

  factory Digimon.fromJson(Map<String, dynamic> json) {
    return Digimon(
      name: json['name'],
      image: json['img'],
      level: json['level'],
    );
  }
}