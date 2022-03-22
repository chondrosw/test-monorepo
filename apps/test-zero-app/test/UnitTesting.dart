import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_zero_app/Model/User/UserRegister.dart';
import 'package:test_zero_app/Utils/Service/UserService.dart';
import 'package:test_zero_app/Utils/Service/UserServiceTesting.dart';


class MockFirestore extends Mock implements FirebaseFirestore{}
class MockCollectionReference extends Mock implements CollectionReference{}
class MockDocumentReference extends Mock implements DocumentReference{}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot{}
void main()async{
  await WidgetsFlutterBinding.ensureInitialized();
  test('Register Service',()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userService = UserServiceTesting();
     await userService.addInstance(username: "Chondro");
    var a = sharedPreferences.get("username");
    expect(a,"Chondro" );
  });
}
