import 'package:http/http.dart' as http;
import 'dart:convert';

class TmbHttpService {
  final String appId = '496690df';
  final String appKey = '08b55f6dde4159e2dedc30cf8ddc2ea2';

  // 1. END-POINT: iBus (El que ya teníamos)
  Future<Map<String, dynamic>> fetchUpcomingBuses(String stopCode) async {
    final url = Uri.parse('https://api.tmb.cat/v1/ibus/stops/$stopCode?app_id=$appId&app_key=$appKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Error al carregar iBus. Codi: ${response.statusCode}');
    }
  }

  // 2. END-POINT: Detalles de todas las líneas (modificado)
  Future<Map<String, dynamic>> fetchLineDetails() async {
    // Fíjate que hemos quitado el /$line de la URL
    final url = Uri.parse('https://api.tmb.cat/v1/transit/linies/bus?app_id=$appId&app_key=$appKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Error al carregar la línia. Codi: ${response.statusCode}');
    }
  }

  // 3. END-POINT: Alertas e Incidencias generales
  Future<Map<String, dynamic>> fetchAlerts() async {
    final url = Uri.parse('https://api.tmb.cat/v1/transit/alertes?app_id=$appId&app_key=$appKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Error al carregar les alertes. Codi: ${response.statusCode}');
    }
  }
}