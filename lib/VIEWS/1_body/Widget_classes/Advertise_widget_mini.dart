

import 'package:flutter/material.dart';

class panel extends StatelessWidget {
  const panel({super.key});

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Container(

      width: size.width,
      child: Column(
        children: [
          Row(

            children: [

              Card(
                elevation: 2,
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assists/icons/Screenshot 2024-02-25 002306.png"),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 22,),
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(0),
                    child: Container(
                       height: size.height*0.2,
                       width: size.width*0.5-28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: AssetImage("assists/icons/Screenshot 2024-02-25 002315.png",),
                                fit: BoxFit.cover
                            ),

                      ),

                    ),
                  ),
                ],
              )
            ],
          ),

          Row(
            children: [
              Card(
                elevation: 2,
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.5-20,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assists/icons/Screenshot 2024-02-25 002327.png"),
                       fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(

               alignment: Alignment.center,
                height: size.height*0.2,
                width: size.width*0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
               //   color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Browse Mens stylish top-wear clothes",style: TextStyle(
                      fontFamily: "light1",
                      fontWeight: FontWeight.bold
                    ),),
                    Container(
                     padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Shop collection",style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),),
                    )


                  ],
                ),

              )
            ],
          )
        ],
      ),
    );
  }
}
