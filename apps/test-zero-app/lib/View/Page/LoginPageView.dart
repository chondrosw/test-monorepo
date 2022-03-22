import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zero_app/Cubit/User/UserCubit.dart';
import 'package:test_zero_app/Utils/Service/UserService.dart';
import 'package:test_zero_app/Utils/Style/Style.dart';
import 'package:test_zero_app/View/Page/ProfilePageView.dart';
import 'package:test_zero_app/View/Page/RegisterPageView.dart';
import 'package:test_zero_app/View/Widget/ButtonPrimaryWidget.dart';
import 'package:test_zero_app/View/Widget/TextFieldWidget.dart';


class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget buttonLogin(){
      return BlocConsumer<UserCubit,UserState>(builder: (context,state){
        if(state is UserLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        return SizedBox(
            width: size.width,
            child: ButtonPrimaryWidget(
                primaryColor: primaryColor,
                title: "Login",
                onPressed: () {
                  if(usernameController.text == "" || passwordController.text == ""){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Input the field"),backgroundColor: Colors.red,));
                  }else{
                    context.read<UserCubit>().signIn(username: usernameController.text, password: passwordController.text);
                  }

                })
        );
      }, listener: (context,state){
        if(state is UserSuccessLogin){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePageView()));
        }else if(state is UserFailed){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error),backgroundColor: Colors.red,));
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: primaryColor,
              width: size.width,
              height: size.height,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log In.",
                    style: LargeTitle.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              width: size.width,
              height: size.height * 0.875,
              child: Column(
                children: [
                  Image.asset(
                    "Asset/image-on-page.png",
                    width: size.width * 0.675,
                    height: size.width * 0.675,
                  ),
                  TextFieldWidget(
                    controller: usernameController,
                    title: "Username",
                    obsecureText: false,
                    placeHolder: "username",
                    validator: (value) {},
                    isPassword: false,
                    onChangeSecure: (){},
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFieldWidget(
                    controller: passwordController,
                    title: "Password",
                    obsecureText: true,
                    placeHolder: "password",
                    validator: (value) {},
                    isPassword: false,
                    onChangeSecure: (){},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: isCheck,
                              onChanged: (value) {
                                setState(() {
                                  isCheck = value!;
                                });
                              }),
                          Text("Remember me?")
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: h5Title.copyWith(color: primaryColor),
                          ))
                    ],
                  ),
                  buttonLogin(),
                  Spacer(),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPageView()));
                          },
                          child: Text(
                            "Sign Up",
                            style: h5Title.copyWith(fontSize: 12),
                          ))
                    ],
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
