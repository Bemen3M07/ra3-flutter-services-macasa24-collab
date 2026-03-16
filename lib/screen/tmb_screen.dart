import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tmb_provider.dart';
import 'line_detail_screen.dart'; // 👇 AÑADIDO
import 'alerts_screen.dart'; // 👇 AÑADIDO

class TmbScreen extends StatelessWidget {
  TmbScreen({super.key});

  final TextEditingController _stopCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses TMB (iBus)'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        // 👇 AÑADIDO: Botón para ir a las alertas
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AlertsScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _stopCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Codi de parada (Ex: 1224)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.directions_bus),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    final code = _stopCodeController.text.trim();
                    if (code.isNotEmpty) {
                      FocusScope.of(context).unfocus(); 
                      Provider.of<TmbProvider>(context, listen: false).getBusesForStop(code);
                    }
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<TmbProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.buses.isEmpty) {
                    return const Center(child: Text('Introdueix un codi de parada.'));
                  }
                  return ListView.builder(
                    itemCount: provider.buses.length,
                    itemBuilder: (context, index) {
                      final bus = provider.buses[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red[600],
                            foregroundColor: Colors.white,
                            child: Text(bus.line, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          title: Text('Destinació: ${bus.destination}'),
                          trailing: Text(bus.textCa, style: TextStyle(fontWeight: FontWeight.bold, color: bus.tInMin <= 1 ? Colors.red : Colors.black87)),
                          // 👇 AÑADIDO: Navegación a la pantalla 2
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LineDetailScreen(lineName: bus.line, timeRemaining: '${bus.tInMin} min')),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}