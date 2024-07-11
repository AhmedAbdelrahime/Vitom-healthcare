import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:complex_ui_rive_animation/features/AUth/presntation/pages/home/checkups/body_checkup/widgets/svaed.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childname).child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> savedCheckupsData({
    required String disese1,
    required String disese2,
    required String disese3,
    required Uint8List file,
    required String name,
  }) async {
    String resp = 'SomeErro ';
    try {
      if (disese1.isEmpty ||
          disese2.isEmpty ||
          disese3.isEmpty ||
          file.isEmpty ||
          name.isEmpty) {
        throw Exception(
            'Please fill in all required fields'); // Handle empty fields
      }
      String imagUrl = await uploadImageToStorage('lungCheckupsImage', file);
      await _firestore.collection('lungCheckups').add({
        'dises1': disese1,
        'dises2': disese2,
        'dises3': disese3,
        'imagelink': imagUrl,
      });
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
