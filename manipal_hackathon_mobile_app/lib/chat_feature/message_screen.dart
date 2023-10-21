import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/constants.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColour,
      body: Body(),
    );
  }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back_ios_rounded,
//           color: Colors.white,
//           size: 20,
//         ),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       backgroundColor: kDarkGreen,
//       automaticallyImplyLeading: false,
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white.withOpacity(0.2),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(
//               bottom: 6.0, left: 4.0, right: 4.0, top: 4.0),
//           child: RichText(
//             text: const TextSpan(children: [
//               TextSpan(
//                   text: "Your AI Friend! ",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//               TextSpan(
//                   text: "🙋",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
}
