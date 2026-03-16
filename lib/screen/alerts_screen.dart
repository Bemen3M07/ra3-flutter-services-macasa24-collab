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
    // Nada más abrir la pantalla, pedimos las alertas de TMB
    Future.microtask(() => 
      Provider.of<TmbProvider>(context, listen: false).getAlerts()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidències TMB'),
        backgroundColor: Colors.orange[800], // Color de alerta
        foregroundColor: Colors.white,
      ),
      body: Consumer<TmbProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.alerts.isEmpty) {
            return const Center(child: Text('Tot funciona correctament! Cap incidència. 🎉', style: TextStyle(fontSize: 16)));
          }

          return ListView.builder(
            itemCount: provider.alerts.length,
            itemBuilder: (context, index) {
              final alert = provider.alerts[index]['properties'];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ExpansionTile( // ExpansionTile permite desplegar para ver más info
                  leading: const Icon(Icons.warning, color: Colors.orange),
                  title: Text(alert['titol'] ?? 'Incidència', style: const TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      // Limpiamos un poco el HTML que a veces manda TMB
                      child: Text((alert['descripcio'] ?? '').replaceAll(RegExp(r'<[^>]*>'), '')),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}