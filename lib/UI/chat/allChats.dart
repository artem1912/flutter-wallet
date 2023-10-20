import 'package:crypto_wallet/UI/chat/singleChat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../common_widgets/commonWidgets.dart';

class AllChats extends StatefulWidget {
  const AllChats({super.key});

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.value,
      body: Container(
        height: Get.height,
        child: Column(
          children: [
            Container(
              height: 110,
              padding: EdgeInsets.only(top: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonWidgets().appBar(hasBack: true, title: 'All Chats'),
                ],
              ),
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal:30.0,),
              decoration: BoxDecoration(
                color: primaryBackgroundColor.value,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              constraints: BoxConstraints(minHeight: Get.height - 110,maxHeight: Get.height - 110, minWidth: Get.width),
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16,bottom: 16),
                  itemCount: 18,
                  itemBuilder: (BuildContext context, int index) => chatBox(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16);
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
  Widget chatBox() {
    return GestureDetector(
      onTap: () {
        Get.to(SingleChat());
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: chatBoxBg.value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/imgs/contacts.png",
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Stephen Strange",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: inputFieldTextColor.value,fontFamily: 'sfpro',
                          )),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: Get.width * 0.45,
                        child: Text("You: I had uploaded new files to...jhasdjvasdjhh",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'sfpro',
                              color: placeholderColor,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '2 hours ago',
                  style: TextStyle(fontFamily: 'sfpro', fontWeight: FontWeight.w300,
                      color: placeholderColor,
                      fontSize: 11
                  ),
                ),
                SizedBox(height: 4,),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: redCardColor.value, borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      '20',
                      style: TextStyle(fontFamily: 'sfpro', fontSize: 11, fontWeight: FontWeight.w700, color: lightColor),
                    ),
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
