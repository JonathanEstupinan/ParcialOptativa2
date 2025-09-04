import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UBIAPPS',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D47A1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6F00),
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6F00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            shadowColor: Colors.black54,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, String>> emergencyItems = [
    {
      'label': 'Ingresa',
      'image': 'assets/images/Ingresa.PNG',
    },
    {
      'label': 'Nosotros',
      'image': 'assets/images/Nosotros.PNG',
    },
    {
      'label': 'Contáctanos',
      'image': 'assets/images/Contactanos.PNG',
    },
    {
      'label': 'Campo',
      'image': 'assets/images/Campo.PNG',
      'audio': 'assets/audio/Campo.mp3',
    },
  ];

  void _playAudio(String audioPath) async {
    await _audioPlayer.stop();
    final relativePath = audioPath.replaceFirst('assets/', '');
    await _audioPlayer.play(AssetSource(relativePath));
  }

  void _openImage(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageViewer(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UBIAPPS',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 30,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const Text(
                '¡INTERACTÚA CON LA APP!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: emergencyItems.length,
                  itemBuilder: (context, index) {
                    final item = emergencyItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          if (item['label'] == 'Campo' && item['audio'] != null) {
                            _playAudio(item['audio']!);
                          } else {
                            _openImage(item['image']!);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              item['label']!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.image, size: 30, color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String imagePath;

  const ImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
