class Cars {
  int? id;

  final String name;
  final String model;
  final String color;
  final String make;
  final String regNumber;

  Cars({
    required this.name,
    required this.model,
    required this.color,
    required this.make,
    required this.regNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'make': make,
      'color': color,
      'regNumber': regNumber,
    };
  }

  static Cars fromMap(Map<String, dynamic> map) {
    return Cars(
      name: map['name'],
      model: map['model'],
      make: map['make'],
      color: map['color'],
      regNumber: map['regNumber'],
    );
  }
}
