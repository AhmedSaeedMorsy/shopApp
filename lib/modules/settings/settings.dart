// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/componant/componant.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';

import 'package:shopapp/shared/network/local/shared_pref.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (state, context) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).profileModel;
        var formKey = GlobalKey<FormState>();
        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is UpdateProfileDataLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10.0,),
                    defaultTextFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      labelText: "Name",
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      validator: (value) {
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
                      labelText: "Email",
                      prefixIcon: const Icon(
                        Icons.alternate_email,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Email";
                        }
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Phone";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      text: "Edit",
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateProfileData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  
                    defaultButton(
                      text: "Log Out",
                      function: () {
                        logOut(context);
                      },
                    ),
                    
                    ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void logOut(context) {
    CacheHelper.removeData(key: "token").then((value) {
      if (value) {
        navigatorPushAndReblace(context, LoginScreen());
      }
    });
  }
}
