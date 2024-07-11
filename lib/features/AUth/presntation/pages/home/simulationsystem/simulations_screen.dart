// import 'package:flutter/material.dart';
// import 'simulation_detail_screen.dart';
// import 'simulation_model.dart';

// class SimulationsScreen extends StatelessWidget {
//   final List<Simulation> simulations;

//   SimulationsScreen({required this.simulations});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Simulations'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: simulations.length,
//         itemBuilder: (context, index) {
//           final simulation = simulations[index];
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               leading: Icon(Icons.videocam, color: Colors.red, size: 40),
//               title: Text(
//                 simulation.title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(simulation.description),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SimulationDetailScreen(simulation: simulation),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
