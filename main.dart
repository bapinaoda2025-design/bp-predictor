import 'package:flutter/material.dart';

void main() {
  runApp(const PredictorApp());
}

class PredictorApp extends StatelessWidget {
  const PredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PredictorScreen(),
    );
  }
}

class PredictorScreen extends StatefulWidget {
  @override
  State<PredictorScreen> createState() => _PredictorScreenState();
}

class _PredictorScreenState extends State<PredictorScreen> {
  final List<String> _results = [];
  String? _prediction;

  void _addResult(String value) {
    setState(() {
      if (_results.length == 10) {
        _results.removeAt(0);
      }
      _results.add(value);

      int bigCount = _results.where((r) => r == "B").length;
      int smallCount = _results.where((r) => r == "S").length;

      // prediction logic
      _prediction = bigCount > smallCount ? "Next: B" : "Next: S";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BP Predictor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Last 10 Results: ${_results.join(", ")}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "Prediction: ${_prediction ?? "?"}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _addResult("B"),
                  child: const Text("Add B"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _addResult("S"),
                  child: const Text("Add S"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}