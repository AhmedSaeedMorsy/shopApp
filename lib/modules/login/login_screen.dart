// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/modules/register/register_screen.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/login_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/login_cubit/states.dart';

import 'package:shopapp/shared/network/local/shared_pref.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          if (LoginCubit.get(context).loginModel.status) {
            CacheHelper.setData(
                    key: 'token',
                    value: LoginCubit.get(context).loginModel.data!.token)
                .then(
                    (value) => navigatorPushAndReblace(context, HomeLayOut()));
            token = LoginCubit.get(context).loginModel.data!.token;
          } else {
            showToast(
                message: LoginCubit.get(context).loginModel.message!,
                state: toast.error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Image(
                          width: 150.0,
                          height: 150.0,
                          image: AssetImage("assets/images/icon.png"),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: "Email Address",
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email Adress";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: "Password",
                          obscure: LoginCubit.get(context).isShown,
                          prefixIcon: const Icon(Icons.lock_outlined),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Password";
                            }
                          },
                          onFieldSubmeitted: (String? value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context)
                                  .changeVisibilityPassword();
                            },
                            icon: LoginCubit.get(context).suffix,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilderRec(
                          condition: state is! UserLoginLoadingState,
                          builder: (context) => defaultButton(
                              text: "Login",
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an Account ?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                              onPressed: () {
                                navigatTo(context, RegisterScreen());
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: mainColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
