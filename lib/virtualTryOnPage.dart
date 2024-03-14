

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:url_launcher/url_launcher.dart';



class ModelView extends StatefulWidget {
  ModelView({Key? key}) : super(key: key);

  @override
  State<ModelView> createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text('3D view', style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w500,
        )
            .copyWith(
          color: Colors.black.withOpacity(0.9),
          fontWeight: FontWeight.bold,
              fontSize: 15

        )),
          centerTitle:true,
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_back_ios_new_rounded,size: 18,)),
          ),
        ),
        body: Container(
          child: const ModelViewer(
            backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
            src: 'assists/images/running_shoes_-_brooks.glb',
            alt: 'A 3D model of an astronaut',
            ar: true,
           // arPlacement: ArPlacement.values,
            arModes: ['scene-viewer'],
            // autoRotate: true,
            cameraControls: true,
            // disableZoom: false,
          ),
        ),
      ),
    );
  }
}




//
//
//
//
//
//
//
//
//
//
//


// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
//
// bool removeARScreen = false; // Global variable to control ARScreen removal
//
// class ArScreen extends StatefulWidget {
//   @override
//   State<ArScreen> createState() => _ArScreenState();
// }
//
// class _ArScreenState extends State<ArScreen> {
//   late ArCoreController arCoreController;
//
//   @override
//   Widget build(BuildContext context) {
//     if (removeARScreen) {
//       return Container(); // An empty container effectively removes the AR screen
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('AR Screen'),
//         ),
//         body: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated,
//         ),
//       );
//     }
//   }
//
//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     _addSphere(arCoreController);
//     _addCylinder(arCoreController);
//     _addCube(arCoreController);
//     _addGLBModel(arCoreController);
//   }
//
//   void _addSphere(ArCoreController controller) {
//     final material = ArCoreMaterial(
//         color: Color.fromARGB(120, 66, 134, 244));
//     final sphere = ArCoreSphere(
//       materials: [material],
//       radius: 0.1,
//     );
//     final node = ArCoreNode(
//       shape: sphere,
//       position: vector.Vector3(0, 0, -1.5),
//     );
//     controller.addArCoreNode(node);
//   }
//
//   Future<void> _addGLBModel(ArCoreController controller) async {
//     final glbBytes = await rootBundle.load('assets/your_model.glb');
//     final node = ArCoreNode(
//       shape: ArCoreModel(
//         scale: vector.Vector3(0.1, 0.1, 0.1), // Adjust scale as needed
//         data: glbBytes.buffer.asUint8List(),
//         materials: [],
//       ),
//       position: vector.Vector3(0.0, 0.0, -2.0), // Adjust position as needed
//     );
//     controller.addArCoreNode(node);
//   }
//
//   void _addCylinder(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Colors.red,
//       reflectance: 1.0,
//     );
//     final cylinder = ArCoreCylinder(
//       materials: [material],
//       radius: 0.5,
//       height: 0.3,
//     );
//     final node = ArCoreNode(
//       shape: cylinder,
//       position: vector.Vector3(0.0, -0.5, -2.0),
//     );
//     controller.addArCoreNode(node);
//   }
//
//   void _addCube(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Color.fromARGB(120, 66, 134, 244),
//       metallic: 1.0,
//     );
//     final cube = ArCoreCube(
//       materials: [material],
//       size: vector.Vector3(0.5, 0.5, 0.5),
//     );
//     final node = ArCoreNode(
//       shape: cube,
//       position: vector.Vector3(-0.5, 0.5, -3.5),
//     );
//     controller.addArCoreNode(node);
//   }
//
//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }
// }
