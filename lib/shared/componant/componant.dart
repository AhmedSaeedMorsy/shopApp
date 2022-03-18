// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, dead_code

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/constant.dart';

void navigatorPushAndReblace(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
    (Route<dynamic> route) => false);

Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType textInputType,
        required String labelText,
        required Icon prefixIcon,
        IconButton? suffixIcon,
        bool obscure = false,
        void Function(String)? onFieldSubmeitted,
        void Function(String)? onChange,
        String? Function(String?)? validator}) =>
    TextFormField(
      onFieldSubmitted: onFieldSubmeitted,
      obscureText: obscure,
      validator: validator,
      controller: controller,
      onChanged: onChange,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        label: Text("${labelText}"),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );

Widget defaultButton(
        {required String text, required void Function()? function}) =>
    Container(
      width: double.infinity,
      child: TextButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );

navigatTo(context, Widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget),
  );
}

void showToast({
  required String message,
  required toast state
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum toast{
  success,warning,error
}

Color choseColor(toast state){
  switch(state){
    case toast.success : return Colors.green;
    break;
    case toast.error : return Colors.red;
    break;
    case toast.warning : return Colors.amber;
    break;  
  }
}

////Sign Out
/*
defaultButton(
        text: 'Log Out',
        function: () {
          navigatorPushAndReblace(context, LoginScreen());
          CacheHelper.removeData(key: 'token');
        };*/