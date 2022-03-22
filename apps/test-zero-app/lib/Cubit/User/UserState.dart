part of 'UserCubit.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserInitial extends UserState{}
class UserLoading extends UserState{}
class UserSuccessRegister extends UserState{
  final UserModel user;
  UserSuccessRegister({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
class UserSuccessLogin extends UserState{
  final UserModel user;
  UserSuccessLogin({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
class UserSuccessGetData extends UserState{}
class UserFailed extends UserState{
  final String error;
  UserFailed({required this.error});
}
