class City {
  final int? id;
  String name;

  City({this.id, required this.name});

  //extracts the values from the map and assigns them to the corresponding properties of the City object.
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'City(id: $id, name: $name)';
  }
}
