class Imc {
  String id;
  double height;
  double weight;
  double result;
  String name;

  Imc({
    this.id = '',
    required this.height,
    required this.weight,
    required this.name,
    required this.result,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'height': height,
      'weight': weight,
      'name': name,
      'result': result,
    };
  }

  static Imc fromJson(Map<String, dynamic> json){
    return Imc(
        id: json['id'],
        weight: json['weight'],
        height: json['height'],
        name: json['name'],
        result: json['result']
    );
  }
}