import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'pages/loading_page.dart';
import 'providers/rover_provider.dart';

void main() async {
  await dotenv.load();
  runApp(const MarsRoverApp());
}

class MarsRoverApp extends StatelessWidget {
  const MarsRoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoverProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mars Rover Photos',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const LoadingPage("Curiosity"),
      ),
    );
  }
}
