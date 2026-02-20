class Artist {
  String? id;
  String? type;
  String? category;
  String? name;
  String? handle;
  String? description;
  String? mainImage;
  List<String>? gallery; // تم التغيير من Null إلى String

  Artist({
    this.id,
    this.category,
    this.name,
    this.handle,
    this.description,
    this.mainImage,
    this.gallery,
  });

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    category = json['category'];
    name = json['name'];
    handle = json['handle'];
    description = json['description'];
    mainImage = json['mainImage'];
    // تحويل القائمة من dynamic إلى List<String>
    if (json['gallery'] != null) {
      gallery = List<String>.from(json['gallery']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['name'] = name;
    data['handle'] = handle;
    data['description'] = description;
    data['mainImage'] = mainImage;
    data['gallery'] = gallery;
    return data;
  }
}