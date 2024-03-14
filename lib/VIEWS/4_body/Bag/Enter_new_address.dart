import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../CONTROLLERS/user_address_controller/Addadress_controller.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddAddressController fetchaddress = Get.find<AddAddressController>();
  var nameController = TextEditingController();
  var HnoController = TextEditingController();
  var localityController = TextEditingController();
  var townController = TextEditingController();
  var stateController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var pinCodeController = TextEditingController();

  AddAddressController controller = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          centerTitle: true,
          title: Text("Delivery details"),
          titleTextStyle: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800, color: Colors.black54)
              .copyWith(fontSize: 14)),

      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("Name:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: nameController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("house-number:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: HnoController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your house number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("locality/colony:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: localityController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter locality';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("city/town/village:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: townController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city/town/village';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("state:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: stateController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter State';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("Mobile-number:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: phoneNumberController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == String) {
                      return 'Please enter correct  mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text("pincode:",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 14,
                                fontFamily: 'light1',
                                fontWeight: FontWeight.w600,
                                color: Colors.black54))),
                TextFormField(
                  controller: pinCodeController,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 14, fontFamily: 'light1'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 5, bottom: 5, right: 8, left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == String ||
                        value.length != 6) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(""
                      // "please enter correct pincode")));
                      return "Please enter correct pin code";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.addAddress(
                          nameController.text,
                          HnoController.text,
                          localityController.text,
                          townController.text,
                          stateController.text,
                          phoneNumberController.text,
                          pinCodeController.text,
                        );

                        nameController.clear();
                        HnoController.clear();
                        localityController.clear();
                        townController.clear();
                        stateController.clear();
                        phoneNumberController.clear();
                        pinCodeController.clear();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Size size = MediaQuery.of(context).size;
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content:  Column(
                                mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                      "assists/images/tick.json",
                                      height: size.height * 0.25,
                                      width: size.width * 0.4,
                                    ),
                                    Text(
                                      "Address added successfully",
                                      style:GoogleFonts.plusJakartaSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ).copyWith(fontSize: 15),
                                    ),
                                  ],
                              ),
                            );
                          },
                        );
                        fetchaddress.fetchLatestAddress();
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text(
                      'Add Address ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
