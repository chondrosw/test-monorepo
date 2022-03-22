import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  String id;
  String username;
  String email;
  String password;
  UserModel({required this.id,required this.password,required this.username,required this.email});

  factory UserModel.fromJson(Map<String,dynamic> json)=>
    UserModel(id:json['id'],username:json['username'],email:json['email'],password:json['password']);

  Map<String,dynamic> toJson()=>{
    'id':id,
    'username':username,
    'email':email,
    'password':password
  };
  @override
  // TODO: implement props
  List<Object?> get props => [id,username,email,password];
}
