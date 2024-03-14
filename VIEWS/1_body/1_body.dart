import 'package:flutter/material.dart';
import 'Widget_classes/Slider2.dart';
import 'Widget_classes/slider1.dart';
import 'Widget_classes/Advertise_widget_mini.dart';
import '../2_body/Widget_classes/featuring_panel.dart';
import '../2_body/Widget_classes/title_with_more_btn.dart';
import 'Widget_classes/AppBar1.dart';
import 'Widget_classes/Advertise_widget.dart';



class body_1 extends StatefulWidget {
  @override
  State<body_1> createState() => _body_1State();
}
class _body_1State extends State<body_1>  with AutomaticKeepAliveClientMixin{

  bool get wantKeepAlive=> true;
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(

     appBar: Appbar1(),
      body:
      RefreshIndicator(
          color: Colors.blue,
          displacement: 20,
          onRefresh: () async {
          },
          child:
          SingleChildScrollView(
          //  physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                HomeCarouselSlider1(),
                Advertise_widgetMini(),
                Advertisewidget( Subcollection: 'Add1',),
                TitleWithMoreBtn( title: 'Title4', size: 13, position: 'CenterLeft', background: true,),
                Home_slider(),
                Advertisewidget(Subcollection: 'Add2',),
                TitleWithMoreBtn(title: 'Title2', size: 13, position: 'CenterLeft', background: true,),
                FeaturingPanel(),
                SizedBox(height: 80,)
              ],
            ),
          )
      )
    );
  }
}




