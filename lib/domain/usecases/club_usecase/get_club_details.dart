import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_response_model.dart';
import 'package:rotary/data/models/club/club_details_model/club_details_request_model.dart';
import 'package:rotary/domain/repository/club_repository/club_repository.dart';

abstract class GetClubDetailsUseCase
    implements
        UseCases<Either<Failure, ClubDetailsResponseModel>,
            ClubDetailsRequestModel> {}

class GetClubDetailsUseCaseImpl implements GetClubDetailsUseCase {
  ClubRepository clubRepository;
  GetClubDetailsUseCaseImpl({required this.clubRepository});
  @override
  Future<Either<Failure, ClubDetailsResponseModel>> call(
      ClubDetailsRequestModel clubDetailsRequestModel) async {
    return clubRepository.getClubDetails(clubDetailsRequestModel);
  }
}
