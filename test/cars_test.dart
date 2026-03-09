import 'package:flutter_test/flutter_test.dart';
// REEMPLAZA 'nombre_de_tu_proyecto' por el name de tu pubspec.yaml
import 'package:flutter_hello_world/services/car_http_service.dart'; 

void main() {
  group('Prueba de API de Coches', () {
    test('Debe retornar 10 coches de la API', () async {
      final carService = CarHttpService();
      
      try {
        final cars = await carService.getCars();

        // Verificamos que la lista no esté vacía
        expect(cars.isNotEmpty, true);
        
        // La práctica dice que esperamos 10 elementos
        expect(cars.length, 10);
        
        print('✅ Test pasado: Se han recibido ${cars.length} coches.');
        print('Primer coche: ${cars[0].make} ${cars[0].model}');
        
      } catch (e) {
        fail('El test falló debido a un error: $e');
      }
    });
  });
}