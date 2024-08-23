import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/core/utils/dialog_util.dart';
import 'package:rotary/data/models/profile/update_profile_request_model.dart';

import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_styles.dart';
import '../../../data/models/login/user.dart';
import '../../features/profile_bloc/profile_bloc.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  User user = User();
  List<String> classifications = [];
  String image = "";
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(GetProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text("Profile Settings"),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            DialogUtils.showLoaderDialog(context, disableForceClose: false);
          }
          if (state is ProfileLoaded) {
            Navigator.pop(context);
            setState(() {
              user = state.profileModel.user ?? User();
              _firstNameController.text = user.firstname ?? "";
              _middleNameController.text = user.middlename ?? "";
              _lastNameController.text = user.lastname ?? "";
              _emailController.text = user.email ?? "";
              _phoneController.text = user.phoneNo ?? "";
              _addressController.text = user.address ?? "";
              _cityController.text = user.city ?? "";
              classifications = state.profileModel.classifications ?? [];
              image = state.profileModel.image ?? "";
              print(user.firstname);
              print(_firstNameController.text);
            });
            print("Classification: " +
                state.profileModel.classifications.toString());
          }
          if (state is ProfileError) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.errorMessage);
          }
          if (state is ProfileUpdated) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "Profile Updated Successfully");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 50),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 4),
                                    blurRadius: 10,
                                    color: Colors.grey.withOpacity(0.4),
                                  )
                                ]),
                            child: image.startsWith("http")
                                ? CachedNetworkImage(
                                    imageUrl: image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : Image.file(
                                    File(image),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                DialogUtils.showImageSourceDialog(context,
                                    (path) {
                                  setState(() {
                                    // image = path.name;
                                    imageFile = path;
                                    image = imageFile!.path;
                                    print(path);
                                  });
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(2, 4),
                                      blurRadius: 10,
                                      color: Colors.grey.withOpacity(0.4),
                                    )
                                  ],
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  // color: Colors.white,
                                ),
                                // onPressed: () {
                                //   // _getImage();
                                // },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Text('First name', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
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
                        Text('Middle name', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _middleNameController,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter some text';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
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
                        Text('Last name', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // labelText: 'Confirm password',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Email', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            return emailValidator(value);
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // labelText: 'Confirm password',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Phone', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10) {
                              return "Phone number must be 10 digit";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // labelText: 'Confirm password',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Address', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // labelText: 'Confirm password',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('City', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _cityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            // labelText: 'Confirm password',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Classification', style: AppStyles.kBB14),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          // width: double.infinity,
                          child: DropdownButton(
                            // value: user.classification ?? "",
                            hint: user.classification == null
                                ? Text("Select classification")
                                : Text(user.classification!),
                            // alignment: Alignment.centerRight,
                            items: classifications.map((classification) {
                              return DropdownMenuItem(
                                value: classification,
                                child: Text(classification),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                user.classification = value as String;
                              });
                            },
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
                              if (_formKey.currentState!.validate()) {
                                // if(user.email == _)
                                UpdateProfileRequestModel
                                    updateProfileRequestModel =
                                    UpdateProfileRequestModel(
                                  firstname: _firstNameController.text,
                                  image: imageFile == null ? null : imageFile,
                                  phoneNo: _phoneController.text,
                                  middlename: _middleNameController.text,
                                  lastname: _lastNameController.text,
                                  email: _emailController.text,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  classification: user.classification ?? "",
                                );
                                // User _user = User(
                                //   firstname: _firstNameController.text,
                                //   middlename: _middleNameController.text,
                                //   lastname: _lastNameController.text,
                                //   email: _emailController.text,
                                //   phoneNo: _phoneController.text,
                                //   address: _addressController.text,
                                //   city: _cityController.text,
                                //   classification: user.classification,
                                //   // classification: _classificationController.text,
                                // );

                                /// TODO: update  profile pic of user
                                BlocProvider.of<ProfileBloc>(context).add(
                                  UpdateProfileData(updateProfileRequestModel),
                                );
                              }
                              // if (_currentPasswordController.text.isEmpty) {
                              //   Fluttertoast.showToast(
                              //     msg: "Please enter current password",
                              //   );
                              // }
                              // if (_newPasswordController.text.length < 5) {
                              //   Fluttertoast.showToast(
                              //       msg: "Password must be at least 5 characters long");
                              // }
                              // if (_newPasswordController.text !=
                              //     _confirmPasswordController.text) {
                              //   Fluttertoast.showToast(msg: "Passwords do not match");
                              // }
                              // if (_currentPasswordController.text.isNotEmpty &&
                              //     _newPasswordController.text.length >= 5 &&
                              //     _newPasswordController.text ==
                              //         _confirmPasswordController.text) {
                              //   // Fluttertoast.showToast(msg: "Password changed successfully");
                              //   BlocProvider.of<SignInBloc>(context).add(
                              //       ChangePasswordEvent(
                              //           currentPassword:
                              //               _currentPasswordController.text.trim(),
                              //           newPassword: _newPasswordController.text.trim()));
                              // }
                            },
                            child: Text('Update'.toUpperCase()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
