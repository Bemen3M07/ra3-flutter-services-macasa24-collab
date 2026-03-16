import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../services/car_http_service.dart';

class CarsListScreen extends StatefulWidget {
  const CarsListScreen({super.key});

  @override
  State<CarsListScreen> createState() => _CarsListScreenState();
}

class _CarsListScreenState extends State<CarsListScreen> {
  final CarHttpService _carService = CarHttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car API Practice (P5d)'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CarsModel>>(
        future: _carService.getCars(),
        builder: (context, snapshot) {
          // 1. Mientras espera la respuesta
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Si ocurre un error (ej. sin internet o API Key mal)
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // 3. Cuando llegan los datos
          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.directions_car, color: Colors.blue),
                  title: Text('${car.make} ${car.model}'),
                  subtitle: Text('Year: ${car.year} | Type: ${car.type}'),
                  onTap: () {
                    // Aquí podrías navegar a un detalle si lo pide el profesor
                    print('Has pulsado en: ${car.model}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}