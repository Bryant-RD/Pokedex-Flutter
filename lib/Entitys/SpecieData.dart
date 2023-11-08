
class SpecieData {
   
  final String catchRate; //Species[capture-rate]
  final String baseFriendship; //Species[base-happines]
  final String growthRate; //species [growth-rate][name]
  final String color; //species[color][name]
  final List<String> eggGroups;
  final int gender;
  final int eggCycles;

  SpecieData({
    required this.catchRate,
    required this.baseFriendship,
    required this.growthRate, 
    required this.color,
    required this.eggGroups,
    required this.gender,
    required this.eggCycles
  });


  factory SpecieData.fromJson(Map<String, dynamic> json) {
    return SpecieData(
      catchRate: json['capture_rate'],
      baseFriendship: json['base_happines'],
      growthRate: json['growth_rate']['name'],
      color: json['color']['name'],
      gender: json['gender_rate'],
      eggCycles: json['hatch_counter'],
      eggGroups: (json['types'] as List)
            .map((typeEntry) => typeEntry['type']['name'].toString())
            .toList()
    );
  }

}
