import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tmb_provider.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  void initState() {
    super.initState();
    // Pedimos las líneas de metro nada más abrir la pantalla
    Future.microtask(() => 
      Provider.of<TmbProvider>(context, listen: false).getMetroLines()
    );
  }

  // Función para convertir los códigos de color de TMB
  Color _hexToColor(String? hexString) {
    if (hexString == null) return Colors.grey;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xarxa de Metro'),
        backgroundColor: Colors.blue[800], // Un azul oscuro para el Metro
        foregroundColor: Colors.white,
      ),
      body: Consumer<TmbProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.metroLines.isEmpty) {
            return const Center(child: Text('No s\'han pogut carregar les dades.'));
          }

          return ListView.builder(
            itemCount: provider.metroLines.length,
            itemBuilder: (context, index) {
              final metro = provider.metroLines[index]['properties'];
              
              // TMB a veces usa COLOR_LINIA y a veces COLOR_REC
              final colorCode = metro['COLOR_LINIA'] ?? metro['COLOR_REC'] ?? 'cccccc';
              final color = _hexToColor(colorCode);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    child: Text(
                      metro['NOM_LINIA'] ?? 'M', 
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                  ),
                  title: Text(
                    metro['DESC_LINIA'] ?? 'Sense descripció', 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  subtitle: const Text('Metro de Barcelona'),
                  trailing: const Icon(Icons.subway),
                ),
              );
            },
          );
        },
      ),
    );
  }
}