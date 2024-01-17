import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/pages/home_page.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegPage extends StatefulWidget {
  final Function onRegComplete;
  const RegPage({super.key, required this.onRegComplete});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  bool? genderMale;
  String birthday = "";
  String selectedCollege = "";
  String selectedBranch = "";

  @override
  void initState() {
    super.initState();
    DateTime bd = DateTime.now();
    birthday =
        "${bd.day < 10 ? "0${bd.day}" : "${bd.day}"} / ${bd.month < 10 ? "0${bd.month}" : "${bd.month}"} / ${bd.year}";
    selectedCollege = colleges[0];
    selectedBranch = branches[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColour,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 35.0),
                child: Column(children: [
                  Image.asset(
                    'assets/Logo_for_non_white_backgrounds.png',
                    height: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "A little about yourself ✨",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      labelText: 'Your Full Name',
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // hintText: 'Enter Your Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Choose you Gender:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            genderMale = true;
                          });
                        },
                        child: GenderWidget(
                          male: true,
                          maleSelected: genderMale,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            genderMale = false;
                          });
                        },
                        child: GenderWidget(
                          male: false,
                          maleSelected: genderMale,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "When's your Birthday 🎂?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  // SizedBox(
                  //   width: 60,
                  //   height: 30,
                  //   child: TextFormField(
                  //     // textAlignVertical: TextAlignVertical.center,
                  //     // showCursor: false,,
                  //     keyboardType: TextInputType.number,
                  //     controller: dayController,
                  //     decoration: InputDecoration(
                  //       floatingLabelBehavior: FloatingLabelBehavior.never,
                  //       filled: true,
                  //       fillColor: Colors.white.withOpacity(0.7),
                  //       label: const Center(
                  //         child: Text("Day"),
                  //       ),
                  //       labelStyle: const TextStyle(
                  //           fontSize: 14, fontWeight: FontWeight.w500),
                  //       contentPadding:
                  //           const EdgeInsets.only(left: 18, bottom: 6),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //             color: greenColour, width: 2),
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Empty!';
                  //       }
                  //       if (!(int.parse(value) >= 1 &&
                  //           int.parse(value) <= 31)) {
                  //         return 'Invalid';
                  //       }
                  //       return null;
                  //     },
                  // ),
                  // ),
                  // Column(
                  //   children: [Text("Month:")],
                  // ),
                  // Column(
                  //   children: [Text("Year:")],
                  // )

                  // ],
                  // )
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.7)),
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Center(
                                  child: Text(
                                    birthday,
                                    style: const TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime bd = await pickBirthday(context);
                            setState(() {
                              birthday =
                                  "${bd.year}-${bd.month < 10 ? "0${bd.month}" : "${bd.month}"}-${bd.day < 10 ? "0${bd.day}" : "${bd.day}"}";
                            });
                          },
                          child: const Icon(
                            Icons.calendar_month,
                            color: blueColour,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Which College do you study at? 🏫",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: blueColour,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Choose your College',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: colleges
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedCollege,
                      onChanged: (value) {
                        setState(() {
                          selectedCollege = value ?? colleges[0];
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          // border: Border.all(
                          //   color: Colors.black,
                          // ),
                          color: Colors.white,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: blueColour,
                        ),
                        iconSize: 20,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "What Department do you study at? 📖",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: blueColour,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Choose your Department',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: branches
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedBranch,
                        onChanged: (value) {
                          setState(() {
                            selectedBranch = value ?? branches[0];
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.black,
                            // ),
                            color: Colors.white,
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: blueColour,
                          ),
                          iconSize: 20,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RawMaterialButton(
                      elevation: 4,
                      fillColor: greenColour,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          CollectionReference students =
                              FirebaseFirestore.instance.collection('students');
                          students
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .set({
                            'name': nameController.text,
                            'gender': genderMale == true ? 'Male' : 'Female',
                            'dob': birthday,
                            'institute': selectedCollege == colleges[0] ? "MIT" : "NITK",
                            'dept': selectedBranch,
                          });

                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.setBool("just_registered", false);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            SharedPreferences.getInstance().then((value) {
                              widget.onRegComplete();
                            });
                          });
                        }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ))
                ]),
              ),
            ),
          )),
    );
  }
}

Future<DateTime> pickBirthday(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025));
  return pickedDate ?? DateTime.now();
}

class GenderWidget extends StatelessWidget {
  final bool male;
  final bool? maleSelected;
  const GenderWidget(
      {super.key, required this.male, required this.maleSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: maleSelected == null
                        ? backgroundColour
                        : (male && maleSelected!) || (!male && !maleSelected!)
                            ? greenColour
                            : backgroundColour),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 18.0),
                  child: Image.asset(
                    male
                        ? "assets/icon_male_white.png"
                        : "assets/icon_female_white.png",
                    color: maleSelected == null
                        ? Colors.black
                        : male && maleSelected! || (!male && !maleSelected!)
                            ? white
                            : Colors.black,
                  ),
                )),
            const SizedBox(width: 15),
            Text(
              male ? "Male" : "Female",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: maleSelected == null
                      ? black
                      : male && maleSelected! || (!male && !maleSelected!)
                          ? greenColour
                          : black),
            )
          ],
        ),
      ),
    );
  }
}

List<String> colleges = [
  "Manipal Institute of Technology",
  "National Institute of Technology Karnataka",
];

List<String> branches = [
  "Computer Science",
  "Electrical Engineering",
  "Mechanical Engineering",
  "Civil Engineering",
];
