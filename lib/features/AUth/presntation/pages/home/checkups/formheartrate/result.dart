import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  Future<int> _fetchResult() async {
    final database = FirebaseDatabase.instance.ref();
    final event = await database.child('model_result/model_result').once();
    final snapshot = event.snapshot;
    if (snapshot.value != null) {
      return snapshot.value as int;
    } else {
      throw Exception('Result not found in the database');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<int>(
          future: _fetchResult(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            } else {
              final result = snapshot.data!;
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: result == 0 ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        result == 0
                            ? Icons.check_circle_outline
                            : Icons.error_outline,
                        size: 100,
                        color: result == 0 ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        result == 0
                            ? 'You are right and everything is okay!'
                            : 'You are not right and your heart is not normal!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: result == 0 ? Colors.green : Colors.red,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
