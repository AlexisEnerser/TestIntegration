class Group{
  int id;
  String name;
  String description;

  Group({
    this.id = 0,
    this.name = '',
    this.description = ''
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description
    };
  }
}