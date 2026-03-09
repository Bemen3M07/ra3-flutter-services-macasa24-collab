import 'dart:convert';

// --- ESTAS SON LAS FUNCIONES QUE TE FALTAN ---
// Convierte el texto JSON que llega de la API en una Lista de objetos CarsModel
List<CarsModel> carsModelFromJson(String str) => 
    List<CarsModel>.from(json.decode(str).map((x) => CarsModel.fromMapToCarObject(x)));

// Convierte una lista de objetos de vuelta a JSON (opcional, para enviar datos)
String carsModelToJson(List<CarsModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.fromObjectToMap())));
// --------------------------------------------

class CarsModel {
  final int id;
  final int year;
  final String make;
  final String model;
  final String type;

  CarsModel({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

  // Este método crea un coche individual desde un Mapa
  factory CarsModel.fromMapToCarObject(Map<String, dynamic> json) => CarsModel(
        id: json["id"],
        year: json["year"],
        make: json["make"],
        model: json["model"],
        type: json["type"],
      );

  // Este método convierte el coche en un Mapa
  Map<String, dynamic> fromObjectToMap() => {
        "id": id,
        "year": year,
        "make": make,
        "model": model,
        "type": type,
      };

  static fromJson(Map<String, String> json) {}
}