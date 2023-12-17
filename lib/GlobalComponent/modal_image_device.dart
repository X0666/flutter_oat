import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shamo/pages/AdminPage/EditItem/EditItem.dart';
import 'package:shamo/theme.dart';

// ignore: must_be_immutable
class ModalImageDevice extends StatelessWidget {
  // final ModalController controls = Get.put(ModalController());

  final Function(File image)? onPressed;
  final double ratioX;
  final double ratioY;

  ModalImageDevice(
      {Key? key, this.onPressed, required this.ratioX, required this.ratioY})
      : super(key: key);

  ImageHelper helper = ImageHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: VColor.white,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: backgroundColor1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(50.0),
                  // onTap: action(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black,
                    ),
                  )),
              Center(
                child: Padding(
                  child: Text(
                    'Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final files = await helper.pickImage();
                    Navigator.pop(context);
                    // if (files != null) {
                    //   final croppedFile = await helper.crop(
                    //       file: files, ratioX: ratioX, rationY: ratioY);
                    //   if (croppedFile != null) {
                    onPressed!(
                      File(files!.path),
                    );
                    //   }
                    // }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundColor2.withAlpha(100),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 30,
                          color: blackColor,
                        ),
                        SizedBox(width: 20),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // InkWell(
                //   onTap: () async {
                //     final files =
                //         await helper.pickImage(source: ImageSource.camera);
                //     Navigator.pop(context);
                //     if (files != null) {
                //       final croppedFile = await helper.crop(
                //           file: files, ratioX: ratioX, rationY: ratioY);
                //       if (croppedFile != null) {
                //         onPressed!(File(croppedFile.path));
                //       }
                //     }
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 10,
                //       horizontal: 16,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: backgroundColor2.withAlpha(100),
                //     ),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.camera_alt_rounded,
                //           size: 30,
                //           color: blackColor,
                //         ),
                //         SizedBox(width: 20),
                //         Text("Camera"),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
