import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/utils/com_fun.dart';
import 'package:rotary/data/models/business_directory/ads/business_directory_ads_model.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';
import 'package:rotary/data/models/business_directory/user.dart';
import 'package:rotary/domain/repository/directory_repository/directory_repository.dart';

part 'directory_state.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  DirectoryCubit(this.directoryRepository) : super(DirectoryInitial()) {
    // getDistricts();
  }
  final DirectoryRepository directoryRepository;
  List<BusinessDirectory> directories = [];
  List<BusinessAdsModel> directoryAds = [];
  TextEditingController searchDirectoryController = TextEditingController();
  List<String> districts = [];
  List<BusinessAdsModel> homeTopAds = [];
  BusinessAdsModel? homeTopBannerAds;
  BusinessAdsModel? directoryDetailTopAd;
  BusinessAdsModel? directoryDetailBottomAd;
  BusinessAdsModel? bussinessDetailTopAd;
  List<BusinessAdsModel> homeBottomAds = [];
  List<BusinessAdsModel> directoryDetailMiddleAds = [];
  Set<String> districtsNew = {};
  List<User>? directoryDetailUser;

  getDirectoryData() async {
    emit(DirectoryInitial());
    searchDirectoryController.text = "";
    final resultDirectory = await directoryRepository.getDirectory();
    final resultAds = await getAds();
    resultDirectory.fold((l) => emit(DirectoryError(l.failureMessage)), (r) {
      r.removeWhere(
        (element) => element.users?.length == 0,
      );
      r.sort((a, b) => a.name!.compareTo(b.name!));
      directories = r;
    });
    resultAds.fold(((l) => DirectoryAdsError(l.failureMessage)), (r) {
      directoryAds = r;
      homeTopAds = getHomePageTopAds();
      homeTopBannerAds = getHomeTopBannerAd();
      homeBottomAds = getHomeBottomAds();
      directoryDetailTopAd = getDirectoryDetailTopAd();
      directoryDetailBottomAd = getDirectoryDetailBottomAd();
      directoryDetailMiddleAds = getDirectoryDetailMiddleAds();
      bussinessDetailTopAd = getBusinessDetailTopAd();
      getUniqueDistricts();
      emit(DirectoryLoaded(directories, directoryAds));
    });
  }

  searchDirectory(String searchText) {
    emit(DirectoryInitial());
    List<BusinessDirectory> tempDirectories = [];
    directories.forEach((directory) {
      if (directory.name!.toLowerCase().contains(searchText.toLowerCase())) {
        tempDirectories.add(directory);
      }
    });

    if (tempDirectories.isEmpty) {
      emit(DirectoryError("No directory found"));
    } else {
      emit(DirectoryLoaded(tempDirectories, directoryAds));
    }
  }

  getDistricts() async {
    final result = await directoryRepository.getDistricts();
    result.fold(
      (l) => districts = [],
      (r) => districts = r,
    );
  }

  getUniqueDistricts() {
    for (BusinessDirectory directory in directories) {
      if (directory.users != null && directory.users!.isNotEmpty) {
        for (User user in directory.users!) {
          if (user.userDetails != null) {
            if (user.userDetails!.buisnessDistrict != null &&
                user.userDetails!.buisnessDistrict != "0") {
              districtsNew.add(user.userDetails!.buisnessDistrict!);
            }
          }
        }
      }
    }
  }

  filterByDistricts(String classification, String districts) {
    List<User> users = [];
    final c = directories.firstWhere(
      (element) => element.name == classification,
    );
    final filteredUsers = c.users
        ?.where((element) => element.userDetails?.buisnessDistrict == districts)
        .toList();
    if (filteredUsers != null) {
      users = filteredUsers;
    }
    return users;
  }

  Future<Either<Failure, List<BusinessAdsModel>>> getAds() async {
    final result = await directoryRepository.getAds();
    return result;
  }

  List<BusinessAdsModel> getHomePageTopAds() {
    List<BusinessAdsModel> topAds = [];
    final topActiveAd = getActiveAdsToShow('home-page', 'top');
    if (topActiveAd != null) {
      topAds.add(topActiveAd);
    }
    final bottomActiveAd = getActiveAdsToShow('home-page', 'bottom');
    if (bottomActiveAd != null) {
      topAds.add(bottomActiveAd);
    }
    final middleActiveAd = getActiveAdsToShow('home-page', 'middle');
    if (middleActiveAd != null) {
      topAds.add(middleActiveAd);
    }
    return topAds;
  }

  BusinessAdsModel? getHomeTopBannerAd() {
    return getActiveAdsToShow('home-page', 'top_banner');
  }

  List<BusinessAdsModel> getHomeBottomAds() {
    final homePageAds = directoryAds
        .where((element) =>
            element.page == 'home-page' &&
            (element.location == 'right' || element.location == 'card'))
        .toList();
    if (homePageAds.isNotEmpty) {
      final now = DateTime.now();

      final activeAds = homePageAds.where((element) {
        DateTime activeFrom = DateTime.parse(element.activeFrom ?? "");
        DateTime expireAt = DateTime.parse(element.expireAt ?? "");
        final isActiveAdToShow = isTimeInRange(now, activeFrom, expireAt);
        return isActiveAdToShow;
      }).toList();
      if (activeAds.isNotEmpty) {
        return activeAds;
      }
    }
    return [];
  }

  BusinessAdsModel? getDirectoryDetailTopAd() {
    return getActiveAdsToShow('search-page', 'top');
  }

  BusinessAdsModel? getDirectoryDetailBottomAd() {
    return getActiveAdsToShow('search-page', 'middle');
  }

  List<BusinessAdsModel> getDirectoryDetailMiddleAds() {
    final searchPageAds = directoryAds
        .where((element) =>
            element.page == 'search-page' && (element.location == 'left'))
        .toList();
    if (searchPageAds.isNotEmpty) {
      final now = DateTime.now();

      final activeAds = searchPageAds.where((element) {
        DateTime activeFrom = DateTime.parse(element.activeFrom ?? "");
        DateTime expireAt = DateTime.parse(element.expireAt ?? "");
        final isActiveAdToShow = isTimeInRange(now, activeFrom, expireAt);
        return isActiveAdToShow;
      }).toList();
      if (activeAds.isNotEmpty) {
        return activeAds;
      }
    }
    return [];
  }

  BusinessAdsModel? getBusinessDetailTopAd() {
    return getActiveAdsToShow('detail-page', 'top');
  }

  BusinessAdsModel? getActiveAdsToShow(String page, String location) {
    final homePageAds = directoryAds
        .where(
            (element) => element.page == page && element.location == location)
        .toList();
    if (homePageAds.isNotEmpty) {
      final now = DateTime.now();

      final activeAds = homePageAds.where((element) {
        DateTime activeFrom = DateTime.parse(element.activeFrom ?? "");
        DateTime expireAt = DateTime.parse(element.expireAt ?? "");
        final isActiveAdToShow = isTimeInRange(now, activeFrom, expireAt);
        return isActiveAdToShow;
      }).toList();
      if (activeAds.isNotEmpty) {
        return activeAds[0];
      }
    }
    return null;
  }
}


// CarouselSlider(
//                 items: List.generate(
//                   3,
//                   (index) => Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(.85),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Image.asset('assets/images/sherpafull.png')),
//                   ),
//                 ),
//                 options: CarouselOptions(
//                   height: 110,
//                   viewportFraction: .9,
//                   pageSnapping: true,
//                   autoPlay: true,
//                   reverse: false,
//                   autoPlayInterval: const Duration(seconds: 5),
//                   autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                 )),