import 'package:image_picker/image_picker.dart';

class UpdateProfileRequestModel {
  String firstname;
  String middlename;
  String lastname;
  String email;
  String address;
  String city;
  XFile? image;
  String phoneNo;
  String classification;

  UpdateProfileRequestModel(
      {required this.classification,
      required this.firstname,
      this.image,
      required this.phoneNo,
      required this.middlename,
      required this.lastname,
      required this.email,
      required this.address,
      required this.city});
}
