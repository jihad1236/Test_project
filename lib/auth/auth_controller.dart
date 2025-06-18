import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/model/user_model.dart';
import 'package:test_project/views/authentication/login.dart';
import 'package:test_project/views/authentication/register.dart';
import 'package:test_project/views/homepage/home.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController =
      TextEditingController(); // Used only during registration
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static String? _currentUserUid;
  static String? get currentUserUid => _currentUserUid;

  final isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Register new user
  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      // 🔐 Firebase Auth - Create user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      // 🧾 Create a UserModel instance
      final userModel = UserModel(
        id: uid,
        name: usernameController.text.trim(),
        email: emailController.text.trim(),
        posts: [],
      );

      // ⬆ Save UserModel to Firestore
      await _firestore.collection('users').doc(uid).set(userModel.toMap());

      Get.snackbar('Success', 'Registration completed');
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Auth Error', e.message ?? 'Unknown error occurred');
    } catch (e) {
      Get.snackbar('Error', 'Registration failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Login existing user
  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;
      final userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        Get.snackbar('Welcome', 'Logged in as ${userData?['username']}');
        Get.to(Home());
      } else {
        Get.snackbar('Notice', 'User data not found in Firestore');
      }

      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', e.message ?? 'Invalid email or password');
    } catch (e) {
      Get.snackbar('Error', 'Unexpected error: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> logoutUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('Logout', 'No user is currently logged in.');
        return;
      }

      await FirebaseAuth.instance.signOut();
      Get.snackbar('Success', 'You have been logged out.');
      Get.to(RegisterPage()); // or use Get.offAll(LoginPage());
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: $e');
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
