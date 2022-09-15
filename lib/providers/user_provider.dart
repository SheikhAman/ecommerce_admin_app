import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/db_helper.dart';
import '../models/city_model.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  List<CityModel> cityList = [];

  getAllCities() {
    /*DbHelper.getAllCities().listen((event) {
      cityList = List.generate(event.docs.length, (index) =>
          CityModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });*/
  }

  List<String> getAreaByCity(String? city) {
    if(city == null) return <String>[];
    final cityM = cityList.firstWhere((element) => element.name == city);
    return cityM.area;
  }

  /*Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUid(String uid) =>
      DbHelper.getUserByUid(uid);*/

  /*Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DbHelper.updateProfile(uid, map);*/

  Future<String> updateImage(XFile xFile) async {
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRef = FirebaseStorage.instance.ref().child('Pictures/$imageName');
    final uploadTask = photoRef.putFile(File(xFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}