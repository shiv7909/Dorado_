//
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ArScreen extends StatefulWidget {
//   @override
//   _ArScreenState createState() => _ArScreenState();
// }
//
// class _ArScreenState extends State<ArScreen> {
//   ArController arController;
//   ArCoreNode modelNode;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AR View'),
//       ),
//       body: Center(
//         child: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//           enableTapRecognizer: true,
//         ),
//       ),
//     );
//   }
//
//   void _onArCoreViewCreated(ArCoreController controller) {
//     arController = controller;
//     _loadModel();
//   }
//
//   Future<void> _loadModel() async {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     StorageReference modelRef = storage.ref().child('out.glb');
//
//     try {
//       final modelFile = await modelRef.writeToFile();
//
//       modelNode = ArCoreReferenceNode(
//         name: 'model',
//         objectUrl: modelFile.path,
//       );
//
//       arController.addArCoreNode(modelNode);
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     arController.dispose();
//     super.dispose();
//   }
// }
