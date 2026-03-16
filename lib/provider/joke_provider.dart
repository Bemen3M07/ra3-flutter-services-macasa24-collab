import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/joke_http_service.dart';

class JokeProvider extends ChangeNotifier {
  final JokeService _service = JokeService();
  Joke? _joke;
  bool _isLoading = false;

  Joke? get joke => _joke;
  bool get isLoading => _isLoading;

  /// Fetch a new random joke, update state and return the joke.
  /// Errors are rethrown for the caller to handle if needed.
  Future<Joke?> fetchNewJoke() async {
    _isLoading = true;
    notifyListeners();

    try {
      _joke = await _service.getRandomJoke();
      return _joke;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}