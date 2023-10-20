import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../services/apiService.dart';
import '../../../services/uploadMediaService.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';
import '../../common_widgets/imagePickerActionSheet.dart';
import '../../common_widgets/inputFields.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool _biomatric = true;

  var _theme = false.obs;
  final appController = Get.find<AppController>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController phoneNumController = new TextEditingController();
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNumController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  File _image = File('');
  var nameErr = ''.obs;
  var phoneErr = ''.obs;
  var bankErr = ''.obs;
  var accountErr = ''.obs;
  var accountNameErr = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    userNameController.text = appController.user.value.fullname ?? '';
    nameController.text = appController.user.value.fullname ?? '';
    phoneNumController.text = appController.user.value.phone ?? '';
    accountNumController.text = appController.user.value.accountNumber ?? '';
    bankNameController.text = appController.user.value.bankName ?? '';
    accountNameController.text = appController.user.value.accountName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: primaryBackgroundColor.value,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 29.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: 35,
                            width: 35,
                            color: Colors.transparent,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: headingColor.value,
                            )),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      (_image.path == '')
                          ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Container(
                                height: 92,
                                width: 92,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: primaryColor.value.withOpacity(0.20)),
                                child: CachedNetworkImage(
                                  imageUrl: appController.user.value?.image ?? '',
                                  errorWidget: (context, url, error) => Icon(Icons.person, size: 32, color: Colors.grey),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // final ImagePicker picker = ImagePicker();
                            // picker.pickImage(source: ImageSource.camera);
                            ImagePickerActionSheet(onCompletion: (fileValue) {
                              if (fileValue == 'No file selected.') {
                              } else {
                                print('file');
                                setState(() {
                                  _image = fileValue;
                                });
                              }
                            }).showImagePickerActionSheet(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.1),
                                blurRadius: 1,
                                spreadRadius: 1,
                              )
                            ]),
                            child: Icon(
                              CupertinoIcons.add,
                              size: 20,
                              color: primaryColor.value,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 56,
                  ),
                  InputFields(
                    headerText: "Enter your username",
                    hintText: "",
                    onChange: (val) {},
                    textController: userNameController,
                    hasHeader: true,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  InputFields(
                    headerText: "First name and Last name",
                    hintText: "",
                    onChange: (val) {
                      nameErr.value = '';
                    },
                    textController: nameController,
                    hasHeader: true,
                  ),
                  CommonWidgets.showErrorMessage(nameErr.value),
                  InputFields(
                    headerText: "Phone  number",
                    hintText: "",
                    inputType: TextInputType.phone,
                    onChange: (val) {
                      phoneErr.value = '';
                    },
                    textController: phoneNumController,
                    hasHeader: true,
                  ),
                  CommonWidgets.showErrorMessage(phoneErr.value),
                  InputFields(
                    headerText: "Name of Bank",
                    hintText: "",
                    onChange: (val) {
                      bankErr.value = '';
                    },
                    textController: bankNameController,
                    hasHeader: true,
                  ),
                  CommonWidgets.showErrorMessage(bankErr.value),
                  InputFields(
                    headerText: "Account Number",
                    hintText: "",
                    onChange: (val) {
                      accountErr.value = '';
                    },
                    textController: accountNumController,
                    hasHeader: true,
                  ),
                  CommonWidgets.showErrorMessage(accountErr.value),
                  InputFields(
                    headerText: "Account Title",
                    hintText: "",
                    onChange: (val) {
                      accountNameErr.value = '';
                    },
                    textController: accountNameController,
                    hasHeader: true,
                  ),
                  CommonWidgets.showErrorMessage(accountNameErr.value),
                  SizedBox(
                    height: 20,
                  ),
                  BottomRectangularBtn(
                    onTapFunc: () {
                      verifyFields();
                    },
                    btnTitle: "Update profile",
                    color: primaryColor.value,
                    loadingText: 'Updating...',
                    isLoading: appController.updateProfileLoader.value,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  verifyFields() async {
    if (nameController.text.trim() == '') {
      nameErr.value = 'Please enter your name';
    } else if (phoneNumController.text.trim() == '') {
      phoneErr.value = 'Please enter your phone number';
    } else if (bankNameController.text.trim() == '') {
      bankErr.value = 'Please enter your bank name';
    } else if (accountNumController.text.trim() == '') {
      accountErr.value = 'Please enter your account number';
    } else if (accountNameController.text.trim() == '') {
      accountNameErr.value = 'Please enter your account title';
    } else {
      if (_image.path == '') {
        ApiService()
            .updateProfile(
                imageURL: '',
                fullname: nameController.text,
                phone: phoneNumController.text,
                bankName: bankNameController.text,
                accountNumber: accountNumController.text,
            accountName: accountNameController.text,
                isAuthEnabled: appController.user.value.isAuthEnabled)
            .then((value) async {
          if (value == 'OK') {
            await ApiService().getLoggedInUser().then((value) {
              Get.back();
              UtilService().showToast('Successfully Updated!', color: Color(0xFF00D339));
            });

          }
        });
      } else {
        await UploadMediaService().uploadMediaFile(context, 'profilePics', _image, 'image').then((value) {
          appController.user.value.image = value;
          ApiService()
              .updateProfile(
                  imageURL: value,
                  fullname: nameController.text,
                  phone: phoneNumController.text,
                  bankName: bankNameController.text,
                  accountNumber: accountNumController.text,
                  accountName: accountNameController.text,
                  isAuthEnabled: appController.user.value.isAuthEnabled)
              .then((value) async {
            if (value == 'OK') {
              await ApiService().getLoggedInUser().then((value) {
                Get.back();
                UtilService().showToast('Successfully Updated!', color: Color(0xFF00D339));
              });
            }
          });
        });
      }
    }
  }
}
