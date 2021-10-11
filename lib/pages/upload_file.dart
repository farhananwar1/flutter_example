import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing_proj/models/image_upload.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadFile extends StatefulWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  /// Variables
  File? imageFile;
  String uploadUrl =
      "https://dev.quickfill4pointinspectionapp.com/api/v1/upload-file";
  static ImageUpload? imageUpload;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          // color: Colors.greenAccent,
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          // color: Colors.lightGreenAccent,
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: Text("PICK FROM CAMERA"),
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (imageFile != null) {
                              _uploadFile(imageFile!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No file attached")));
                            }
                          },
                          child: Text("Upload Pic"),
                        )
                      ],
                    ),
                  )));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print(imageFile.toString());
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print(imageFile.toString());
      });
    }
  }

  _uploadFile(File file) async {
    //Send Token or anything in header
    // Map<String, String> headers = {"Accesstoken": "access_token",HttpHeaders.authorizationHeader:"Basic your_api_token_here"};
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(uploadUrl));
    //add text fields
    // request.fields["text_field"] = text;
    //Add Header
    // request.headers.addAll(headers);
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    final decodeData = jsonDecode(responseString);
    print(decodeData);
    imageUpload = ImageUpload.fromJson(decodeData);
    print(imageUpload!.data!.path);

    if (mounted) {
      setState(() {});
    }

    if (imageUpload != null) {
      customDialog();
    }
  }

  void customDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            child: SizedBox.expand(
                child: Text(
              imageUpload!.data!.path.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  decoration: TextDecoration.none),
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('imageFile', imageFile));
  }
}
