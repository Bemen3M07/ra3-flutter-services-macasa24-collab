import 'package:flutter/material.dart';
import 'joke_model.dart';
import 'joke_http_service.dart';

class JokeProvider extends ChangeNotifier {
  final JokeHttpService _service = JokeHttpService();
  JokeModel? _joke;
  bool _isLoading = false;

  JokeModel? get joke => _joke;
  bool get isLoading => _isLoading;

  Future<void> fetchNewJoke() async {
    _isLoading = true;
    notifyListeners();

    try {
      _joke = await _service.getRandomJoke();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}