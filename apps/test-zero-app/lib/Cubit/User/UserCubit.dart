import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';
import 'package:test_zero_app/Model/User/UserRegister.dart';
import 'package:test_zero_app/Utils/Service/UserService.dart';
part  'UserState.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(UserInitial());

  void signUp({required String email,required String password,required String username})async{
    try{
      emit(UserLoading());

      UserModel data = await UserService().add(email: email, password: password, username: username);
      Future.delayed(Duration(seconds: 2)).then((value) => {
      emit(UserSuccessRegister(user: data))
      });

    }catch(e){
      emit(UserFailed(error: "Failed to Register"));
    }
  }

  void signIn({required String username,required String password})async{
    try{
      emit(UserLoading());
      var data =  await UserService().find(username: username, password: password);
      print(data);
      if(data != null){
        Future.delayed(Duration(seconds: 2)).then((value) => {
          emit(UserSuccessLogin(user: data))
        });
      }else{
        emit(UserFailed(error: "Login Error"));
      }

    }catch(e){
      emit(UserFailed(error: "Login Error"));
    }
  }

}
