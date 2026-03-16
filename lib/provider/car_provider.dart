import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../services/car_http_service.dart';

class CarProvider extends ChangeNotifier {
  final CarHttpService _service = CarHttpService();
  List<CarsModel> _cars = [];
  bool _isLoading = false;

  List<CarsModel> get cars => _cars;
  bool get isLoading => _isLoading;

  Future<void> fetchCars() async {
    _isLoading = true;
    notifyListeners(); // Notifica a la UI que está cargando

    try {
      _cars = await _service.getCars();
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica a la UI que ya tiene los datos
    }
  }
}