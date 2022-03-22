import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zero_app/Cubit/User/UserCubit.dart';
import 'package:test_zero_app/View/Page/LoginPageView.dart';
import 'package:test_zero_app/View/Widget/ButtonPrimaryWidget.dart';

import '../../Utils/Style/Style.dart';
import '../Widget/TextFieldWidget.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  _RegisterPageViewState createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget registerButton() {
      return BlocConsumer<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          width: size.width,
          child: ButtonPrimaryWidget(
              primaryColor: primaryColor,
              title: "Sign Up",
              onPressed: () async{
                print(state);
                if (_formKey.currentState!.validate()) {

                   context.read<UserCubit>().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      username: usernameController.text);
                }
              }),
        );
      }, listener: (context, state) {
        if (state is UserSuccessRegister) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPageView()));
        } else if (state is UserFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    "Sign Up.",
                    style: LargeTitle.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              width: size.width,
              height: size.height * 0.875,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Image.asset(
                      "Asset/image-on-page.png",
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                    ),
                    TextFieldWidget(
                      controller: usernameController,
                      title: "Username",
                      obsecureText: false,
                      placeHolder: "username",
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please you need 7 or more character to create Username";
                        } else if (value.length < 7) {
                          return "Please input field";
                        }
                      },
                      isPassword: false,
                      onChangeSecure: () {},
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFieldWidget(
                      controller: emailController,
                      title: "Email",
                      obsecureText: false,
                      placeHolder: "email",
                      validator: (value) {
                        if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return null;
                        } else if (value == "" || value == null) {
                          return "Please input field";
                        } else {
                          return "Email must contain @";
                        }
                      },
                      isPassword: false,
                      onChangeSecure: () {},
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFieldWidget(
                      controller: passwordController,
                      title: "Password",
                      obsecureText: passwordVisibility,
                      placeHolder: "password",
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please you need 7 or more character to create password";
                        } else if (value.length < 7) {
                          return "Please input field";
                        }
                      },
                      isPassword: true,
                      onChangeSecure: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    registerButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Don't have account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPageView()));
                            },
                            child: Text(
                              "Sign Up",
                              style: h5Title.copyWith(fontSize: 12),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
