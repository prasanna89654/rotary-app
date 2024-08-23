import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary/core/injection/injection_container.dart';
import 'package:rotary/core/resources/app_styles.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/presentation/features/sign_in_bloc/sign_in_bloc.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/utils/dialog_util.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  SignInBloc _signInBloc = SignInBloc(di(), di(), di(), di());
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: BlocProvider(
        create: (context) => _signInBloc,
        child: BlocListener<SignInBloc, SignInState>(
          bloc: _signInBloc,
          listener: (context, state) async {
            if (state is SignInLoading) {
              DialogUtils.showLoaderDialog(context, disableForceClose: false);
            }
            if (state is SignInError) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: state.error.toString());
            }
            if (state is SignInSuccess) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Email Sent'),
                      content: Text(
                          'Email sent to ${_emailController.text}, kindly check your email to reset your password'),
                      actions: [
                        ElevatedButton(
                          child: Text('Back to login'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: AppStyles.kBB14,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _emailController,
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
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    String? isvalid = emailValidator(_emailController.text);
                    if (isvalid == null) {
                      _signInBloc.add(
                        ForgotPasswordEvent(
                          _emailController.text,
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Please enter valid email");
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
