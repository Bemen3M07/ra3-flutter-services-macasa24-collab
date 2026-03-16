import 'package:flutter/material.dart';
import '../services/tmb_http_service.dart';
import '../models/ibus_model.dart'; 

class TmbProvider extends ChangeNotifier {
  final TmbHttpService _tmbService = TmbHttpService();
  
  bool isLoading = false;
  List<IBus> buses = []; 
  
  // Nuevas variables para los nuevos end-points
  Map<String, dynamic>? selectedLineDetails;
  List<dynamic> alerts = [];

  // 1. Buscar paradas
  Future<void> getBusesForStop(String stopCode) async {
    isLoading = true;
    notifyListeners();
    try {
      final responseData = await _tmbService.fetchUpcomingBuses(stopCode);
      if (responseData['data'] != null && responseData['data']['ibus'] != null) {
        final List<dynamic> ibusData = responseData['data']['ibus'];
        buses = ibusData.map((json) => IBus.fromJson(json)).toList();
      } else {
        buses = []; 
      }
    } catch (e) {
      buses = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 2. Buscar detalles de una línea (Ej: H10)
  Future<void> getLineDetails(String lineName) async {
    isLoading = true;
    selectedLineDetails = null;
    notifyListeners();
    try {
      // Pedimos todas las líneas sin pasarle el nombre
      final responseData = await _tmbService.fetchLineDetails();
      
      if (responseData['features'] != null) {
        final List<dynamic> allLines = responseData['features'];
        
        // 🌟 EL TRUCO: Buscamos en la lista la línea que tenga el mismo nombre (NOM_LINIA)
        final line = allLines.firstWhere(
          (f) => f['properties']['NOM_LINIA'] == lineName,
          orElse: () => null, // Si no la encuentra, devuelve null
        );

        if (line != null) {
          selectedLineDetails = line['properties'];
        }
      }
    } catch (e) {
      print("Error buscando la línea: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Variable para guardar el metro
  List<dynamic> metroLines = [];

  // 3. Buscar Línies de Metro
  Future<void> getMetroLines() async {
    isLoading = true;
    notifyListeners();
    try {
      final responseData = await _tmbService.fetchMetroLines();
      if (responseData['features'] != null) {
        metroLines = responseData['features'];
      }
    } catch (e) {
      print("Error cargando el metro: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}