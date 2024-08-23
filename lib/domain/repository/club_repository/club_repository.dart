import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_response_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_request_model.dart';
import 'package:rotary/domain/entities/club/club.dart';

abstract class ClubRepository {
  Future<Either<Failure, Clubs>> getClubs();
  Future<Either<Failure, ClubDetailsResponseModel>> getClubDetails(
      ClubDetailsRequestModel clubDetailsRequestModel);
}
