// ignore_for_file: must_be_immutable

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/login_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/login_cubit/states.dart';
import 'package:shopapp/shared/network/local/shared_pref.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is RigesterDataSuccessState) {
            if (LoginCubit.get(context).userData!.status) {
              CacheHelper.setData(
                      key: 'token',
                      value: LoginCubit.get(context).userData!.data!.token)
                  .then((value) =>
                      navigatorPushAndReblace(context, const HomeLayOut()));
              token = LoginCubit.get(context).userData!.data!.token;
            } else {
              showToast(
                  message: LoginCubit.get(context).userData!.message,
                  state: toast.error);
            }
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Image(
                        width: 120.0,
                        height: 120.0,
                        image: AssetImage("assets/images/icon.png"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Rigester",
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
                        controller: nameController,
                        textInputType: TextInputType.emailAddress,
                        labelText: "Name",
                        prefixIcon: const Icon(Icons.person),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                        },
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
                            LoginCubit.get(context).changeVisibilityPassword();
                          },
                          icon: LoginCubit.get(context).suffix,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                        labelText: "Phone",
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Phone Number";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilderRec(
                        condition: state is! UserLoginLoadingState,
                        builder: (context) => defaultButton(
                            text: "Rigester",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userRigester(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            }),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
