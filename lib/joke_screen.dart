import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'joke_provider.dart';

class JokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Chistes de Chuck Norris")),
      body: Center(
        child: jokeProvider.isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(jokeProvider.joke?.iconUrl ?? ""),
                    SizedBox(height: 20),
                    Text(
                      jokeProvider.joke?.value ?? "Pulsa el botón",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => jokeProvider.fetchNewJoke(),
                      child: Text("¡Otro chiste!"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}