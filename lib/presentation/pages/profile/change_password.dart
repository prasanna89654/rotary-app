import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/resources/app_strings.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/presentation/features/sign_in_bloc/sign_in_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text('Privacy'),
      ),
      body: BlocListener<SignInBloc, SignInState>(
        bloc: BlocProvider.of<SignInBloc>(context),
        listener: (context, state) {
          // log('state: $state');

          if (state is ChangePasswordSuccess) {
            Navigator.pop(context);
            _currentPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            Fluttertoast.showToast(msg: state.message);
          }
          // if(state is SignInError) {
          //   Navigator.pop(context);
          //   Fluttertoast.showToast(msg: state.error);
          // }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text('Current Password', style: AppStyles.kBB14),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _currentPasswordController,
                // obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  // labelText: 'Current password',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('New Password', style: AppStyles.kBB14),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _newPasswordController,
                // obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Confirm Password', style: AppStyles.kBB14),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _confirmPasswordController,
                // obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  // labelText: 'Confirm password',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPasswordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please enter current password",
                      );
                    }
                    if (_newPasswordController.text.length < 5) {
                      Fluttertoast.showToast(
                          msg: "Password must be at least 5 characters long");
                    }
                    if (_newPasswordController.text !=
                        _confirmPasswordController.text) {
                      Fluttertoast.showToast(msg: "Passwords do not match");
                    }
                    if (_currentPasswordController.text.isNotEmpty &&
                        _newPasswordController.text.length >= 5 &&
                        _newPasswordController.text ==
                            _confirmPasswordController.text) {
                      // Fluttertoast.showToast(msg: "Password changed successfully");
                      BlocProvider.of<SignInBloc>(context).add(
                          ChangePasswordEvent(
                              currentPassword:
                                  _currentPasswordController.text.trim(),
                              newPassword: _newPasswordController.text.trim()));
                    }
                  },
                  child: Text('Update'.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
