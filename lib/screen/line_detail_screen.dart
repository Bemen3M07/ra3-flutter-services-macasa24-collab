import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tmb_provider.dart';

class LineDetailScreen extends StatefulWidget {
  final String lineName;
  final String timeRemaining; // 👉 NUEVA VARIABLE

  const LineDetailScreen({
    super.key, 
    required this.lineName, 
    required this.timeRemaining // 👉 LA PEDIMOS AQUÍ
  });

  @override
  State<LineDetailScreen> createState() => _LineDetailScreenState();
}

class _LineDetailScreenState extends State<LineDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<TmbProvider>(context, listen: false).getLineDetails(widget.lineName)
    );
  }

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
        title: Text('Línia ${widget.lineName}'),
        backgroundColor: Colors.red[800],
        foregroundColor: Colors.white,
      ),
      body: Consumer<TmbProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final lineData = provider.selectedLineDetails;
          if (lineData == null) {
            return const Center(child: Text('No s\'han trobat detalls d\'aquesta línia.'));
          }

          // Arreglamos el nombre de la variable para que coja el color correcto de TMB
          final colorCode = lineData['COLOR_LINIA'] ?? lineData['COLOR_REC'] ?? 'cccccc';
          final color = _hexToColor(colorCode);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: color,
                      child: Text(
                        widget.lineName,
                        style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // 👉 NUEVO: TARJETA CON EL TIEMPO RESTANTE
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber, width: 2)
                      ),
                      child: Column(
                        children: [
                          const Text('Temps d\'espera', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(
                            widget.timeRemaining, 
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Text('Descripció del recorregut:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                  lineData['DESC_LINIA'] ?? 'Sense descripció',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.route),
                  title: const Text('Tipus de línia'),
                  // Arreglamos el "Desconegut"
                  subtitle: Text(lineData['NOM_TIPUS_TRANSPORT'] ?? 'Autobús Urbà'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}