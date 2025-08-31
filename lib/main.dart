
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 121, 7)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Lista de sonidos de emergencia (debes agregar los archivos en assets/audio/)
  final List<Map<String, String>> emergencySounds = [
    {'label': 'Barcelona', 'file': 'Barcelona.mp3'},
    {'label': 'Real madrid', 'file': 'Madrid.mp3'},
    {'label': 'Liverpool', 'file': 'Liverpool.mp3'},
    {'label': 'Bayern Munich', 'file': 'Bayern.mp3'},
  ];

  void _playSound(String fileName) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/$fileName'));
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text(
        'Equipos de Futbol',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
          fontSize: 26,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¡Reproduce sonido de tu equipo favorito!',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E88E5), // Azul vibrante
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  color: Colors.black26,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Botones generados dinámicamente desde la lista de sonidos
          ...emergencySounds.map(
            (sound) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(270, 65),
                  backgroundColor: const Color(0xFF43A047), // Verde fuerte
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    letterSpacing: 1.2,
                  ),
                ),
                icon: const Icon(Icons.sports_soccer, size: 32),
                label: Text(sound['label']!),
                onPressed: () => _playSound(sound['file']!),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}