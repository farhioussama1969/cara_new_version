import 'package:firebase_auth/firebase_auth.dart';

class FirebasePhoneAuthService {
  var firebaseAuth = FirebaseAuth.instance;
  static String? userID;
  static String? verificationId;
  static const int maxTimes = 5;
  static int timesCpt = 0;

  Future<void> sendOtpToPhone({required String phone, required Function onSuccess, required Function onError}) async {
    await firebaseAuth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phone,
        verificationCompleted: (AuthCredential authCredential) {
          if (firebaseAuth.currentUser != null) {}
        },
        verificationFailed: (authException) {
          print('verificationFailed Exception$authException');
          onError();
        },
        codeSent: (String id, int? forceResent) {
          timesCpt++;
          verificationId = id;
          onSuccess();
        },
        codeAutoRetrievalTimeout: (String id) {});
  }

  Future<void> otpVerification(
      {required String otp, required Function(User user) onSuccess, required Function onError}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: otp));
      if (userCredential.user != null) {
        userID = firebaseAuth.currentUser?.uid;
        onSuccess(firebaseAuth.currentUser!);
      }
    } on Exception catch (e) {
      onError();
    }
  }
}
