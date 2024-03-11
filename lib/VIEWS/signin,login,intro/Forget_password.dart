





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/VIEWS/MainHome.dart';

import '../../MODELS/constants.dart';
import '../1_body/1_body.dart';
import 'Signup_form.dart';

class Forget extends StatefulWidget {
  Forget({super.key});

  @override
  State<Forget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<Forget> {



  String Email='';
  TextEditingController emailC = TextEditingController();


// final _formKey=GlobalKey<FormState>();

resetPassword()async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailC.text.trim());
    Get.snackbar(
      "Sent !",
      "password reset Email sent to mail !",
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
    );
  }on FirebaseAuthException catch (value){
    Get.snackbar(
      "Email not found!",
      'please enter correct email',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.kWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (){
                 Get.to(()=>Main_Homes_builder());
                },
                child: Text(
                  'SKIP',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    // color: AppColor.kWhite
                  )
                      .copyWith(color: AppColor.kGrayscale40, fontSize: 12.3),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
            children:[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    //  width: 327,
                    child: Column(children: [
                      Text(
                        'Password recovery',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ).copyWith(color: AppColor.kGrayscaleDark100, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 36),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.kWhite)
                                .copyWith(
                                color: AppColor.kGrayscaleDark100,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          PrimaryTextFormField(
                            controller: emailC,
                            width: 327,
                            height: 52,
                            hintText: '',)
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      const SizedBox(height: 16),


                      const SizedBox(height: 32),
                      Column(
                        children: [
                          PrimaryButton(
                            elevation: 0,
                            onTap: () {
                              resetPassword();
                            },
                            text: 'Send EMail',
                            bgColor: Colors.brown,
                            borderRadius: 20,
                            height: 46,
                            width: 327,
                            textColor: AppColor.kWhite,
                            fontSize: 14,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: CustomRichText(
                              title: 'Don’t have an account?',
                              subtitle: ' Create here ',
                              onTab: () {
                                Get.to(()=>Signup());
                              },
                              subtitleTextStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.kWhite)
                                  .copyWith(
                                  color: AppColor.kPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 32),

                      const SizedBox(height: 50),

                      const SizedBox(height: 24),
                    ]),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}


class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTab,
    required this.subtitleTextStyle,
  });
  final String title, subtitle;
  final TextStyle subtitleTextStyle;
  final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.kWhite)
              .copyWith(
              color: AppColor.kGrayscale40,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}



class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  const PrimaryButton(
      {Key? key,
        required this.onTap,
        required this.text,
        this.width,
        this.height,
        this.elevation = 5,
        this.borderRadius,
        this.fontSize,
        required this.textColor,
        required this.bgColor,
        this.iconData})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Text(
              widget.text,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.kWhite)
                  .copyWith(
                  color: widget.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontSize),
            ),
          ),
        ),
      ),
    );
  }
}




class PrimaryTextFormField extends StatelessWidget {
  PrimaryTextFormField(
      {super.key,
        required this.hintText,
        this.keyboardType,
        required this.controller,
        required this.width,
        required this.height,
        this.hintTextColor,
        this.onChanged,
        this.onTapOutside,
        this.prefixIcon,
        this.prefixIconColor,
        this.inputFormatters,
        this.maxLines,
        this.borderRadius});
  final BorderRadiusGeometry? borderRadius;

  final String hintText;

  final List<TextInputFormatter>? inputFormatters;
  Widget? prefixIcon;
  Function(PointerDownEvent)? onTapOutside;
  final Function(String)? onChanged;
  final double width, height;
  TextEditingController controller;
  final Color? hintTextColor, prefixIconColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    InputBorder enabledBorder = InputBorder.none;
    InputBorder focusedErrorBorder = InputBorder.none;
    InputBorder errorBorder = InputBorder.none;
    InputBorder focusedBorder = InputBorder.none;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColor.kBackground,
          border: Border.all(color: AppColor.kLine)),
      child: TextFormField(
         validator: (value){
    if(value==null || value.isEmpty){
      return "please enter the email";
    }
    return null;
         },
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.kWhite)
            .copyWith(
          color: AppColor.kGrayscaleDark100,
        ),
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.kWhite)
              .copyWith(
              color: AppColor.kGrayscaleDark100,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
        ),
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        onTapOutside: onTapOutside,
      ),
    );
  }
}