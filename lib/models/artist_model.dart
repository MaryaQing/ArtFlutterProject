class Artist {
  final String name;
  final String handle;
  final String description;
  final String image;

  Artist({
    required this.name,
    required this.handle,
    required this.description,
    required this.image,
  });


  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json['name'],
      handle: json['handle'],
      description: json['description'],
      image: json['image'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'handle': handle,
      'description': description,
      'image': image,
    };
  }
}
