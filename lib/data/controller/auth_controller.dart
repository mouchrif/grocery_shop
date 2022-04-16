import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/connectivity_controller.dart';
import 'package:grocery_shop/data/service/firebase_services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:grocery_shop/model/user_model.dart';
import 'package:grocery_shop/view/screens/connectivity_screen.dart';
import 'package:grocery_shop/view/screens/my_home_screen.dart';
import 'package:grocery_shop/view/screens/sign_in_screen.dart';

class AuthController extends GetxController {
  final FirebaseServices fbServices = FirebaseServices();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final List<Map<String, dynamic>> _icons = [
    {"icon": FontAwesomeIcons.apple, "color": Colors.black},
    {"icon": "assets/images/logo-google.png", "color": kGoogleColor},
    {"icon": FontAwesomeIcons.twitter, "color": kTwitterColor},
    {"icon": FontAwesomeIcons.facebookF, "color": kFacebookColor},
  ];
  List<Map<String, dynamic>> getIcons() => _icons;

  final GlobalKey<FormState> formSignInKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formProfileUpdateInfos = GlobalKey<FormState>();
  final GlobalKey<FormState> formReauthenticationKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formChangePassword = GlobalKey<FormState>();
  // late TextEditingController emailCtroller, passwordController;
  String? email, password, name, newPassword, confirmPassword;
  String? profileEmail, profileName;

  final _enabledName = false.obs;
  bool getEnabledName() => _enabledName.value;
  void setEnabledName(bool status) => _enabledName.value = status;

  final _enabledEmail = false.obs;
  bool getEnabledEmail() => _enabledEmail.value;
  void setEnabledEmail(bool status) => _enabledEmail.value = status;

  final _passwordVisibility = true.obs;
  bool getPassVisibility() => _passwordVisibility.value;
  void setPassVisibility(bool status) => _passwordVisibility.value = status;

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final _user = UserModel(userId: "", name: "", email: "").obs;
  UserModel getUser() => _user.value;
  void setUser(UserModel user) => _user.value = user;

  Future<UserModel> getUserFromFireStore() async {
    Map<String, dynamic> userMap =
        await fbServices.getUserFromFirestore();
    return UserModel.fromJson(userMap);
  }

  final _isLoading = true.obs;
  bool getIsLoading() => _isLoading.value;
  void setIsLoading(bool status) => _isLoading.value = status;

