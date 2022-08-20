import 'dart:io';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Verfication_prov with ChangeNotifier{
  void sendOtp(String email) async {
    EmailAuth emailAuth =  new EmailAuth(sessionName: "negozio application");
    bool result = await emailAuth.sendOtp(

        recipientMail: email, otpLength: 6
    );
    if(result)
    {
      print("otp send");
    }
    else
    {
      print("invalid");
    }
  }

  Future<String> Verifyotp(String email,String code) async {
    EmailAuth emailAuth =  new EmailAuth(sessionName: "negozio application");

    bool result = await emailAuth.validateOtp(
        recipientMail: email, userOtp: code

    );
    if(result)
    {
      print(result);
      print("Validation success");
      return result.toString();
    }
    else
    {
      print("invalid");
      return result.toString();
    }
  }
}