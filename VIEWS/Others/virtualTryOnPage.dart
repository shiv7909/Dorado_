import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';




class ModelView extends StatefulWidget {
  ModelView({Key? key,required this.link}) : super(key: key);
 final String link;
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
        body: widget.link.isNotEmpty?
        Container(
          child:  ModelViewer(
            backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
            src: "assists/images/running_shoes_-_brooks.glb",
            alt: 'A 3D model of an astronaut',
            ar: true,
           arPlacement: ArPlacement.floor,
            arModes: ['scene-viewer'],
            // autoRotate: true,
            cameraControls: true,
          ),
        ):Container(
          child:CircularProgressIndicator(),
        ),
      ),
    );
  }
}

