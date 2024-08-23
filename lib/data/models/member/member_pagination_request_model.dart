class MemberPaginationRequestModel {
  MemberPaginationRequestModel({
    required this.page,
    required this.isLastPage,
  });

  dynamic page;
  bool isLastPage;
}
