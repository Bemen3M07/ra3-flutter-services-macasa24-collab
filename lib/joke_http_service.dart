import 'package:http/http.dart' as http;
import 'joke_model.dart';

class JokeHttpService {
  final String _url = "https://api.chucknorris.io/jokes/random";

  Future<JokeModel> getRandomJoke() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      return jokeModelFromJson(response.body);
    } else {
      throw Exception("Error al obtener el chiste");
    }
  }
}