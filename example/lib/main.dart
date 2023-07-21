import 'package:flutter/material.dart';
import 'package:neurons_tree_widget/neurons_tree_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neurons Tree Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neurons Tree Widget'),
      ),
      body: const Center(
        child: NeuronsTreeWidget(
          data: [
            [true, true, true, true],
            [true, true, true, false],
            [false, true, false],
          ],
          // orientation: Axis.vertical,
        ),
      ),
    );
  }
}
