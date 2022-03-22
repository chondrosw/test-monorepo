import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_zero_app/Model/User/UserRegister.dart';
import 'package:uuid/uuid.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  Future<UserModel> add(
      {required String email,
      required String password,
      required String username}) async {
    try {

      var v1 = Uuid().v4();

      UserModel data =
          UserModel(id:v1, password: password, username: username, email: email);
      users.doc("$username").set(data.toJson());

      return data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }


  Future<UserModel?> find(
      {required String username, required String password}) async {
    List<UserModel?> data = [];

    var a = users.doc(username).withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson());
    var dataModel = a.get().then((value) => value.data());

    // users.get().then((value) => {
    //
    //      value.docs.forEach((element) {
    //        if(element['username'] == username){
    //          data.add(UserModel(element['id'],
    //              password: element['password'],
    //              username: element['username'],
    //              email: element['email']));
    //      }
    //      })
    //   ,print(value.docs)
    //    });
    String passwordData = await dataModel.then((value) => value!.password);
    if(passwordData == password){
      return dataModel;
    }else{
      throw "Error Miss Password";
    }


  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await users.doc(id).get();
      return UserModel(id:snapshot['id'],
          password: snapshot['password'],
          username: snapshot['username'],
          email: snapshot['email']);
    } catch (e) {
      rethrow;
    }
  }
}
