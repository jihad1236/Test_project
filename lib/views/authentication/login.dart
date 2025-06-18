import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/auth/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 12),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Login Now',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    controller.emailController,
                    hint: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        (val) =>
                            !val!.contains('@') ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller.passwordController,
                    hint: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                    validator:
                        (val) =>
                            val!.length < 6
                                ? 'Password must be at least 6 characters'
                                : null,
                  ),
                  const SizedBox(height: 24),
                  Obx(() {
                    return controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E293B),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: controller.loginUser,
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl, {
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
