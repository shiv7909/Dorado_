

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CONTROLLERS/auth_controller.dart';
import '../../MODELS/constants.dart';
import '../1_body/1_body.dart';
import '../MainHome.dart';
import 'Forget_password.dart';
import 'Signup_form.dart';
import 'googlesignIn.dart';



class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController emailC = TextEditingController();
  Google_signin  sign_in=Get.put(Google_signin());
  TextEditingController passwordC = TextEditingController();

  Future<void> handleLogin() async {
    try {
      await Auth_controller.instance.login(emailC.text.trim(), passwordC.text.trim());
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Get.to(() => body_1());
      } else {
        print("Error: User not found"); // Handle error if user is null
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException manually
      if (e.code == 'user-not-found') {
        print("Error: User not found");
      } else {
        print("Error: ${e.code}"); // Handle other FirebaseAuthException codes
      }
    } catch (e) {
      print("Error: $e"); // Handle other exceptions
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
        //
        // class Background extends StatelessWidget {
        // const Background({Key? key}) : super(key: key);
        //
        // @override
        // Widget build(BuildContext context) {
        // return
        // Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        // gradient: LinearGradient(
        // colors: [  Colors.blue[50]!.withOpacity(0.6), // Adjust opacity for darker shade
        //     Colors.blueAccent.withOpacity(0.6), // Adjust opacity for darker shade
        //     Colors.purple[300]!.withOpacity(0.6), ],
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter),
        // ),),
        // // );
        // // }
        // // }

            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
              //  width: 327,
                child: Column(children: [
                  Text(
                    'Hi, Welcome Back!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ).copyWith(color: AppColor.kGrayscaleDark100, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We happy to see you. Sign In to your account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.kWhite)
                        .copyWith(color: AppColor.kGrayscale40, fontSize: 14),
                  ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.kWhite)
                            .copyWith(
                            color: AppColor.kGrayscaleDark100,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      PasswordTextField(
                          hintText: 'Password',
                          controller: passwordC,
                          width: 327,
                          height: 52, borderRadius: BorderRadius.circular(0),)
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryTextButton(
                        onPressed: () {
                          Get.to(()=>Forget());
                        },
                        title: 'Forgot Password?',
                        textStyle: const TextStyle(),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    children: [
                      PrimaryButton(
                        elevation: 0,
                        onTap: () {
                          handleLogin();
                        },
                        text: 'LogIn',
                        bgColor:Color(0xC72F3134),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Column(
                      children: [
                        const DividerRow(title: 'Or Sign In with'),
                        const SizedBox(height: 24),
                        SecondaryButton(
                            height: 56,
                            textColor: AppColor.kGrayscaleDark100,
                            width: 280,
                            onTap: () async {
                              // bool success = await
                              await sign_in.signInWithGoogle();

                            },
                            borderRadius: 24,
                            bgColor: AppColor.kBackground.withOpacity(0.3),
                            text: 'Continue with Google',
                            icons: ImagesPath.kGoogleIcon
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TermsAndPrivacyText(
                      title1: '  By signing up you agree to our',
                      title2: ' Terms ',
                      title3: '  and',
                      title4: ' Conditions of Use',
                    ),
                  ),
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



class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText(
      {super.key,
        required this.title1,
        required this.title2,
        required this.title3,
        this.color2,
        required this.title4});
  final Color? color2;
  final String title1, title2, title3, title4;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColor.kWhite)
            .copyWith(
            color: AppColor.kGrayscale40,
            fontWeight: FontWeight.w500,
            fontSize: 12),
        children: [
          TextSpan(
            text: title1,
          ),
          TextSpan(
            text: title2,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite)
                .copyWith(
                color: color2 ?? AppColor.kGrayscaleDark100,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          TextSpan(
            text: title3,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite)
                .copyWith(
                color: AppColor.kGrayscale40,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          TextSpan(
            text: title4,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite)
                .copyWith(
                color: AppColor.kGrayscaleDark100,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class SecondaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text, icons;
  final double width;
  final double height;
  final double borderRadius;
  final double? fontSize;
  final Color textColor, bgColor;
  const SecondaryButton(
      {super.key,
        required this.onTap,
        required this.text,
        required this.width,
        required this.height,
        required this.icons,
        required this.borderRadius,
        this.fontSize,
        required this.textColor,
        required this.bgColor});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          height: widget.height,
          alignment: Alignment.center,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: AppColor.kLine),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              Image.asset(widget.icons, width: 23.85, height: 23.04),
              const SizedBox(width: 12),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(widget.text,
                      style: GoogleFonts.plusJakartaSans(

                          fontWeight: FontWeight.w500,
                          color: AppColor.kWhite)
                          .copyWith(
                        color: widget.textColor,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerRow extends StatelessWidget {
  final String title;
  const DividerRow({
    required this.title,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Divider(
              color: AppColor.kLine,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite)
                .copyWith(
                color: AppColor.kGrayscale40,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
        Expanded(
            flex: 2,
            child: Divider(
              color: AppColor.kLine,
            ))
      ],
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
              color: Colors.brown,
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

class PrimaryTextButton extends StatefulWidget {
  const PrimaryTextButton(
      {super.key,
        required this.onPressed,
        required this.title,
        required this.textStyle});
  final Function() onPressed;
  final String title;
  final TextStyle textStyle;

  @override
  State<PrimaryTextButton> createState() => _PrimaryTextButtonState();
}

class _PrimaryTextButtonState extends State<PrimaryTextButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Text(
        widget.title,
        style: widget.textStyle,
      ),
    );
  }
}


class PasswordTextField extends StatefulWidget {
  final String hintText;

  final double width, height;
  final TextEditingController controller;
  final BorderRadiusGeometry borderRadius;
  const PasswordTextField(
      {Key? key,
        required this.hintText,
        required this.height,
        required this.controller,
        required this.width,
        required this.borderRadius})
      : super(key: key);
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    InputBorder enabledBorder = InputBorder.none;
    InputBorder focusedErrorBorder = InputBorder.none;
    InputBorder errorBorder = InputBorder.none;
    InputBorder focusedBorder = InputBorder.none;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: AppColor.kBackground2,
          border: Border.all(color: AppColor.kLine)),
      child: TextFormField(
          obscureText: _obscureText,
          controller: widget.controller,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.kWhite)
              .copyWith(
            color: AppColor.kGrayscaleDark100,
          ),
          decoration: InputDecoration(
            filled: true,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColor.kGrayscaleDark100,
                size: 17,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite)
                .copyWith(
                color: AppColor.kGrayscale40,
                fontWeight: FontWeight.w600,
                fontSize: 14),
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
          )),
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












class AnimatedGradientBackground extends StatefulWidget {
  const AnimatedGradientBackground({super.key});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignment;
  late Animation<Alignment> _bottomAlignment;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _topAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.centerRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.centerRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.centerLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.centerLeft, end: Alignment.topLeft),
          weight: 1),
    ]).animate(_controller);

    _bottomAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.centerLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.centerLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.centerRight),
          weight: 1),
      TweenSequenceItem(
          tween: Tween<Alignment>(
              begin: Alignment.centerRight, end: Alignment.bottomRight),
          weight: 1)
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: _topAlignment.value,
                    end: _bottomAlignment.value,
                    colors: const [
                      Color(0xffF99E43),
                      Color(0xffDA2323),
                    ])),
          );
        });
  }
}