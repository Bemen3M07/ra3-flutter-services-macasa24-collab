import 'package:flutter/material.dart';
import '../services/joke_http_service.dart';
import '../models/joke_model.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  JokeScreenState createState() => JokeScreenState();
}

class JokeScreenState extends State<JokeScreen> {
  final JokeService jokeService = JokeService();

  Joke? chiste;
  bool cargando = false;

  Future<void> obtenerChiste() async {
    setState(() => cargando = true); // Empezamos a cargar

    try {
      final nuevoChiste = await jokeService.getJoke();
      setState(() {
        chiste = nuevoChiste;
        cargando = false; // Terminamos de cargar
      });
    } catch (e) {
      setState(() => cargando = false);
      // Aquí podrías mostrar un SnackBar de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: cargando
            ? const CircularProgressIndicator() // Si cargando es true, muestra esto
            : chiste == null
                ? const Text("Presiona el botón para empezar")
                : Text(
                    "${chiste!.setup}\n\n${chiste!.punchline}") // Si hay chiste, lo muestra
      ),
      floatingActionButton: ElevatedButton(
        onPressed: obtenerChiste, // Llamamos a nuestra nueva función
        child: const Text("OTRO JOKE"),
      ),
    );
  }
}