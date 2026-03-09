import 'package:http/http.dart' as http;
// Asegúrate de que esta ruta coincida con donde guardaste el modelo anterior
import '../models/car_model.dart'; 

class CarHttpService {
  // Datos sacados de las instrucciones de tu práctica [cite: 229, 230]
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _headerKey = "7c00063cc0mshd06eb3f7234b024p167924jsn67c78b190f6a";
  final String _headerHost = "car-data.p.rapidapi.com";

  Future<List<CarsModel>> getCars() async {
    // Construimos la URL para el endpoint /cars [cite: 242, 244]
    var uri = Uri.parse("$_serverUrl/cars");

    // Hacemos la petición GET con las cabeceras requeridas [cite: 246, 247, 249]
    var response = await http.get(uri, headers: {
      "x-rapidapi-key": _headerKey,
      "x-rapidapi-host": _headerHost,
    });

    // Control de errores: 200 significa éxito
    if (response.statusCode == 200) {
      return carsModelFromJson(response.body); // Usamos la función del modelo
    } else {
      throw ("Error al obtenir la llista de cotxes: ${response.statusCode}");
    }
  }
}