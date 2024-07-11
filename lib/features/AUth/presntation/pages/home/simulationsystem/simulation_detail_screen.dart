// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'simulation_model.dart';

// class SimulationDetailScreen extends StatefulWidget {
//   final Simulation simulation;

//   SimulationDetailScreen({required this.simulation});

//   @override
//   _SimulationDetailScreenState createState() => _SimulationDetailScreenState();
// }

// class _SimulationDetailScreenState extends State<SimulationDetailScreen> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.simulation.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.simulation.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   )
//                 : Container(),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 widget.simulation.description,
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             SizedBox(height: 20),
//             _controller.value.isInitialized
//                 ? IconButton(
//                     icon: Icon(
//                       _isPlaying ? Icons.pause : Icons.play_arrow,
//                       size: 50,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isPlaying ? _controller.pause() : _controller.play();
//                         _isPlaying = !_isPlaying;
//                       });
//                     },
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
