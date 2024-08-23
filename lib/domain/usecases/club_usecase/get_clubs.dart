import 'package:dartz/dartz.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:rotary/core/use_cases.dart/use_cases.dart';
import 'package:rotary/domain/entities/club/club.dart';
import 'package:rotary/domain/repository/club_repository/club_repository.dart';

class GetClubsUseCase implements UseCases<Either<Failure, Clubs>, NoParams> {
  final ClubRepository clubRepository;

  GetClubsUseCase(this.clubRepository);
  @override
  Future<Either<Failure, Clubs>> call(NoParams noParams) async {
    return await clubRepository.getClubs();
  }
}
