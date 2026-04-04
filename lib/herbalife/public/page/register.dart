import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // ✅ Move everything out of build()
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addresssController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
      // ✅ SnackBar goes here, not in the widget tree
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Photo taken successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addresssController.dispose();
    phoneController.dispose();
    emailController.dispose();
    _image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Text(
            "Herbalife",
            style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryGreen),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/images/Herblogo.png", width: 300),
            const SizedBox(height: 20),
            LoginContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('Register', style: kTitleStyle.copyWith(fontSize: 35)),
                  ),
                  LoginTextField(controller: nameController, icon: Icons.person, hintText: "Enter your name"),
                  const SizedBox(height: 20),
                  LoginTextField(controller: addresssController, icon: Icons.home, hintText: "Enter your address"),
                  const SizedBox(height: 20),
                  LoginTextField(controller: phoneController, icon: Icons.phone, hintText: "Enter your phone number"),
                  const SizedBox(height: 20),
                  LoginTextField(controller: emailController, icon: Icons.email, hintText: "Enter your email"),
                  const SizedBox(height: 18),
                  LoginButton(
                    label: "Register",
                    isLoading: authProvider.isLoading,
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                      await authProvider.register(
                        nameController.text,
                        addresssController.text,
                        phoneController.text,
                        emailController.text,
                        _image!,
                      );
                      if (authProvider.message == "successfully") {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Success"),
                              content: const Text("Register successfully"),
                              actions: [
                                LoginButton(
                                  label: "Back to login",
                                  isLoading: false,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(authProvider.message!),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // ✅ Just the button here, no SnackBar in widget tree
                  LoginButton(
                    label: "Take Photo",
                    isLoading: false,
                    onPressed: _pickPhoto,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}