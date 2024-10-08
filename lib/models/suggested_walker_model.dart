class SuggestedWalker {
  int? id;
  String? fullName;
  int? age;
  int? monthOfExperience;
  String? description;
  String? distance_location;
  bool? isRecruited;
  String? photo_url;

  SuggestedWalker({
    this.id,
    this.fullName,
    this.age,
    this.monthOfExperience,
    this.description,
    this.distance_location,
    this.isRecruited,
    this.photo_url,
  });

  // Convertir les données JSON en instance de Walker
  factory SuggestedWalker.fromJson(Map<String, dynamic> json) {
    return SuggestedWalker(
        id: json['id'],
        fullName: json['fullName'],
        age: json['age'],
        monthOfExperience: json['month_of_experience'],
        description: json['description'],
        distance_location: json['distance_location'],
        isRecruited: json['isRecruited'],
        photo_url: json['photo_url']);
  }
}
