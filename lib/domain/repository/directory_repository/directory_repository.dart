import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/business_directory/ads/business_directory_ads_model.dart';
import 'package:rotary/data/models/business_directory/business_directory.dart';

abstract class DirectoryRepository {
  Future<Either<Failure, List<BusinessDirectory>>> getDirectory();
  Future<Either<Failure, List<String>>> getDistricts();
  Future<Either<Failure, List<BusinessAdsModel>>> getAds();
}
