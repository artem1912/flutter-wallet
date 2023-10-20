import 'package:crypto_wallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../common_widgets/inputFields.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({super.key});

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  var isMe = false;
  List messagesList = [
    {
      "text": "how are you",
      "s": true,
    },
    {
      "text": "how are you",
      "isMe": false,
    },
    {
      "text": "how are you",
      "isMe": true,
    },
    {
      "text": "how are you",
      "isMe": true,
    },
    {
      "text": "how are you",
      "isMe": false,
    },
    {
      "text": "how are you",
      "isMe": true,
    },
    {
      "text": "how are you",
      "isMe": true,
    },
    {
      "text": "how are you",
      "isMe": false,
    },
    {
      "text": "how are you",
      "isMe": true,
    },
    {
      "text": "how are you",
      "isMe": false,
    },
    {
      "text": "how are you",
      "isMe": true,
    }
  ];
  var isTyping = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                child: Icon(Icons.arrow_back_ios),
                                width: 30,
                                height: 40,
                                color: Colors.transparent,
                              ),
                            ),
                            Image.asset(
                              "assets/imgs/contacts.png",
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dev Test",
                                  style: TextStyle(color: inputFieldTextColor.value, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "sfpro"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black12.withOpacity(0.08),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: messagesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: messagesList[index]['isMe'] == true ? MainAxisAlignment.end : MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: Get.width * 0.75, minWidth: Get.width * 0.1),
                                      child: DecoratedBox(
                                        decoration: messagesList[index]['isMe'] == true
                                            ? BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(0), topRight: Radius.circular(15)),
                                                color: primaryColor.value)
                                            : BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(15), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                                                color: chatBoxBg.value),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          child: Text(
                                            "Message content goes here asjdb sadasjas dahsjas dsa djhas bjdas d sadbsakjbdkb kdsajkdksabd k asdbksa jask djbska jsdbk baksdjb k ajdskajs bdksjad bd b",
                                            style: TextStyle(
                                                color: messagesList[index]['isMe'] == true ? lightColor : placeholderColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "sfpro"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width - 94,
                        child: InputFields(
                          textController: TextEditingController(),
                          headerText: '',
                          hintText: 'Write a message',
                          hasHeader: true,
                          onChange: (value) {
                            //nameError.value = '';
                          },
                          suffixIcon: RotationTransition(
                            turns:AlwaysStoppedAnimation(25 / 360),
                            child: Icon(Icons.attach_file_outlined,color: primaryColor.value,),),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor.value,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: 50,
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/send.svg',
                                  color: lightColor,
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
