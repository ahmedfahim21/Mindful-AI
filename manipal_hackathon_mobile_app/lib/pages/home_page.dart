import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/message_screen.dart';
import 'package:manipal_hackathon_mobile_app/pages/questionnaire_page.dart';
import 'package:manipal_hackathon_mobile_app/pages/registration_page.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> loggingOut = ValueNotifier(false);
  ValueNotifier<bool> uploadingBodyVitals = ValueNotifier(false);
  ValueNotifier<bool> uploadingVideo = ValueNotifier(false);
  late bool justRegistered = false;

  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
  final List<HealthDataType> types = [
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_LIGHT,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_REM,
    HealthDataType.SLEEP_SESSION,
  ];

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    justRegistered = prefs.getBool("just_registered") ?? true;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return justRegistered
        ? RegPage(onRegComplete: refresh)
        : SafeArea(
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: blueColour, width: 1)),
                  elevation: 20,
                  splashColor: blueColour,
                  backgroundColor: backgroundColour,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MessagesScreen();
                    }));
                  },
                  child: Image.asset(
                    "assets/ai_chatbot.png",
                    width: 35,
                  ),
                ),
                backgroundColor: backgroundColour,
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 50),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Welcome Back!",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () async {
                                    loggingOut.value = true;
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.clear();
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((value) {
                                      loggingOut.value = false;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Logged out..."),
                                              backgroundColor: Color.fromARGB(
                                                  204, 78, 201, 140),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight: Radius
                                                              .circular(15)),
                                                  side: BorderSide(
                                                      color: Color.fromARGB(
                                                          204, 78, 201, 140),
                                                      width: 2))));
                                    });
                                    // });
                                  },
                                  child: ValueListenableBuilder(
                                      valueListenable: loggingOut,
                                      builder: (context, value, child) {
                                        return loggingOut.value
                                            ? const Center(
                                                child: SizedBox(
                                                  height: 15,
                                                  width: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: greenColour,
                                                  ),
                                                ),
                                              )
                                            : Icon(Icons.logout,
                                                color: Colors.redAccent[200]
                                                    ?.withOpacity(0.85),
                                                size: 20);
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Information Technology Department",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[500]),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "National Institute of Technology, Karnataka",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[500]),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     uploadVideo(context);
                            //   },
                            //   child: Image.asset(
                            //     'assets/upload_video.png',
                            //   ),
                            // ),
                            InkWell(
                                onTap: () async {
                                  await uploadVideo(context);
                                },
                                child: ValueListenableBuilder(
                                    valueListenable: uploadingVideo,
                                    builder: (context, value, child) {
                                      return Stack(
                                        children: [
                                          Image.asset(
                                            'assets/upload_video_loading.png',
                                          ),
                                          Visibility(
                                            visible: !uploadingVideo.value,
                                            child: Image.asset(
                                              'assets/upload_video.png',
                                            ),
                                          )
                                        ],
                                      );
                                    })),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () {
                                  uploadBodyVitals(context);
                                  // Timer t = Timer(Duration(seconds: 1), () {
                                  //   uploadingBodyVitals.value = false;
                                  // });
                                  // setState(() {});
                                  // uploadingBodyVitals.value = true;
                                },
                                child: ValueListenableBuilder(
                                    valueListenable: uploadingBodyVitals,
                                    builder: (context, value, child) {
                                      return Stack(
                                        children: [
                                          Image.asset(
                                            'assets/body_vitals_loading.png',
                                          ),
                                          Visibility(
                                            visible: !uploadingBodyVitals.value,
                                            child: Image.asset(
                                              'assets/body_vitals.png',
                                            ),
                                          )
                                        ],
                                      );
                                    })),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const QuestionnaireWidget();
                                }));
                              },
                              child: Image.asset(
                                'assets/take_questionnaire.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: uploadingBodyVitals,
                      builder: (context, value, child) => InkWell(
                        onTap: () {},
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        child: value
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              )
                            : const SizedBox(),
                      ),
                    )
                  ],
                )));
  }

  Future<void> uploadVideo(BuildContext context) async {
    Permission permission =
        Platform.isAndroid ? Permission.storage : Permission.photos;
    await permission.request();

    if (await permission.isDenied ||
        await permission.isPermanentlyDenied ||
        await permission.isRestricted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Grant Media Permission')));
      });
    } else if (await permission.isGranted || await permission.isLimited) {
      XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video != null) {
        uploadingVideo.value = true;
        final storageRef = FirebaseStorage.instance.ref();
        await storageRef
            .child('${FirebaseAuth.instance.currentUser?.uid}/video.mp4')
            .putFile(File(video.path));
        uploadingVideo.value = false;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Your Video has been uploaded!')));
        });
      }
    }
    return Future.value();
  }

  Future<List<TimeStampData>> fetchData() async {
    List<TimeStampData> finalHealthData = [];
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 100));
    List<HealthDataPoint> healthDataList = [];

    try {
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      healthDataList.addAll(healthData);
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Couldn\'t retreive health data from Google Fit!')));
      });
    }

    healthDataList = HealthFactory.removeDuplicates(healthDataList);

    for (var element in healthDataList) {
      if (element.type == HealthDataType.SLEEP_SESSION) {
        finalHealthData.add(Sleep(
            duration: element.value.toString(),
            start: element.dateFrom,
            end: element.dateTo));
      } else if (element.type == HealthDataType.HEART_RATE) {
        finalHealthData.add(HeartRate(
            bpm: element.value.toString(),
            start: element.dateFrom,
            end: element.dateTo));
      } else if (element.type == HealthDataType.STEPS) {
        finalHealthData.add(Steps(
            count: element.value.toString(),
            start: element.dateFrom,
            end: element.dateTo));
      }
    }
    return finalHealthData;
  }

  Future<void> uploadBodyVitals(BuildContext context) async {
    uploadingBodyVitals.value = true;
    await authorize();
    List<TimeStampData> data = await fetchData();
    for (TimeStampData element in data) {
      if (element is HeartRate) {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('body_vitals')
            .add({"created_at": DateTime.now(), "heartrate": element.bpm});
      }
    }
    uploadingBodyVitals.value = false;
  }

  Future authorize() async {
    await Permission.activityRecognition.request();

    final permissions = types.map((e) => HealthDataAccess.READ).toList();

    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    hasPermissions = false;

    // bool authorized = false;
    if (!hasPermissions) {
      try {
        await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("Exception in authorize: $error");

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Couldn\'t authorize Google Fit!')));
        });
      }
      print("Authorization Granted!");
    }
  }
}

class TimeStampData {
  final DateTime start;
  final DateTime end;

  const TimeStampData({required this.start, required this.end});
}

class HeartRate extends TimeStampData {
  final String bpm;

  const HeartRate(
      {required this.bpm, required DateTime start, required DateTime end})
      : super(start: start, end: end);
  // Map<String>
}

class Sleep extends TimeStampData {
  final String duration;

  const Sleep(
      {required this.duration, required DateTime start, required DateTime end})
      : super(start: start, end: end);
}

class Steps extends TimeStampData {
  final String count;

  const Steps(
      {required this.count, required DateTime start, required DateTime end})
      : super(start: start, end: end);
}
