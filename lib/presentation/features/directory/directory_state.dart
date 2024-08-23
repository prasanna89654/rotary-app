part of 'directory_cubit.dart';

abstract class DirectoryState extends Equatable {
  const DirectoryState();

  @override
  List<Object> get props => [];
}

class DirectoryInitial extends DirectoryState {}

class DirectoryLoaded extends DirectoryState {
  final List<BusinessDirectory> businessDirectory;
  final List<BusinessAdsModel> directoryAds;

  DirectoryLoaded(this.businessDirectory, this.directoryAds);
}

class DirectoryError extends DirectoryState {
  final String errorMessage;

  DirectoryError(this.errorMessage);
}
class DirectoryAdsError extends DirectoryState {
  final String errorMessage;

  DirectoryAdsError(this.errorMessage);
}
