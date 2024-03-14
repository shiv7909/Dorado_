



import 'package:flutter/material.dart';
import 'package:untitled1/VIEWS/2_body/Widget_classes/Product_ramp_grid.dart';

class Grid_show extends StatelessWidget {
    const Grid_show({required this.title});
    final String title;
    @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Scaffold(
            body: Product_ramp(panel:title),
          ),
        ),
      );
    }
  }
