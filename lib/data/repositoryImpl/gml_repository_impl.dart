import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/data/data_sources/gml/gml_remote_data_sources.dart';
import 'package:rotary/data/models/gml/gml_model.dart';
import 'package:rotary/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rotary/domain/repository/gml_repository/gml_repository.dart';

class GmlRepositoryImpl implements GmlRepository {
  NetworkInfo networkInfo;
  GmlRemoteDataSource gmlRemoteDataSource;
  GmlRepositoryImpl(
      {required this.networkInfo, required this.gmlRemoteDataSource});
  @override
  Future<Either<Failure, List<GmlModel>>> getGml() async {
    // if (await networkInfo.isConnected) {
    try {
      final result = await gmlRemoteDataSource.getGml();
      return Right(result);
    } catch (e) {
      return Left(parseFailure(e));
    }
    // } else {
    //   return Future.value(Left(NetworkFailure()));
    // }
  }
}
