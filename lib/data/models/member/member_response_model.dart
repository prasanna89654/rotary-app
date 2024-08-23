import 'package:rotary/data/models/member/member_model.dart';

class MemberResponseModel {
  dynamic totalCount;
  List<MemberModel> members;
  int currentPage;
  int lastPage;

  MemberResponseModel(
      {required this.totalCount,
      required this.members,
      required this.currentPage,
      required this.lastPage});
  factory MemberResponseModel.fromJson(Map<String, dynamic> json) =>
      MemberResponseModel(
        totalCount: json['total_count'],
        members: json['members'] == null
            ? []
            : List<dynamic>.from(json['members'])
                .map((memberModel) => MemberModel.fromJson(memberModel))
                .toList(),
        currentPage: json['current_page'] == null ? null : json['current_page'],
        lastPage: json['last_page'] as int,
      );

  isLastPage() {
    if (this.currentPage == this.lastPage) {
      print('last page');
      return true;
    } else {
      return false;
    }
  }
}
