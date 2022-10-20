import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  String number = '';
  String smsCode = '';

  bool isFail = false;
  String exceptionNumber = '';
  bool isFailSms = false;
  String exceptionSms = '';

  void setExceptionSms(bool bo, String except) {
    isFailSms = bo;
    exceptionSms = except;
    notifyListeners();
  }

  void setExceptionPhone(bool bo, String excepttion1) {
    isFail = bo;
    exceptionNumber = excepttion1;
    notifyListeners();
  }

  void setNumber(String num) {
    number = num;
  }

  void setSmsCode(String sms) {
    smsCode = sms;
  }
}
