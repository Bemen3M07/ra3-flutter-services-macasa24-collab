import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke_model.dart';
import 'dart:math';

class JokeService {

  Future<Joke> getJoke() async {

    final url = Uri.parse('https://api.sampleapis.com/jokes/goodJokes');

    final respuesta = await http.get(url);

    if(respuesta.statusCode == 200){

      final jsonDecodificado = json.decode(respuesta.body);

      int indiceAleatorio = Random().nextInt(jsonDecodificado.length);

      return Joke.fromJson( jsonDecodificado[indiceAleatorio] );
    }
    else{
      throw Exception('Error al obtener el chiste');
    }
  }

  Future<Joke?> getRandomJoke() async {}
}