  Future<void> googleSignInMethod(BuildContext context) async {
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await _googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await fbServices.fbAuth
            .signInWithCredential(credential)
            .then((user) async {
          await saveUserToFirebase(user);
          getUserFromFirestore(user.user!.uid);
          snackbarBuilder(
            "Welcome " + getUser().name!,
            "you are signing successfuly.",
          );
          Get.offAll(
            () => MyHomeScreen(user: user.user!),
            transition: Transition.fade,
          );
        });
      } else {
        defaultDialogBuilder("google user is null...");
      }
    } catch (err) {
      final cnxCtrlr = Get.find<ConnectivityManager>();
      if (cnxCtrlr.isDeviceConnected) {
        defaultDialogBuilder("Something went wrong, please try later");
      } else {
        Get.offAll(
          () => const ConnectivityScreen(),
          transition: Transition.fade,
        );
      }
    }
  }

  Future<void> facebookSignInMethod() async {
    try {
      LoginResult resultLogin = await _facebookAuth.login(permissions: [
        'email',
      ]);
      if (resultLogin.status == LoginStatus.success) {
        AccessToken accessToken = resultLogin.accessToken!;
        AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        await fbServices.fbAuth
            .signInWithCredential(credential)
            .then((value) => Get.offAll(
                  () => MyHomeScreen(user: value.user!),
                  transition: Transition.fade,
                ));
      } else {
        defaultDialogBuilder(resultLogin.message!);
      }
    } catch (err) {
      defaultDialogBuilder(err.toString());
    }
  }

  Future<void> createUserWithEmailAndPasswordMethod(
      BuildContext context) async {
    try {
      await fbServices.fbAuth
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((user) async {
        await saveUserToFirebase(user);
        getUserFromFirestore(user.user!.uid);
        snackbarBuilder(
          "Welcome " + (user.user!.displayName ?? getUser().name ?? ""),
          "your account has been created successfuly.",
        );
        Get.offAll(
          () => MyHomeScreen(),
          transition: Transition.fade,
        );
      });
    } on FirebaseAuthException catch (err) {
      if (err.code == "weak-password") {
        defaultDialogBuilder("The password provided is too weak.");
      } else if (err.code == "email-already-in-use") {
        defaultDialogBuilder("The account already exists for that email.");
      }
    } catch (error) {
      defaultDialogBuilder(error.toString());
    }
  }

  Future<void> signInWithEmailAndPasswordMethod(
      BuildContext context, String email, String password) async {
    try {
      await fbServices.fbAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) {
        getUserFromFirestore(userCredential.user!.uid);
        snackbarBuilder(
          "Welcome back " +
              (userCredential.user!.displayName ?? getUser().name ?? ""),
          " We are happy to see you again.",
        );
        Get.offAll(
          () => MyHomeScreen(),
          transition: Transition.fade,
        );
      });
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        defaultDialogBuilder("Enter a valid email adress");
      } else if (err.code == "user-disabled") {
        defaultDialogBuilder("user is disabled from admin panel");
      } else if (err.code == "wrong-password") {
        defaultDialogBuilder("your password is not correct or invalid");
      } else {
        defaultDialogBuilder("user is not found");
      }
    }
  }

  void socialAuthIcons(int index, BuildContext context) async {
    switch (index) {
      case 0:
        print('index == apple');
        break;
      case 1:
        print('index == google');
        await googleSignInMethod(context);
        break;
      case 2:
        print('index == twitter');
        break;
      case 3:
        print('index == facebook');
        await facebookSignInMethod();
        break;
      default:
        print("nothing");
    }
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your full name";
    }
    if (GetUtils.isLengthLessThan(value, 4)) {
      return "Please enter valid name";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid email adress";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "password must have at least 6 characters";
    }
    return null;
  }

  Future<void> checkRegisteration(BuildContext context) async {
    final isValid = formSignUpKey.currentState!.validate();
    if (isValid) {
      formSignUpKey.currentState!.save();
      await createUserWithEmailAndPasswordMethod(context);
    }
  }

  Future<void> checkLogin(BuildContext context) async {
    final isValid = formSignInKey.currentState!.validate();
    if (isValid) {
      formSignInKey.currentState!.save();
      await signInWithEmailAndPasswordMethod(context, email!, password!);
    }
  }

  Future<void> checkProfileFields() async {
    final isValid = formProfileUpdateInfos.currentState!.validate();
    if (isValid) {
      formProfileUpdateInfos.currentState!.save();
      await resetEmail();
    }
  }

  Future<void> changePasswordMethod() async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: fbServices.fbAuth.currentUser!.email!, password: password!);
    fbServices.fbAuth.currentUser!
        .reauthenticateWithCredential(credential)
        .then((userCredential) =>
            userCredential.user!.updatePassword(newPassword!).then((value) {
              logout();
            }).catchError((err) {
              print(err.code);
            }))
        .catchError((err) {
      if (err.code == "user-not-found") {
        defaultDialogBuilder("User not found");
      }
      if (err.code == "wrong-password") {
        defaultDialogBuilder("Wrong password");
      }
      if (err.code == "invalid-email") {
        defaultDialogBuilder("Invalid email");
      }
    });
  }

  Future<void> checkPasswordConfirmation() async {
    if (newPassword!.contains(confirmPassword!)) {
      print("Password confirmed successfuly...");
      await changePasswordMethod();
    } else {
      defaultDialogBuilder("Your password is not confirm");
    }
  }

  Future<void> checkChangePassword() async {
    final bool isValid = formChangePassword.currentState!.validate();
    if (isValid) {
      formChangePassword.currentState!.save();
      await checkPasswordConfirmation();
    }
  }

  Future<void> saveUserToFirebase(UserCredential userCredential) async {
    final user = UserModel(
      userId: userCredential.user!.uid,
      name: name ?? userCredential.user!.displayName,
      email: userCredential.user!.email!,
    );
    await fbServices.addUserToFirebase(user);
  }

  void resetProfileFields() {
    profileEmail = "";
    profileName = "";
  }

  Future<void> upDateUserInfos() async {
    final userModel = UserModel(
      userId: fbServices.fbAuth.currentUser!.uid,
      name: profileName ?? getUser().name,
      email: profileEmail,
    );
    await fbServices
        .updateUser(userModel)
        .then((message) => snackbarBuilder(
              "Info :",
              message,
            ))
        .catchError((err) {
      defaultDialogBuilder(err.toString());
    });
  }

  Future<void> resetEmail() async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: fbServices.fbAuth.currentUser!.email!, password: password!);
    await fbServices.fbAuth.currentUser!
        .reauthenticateWithCredential(credential)
        .then((userCredential) async {
      if (getEnabledEmail()) {
        await userCredential.user!.updateEmail(profileEmail!).then((value) {
          upDateUserInfos();
          setEnabledEmail(false);
          logout();
        });
      }
      if (getEnabledName()) {
        await userCredential.user!.updateDisplayName(profileName).then((value) {
          upDateUserInfos();
          setEnabledName(false);
          getUserFromFirestore(userCredential.user!.uid);
        });
      }
    }).catchError((err) {
      Get.defaultDialog(
        content: Text(err.toString()),
        titleStyle: const TextStyle(
          color: kHeartColor,
        ),
      );
    });
  }

  Future<void> upDateUserName() async {
    final isValid = formProfileUpdateInfos.currentState!.validate();
    if (isValid) {
      formProfileUpdateInfos.currentState!.save();
      await upDateUserInfos();
    }
  }

  void resetFields() {
    name = null;
    email = null;
    password = null;
  }

  static Future defaultDialogBuilder(String content) {
    return Get.defaultDialog(
      content: Text(content),
      titleStyle: const TextStyle(color: kHeartColor),
    );
  }

  static SnackbarController snackbarBuilder(
    String title,
    String message,
  ) =>
      Get.snackbar("", "",
          duration: const Duration(milliseconds: 1350),
          titleText: Text(
            title,
            style: TextStyle(color: kWhiteColor, fontSize: 2*kSize10),
          ),
          messageText: Text(
            message,
            style: const TextStyle(
              color: kWhiteColor,
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          barBlur: 10);

  void getUserFromFirestore(String userId) {
    DocumentReference<Map<String, dynamic>> docRef =
        fbServices.usersRef.doc(userId);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var docMap = documentSnapshot.data()! as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(docMap);
        setUser(user);
      } else {
        setUser(UserModel(userId: "", name: "", email: ""));
      }
    });
  }

  Future<void> logout() async {
    await fbServices.fbAuth.signOut();
    Get.offAll(
      () => const SignInScreen(),
      transition: Transition.fade,
    );
  }

  @override
  void onInit() {
    super.onInit();
    print("reload");
    if (fbServices.fbAuth.currentUser != null) {
      fbServices.fbAuth.currentUser!.reload().then((value) {
        getUserFromFirestore(fbServices.fbAuth.currentUser!.uid);
      }).catchError((err) {
        Get.defaultDialog(content: Text(err.toString()));
      });
    } else {
      print("current user is null");
    }
    // profileEmailController = TextEditingController();

    // _user.bindStream(fbServices.fbAuth.authStateChanges());
    // emailCtroller = TextEditingController();
    // passwordController = TextEditingController();
  }

  @override
  void onClose() {
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    // emailCtroller.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
