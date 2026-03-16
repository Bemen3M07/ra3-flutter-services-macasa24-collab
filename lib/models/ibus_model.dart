class IBus {
  final String line;
  final String destination;
  final String textCa; // Ejemplo: "5 min" o "Imminent"
  final int tInMin;    // Tiempo en minutos (número entero)

  IBus({
    required this.line,
    required this.destination,
    required this.textCa,
    required this.tInMin,
  });

  // Factory para convertir el JSON que nos da la API en un objeto Dart
  factory IBus.fromJson(Map<String, dynamic> json) {
    return IBus(
      line: json['line'] ?? 'N/A',
      destination: json['destination'] ?? 'Desconegut',
      textCa: json['textCa'] ?? '',
      tInMin: json['t-in-min'] ?? 0, 
    );
  }
}