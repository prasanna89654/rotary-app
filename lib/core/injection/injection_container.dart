import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:rotary/core/network/network_info.dart';
import 'package:rotary/core/network/network_utils.dart';
import 'package:rotary/data/data_sources/calendar_remote_data_sources.dart';
import 'package:rotary/data/data_sources/club/club_remote_data_sources.dart';
import 'package:rotary/data/data_sources/directory/directory_remote_data_source.dart';
import 'package:rotary/data/data_sources/district_committee/district_committee_remote_data_sources.dart';
import 'package:rotary/data/data_sources/district_governor/district_governor_remote_data_sources.dart';
import 'package:rotary/data/data_sources/event/event_remote_data_sources.dart';
import 'package:rotary/data/data_sources/gml/gml_remote_data_sources.dart';
import 'package:rotary/data/data_sources/home/homepage_remote_data_sources.dart';
import 'package:rotary/data/data_sources/members/members_remote_data_sources.dart';
import 'package:rotary/data/data_sources/news/news_remote_data_sources.dart';
import 'package:rotary/data/data_sources/notification/notification_remote_data_sources.dart';
import 'package:rotary/data/data_sources/profile/profile_remote_data_sources.dart';
import 'package:rotary/data/data_sources/user/user_local_data_sources.dart';
import 'package:rotary/data/data_sources/user/user_remote_data_sources.dart';
import 'package:rotary/data/repositoryImpl/calendar_event_repo_impl.dart';
import 'package:rotary/data/repositoryImpl/club_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/directory_repo_impl.dart';
import 'package:rotary/data/repositoryImpl/district_governors_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/district_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/event_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/gml_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/home_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/members_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/news_repo_impl.dart';
import 'package:rotary/data/repositoryImpl/notification_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/profile_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/resources_repository_impl.dart';
import 'package:rotary/data/repositoryImpl/user_repository_impl.dart';
import 'package:rotary/domain/repository/calendar_event_repository.dart';
import 'package:rotary/domain/repository/club_repository/club_repository.dart';
import 'package:rotary/domain/repository/directory_repository/directory_repository.dart';
import 'package:rotary/domain/repository/district_committee_repository/district_committee_repository.dart';
import 'package:rotary/domain/repository/district_governors_repository/district_governors_repository.dart';
import 'package:rotary/domain/repository/event_repository/event_repository.dart';
import 'package:rotary/domain/repository/gml_repository/gml_repository.dart';
import 'package:rotary/domain/repository/home_repository/home_repository.dart';
import 'package:rotary/domain/repository/members_repository/members_repository.dart';
import 'package:rotary/domain/repository/news_repository/news_repository.dart';
import 'package:rotary/domain/repository/notification_repository.dart';
import 'package:rotary/domain/repository/profile_repository.dart';
import 'package:rotary/domain/repository/resources_repository/resources_repository.dart';
import 'package:rotary/domain/repository/user_repository.dart';
import 'package:rotary/domain/usecases/auth/authenticate_user_usecase.dart';
import 'package:rotary/domain/usecases/auth/change_passsword_usecase.dart';
import 'package:rotary/domain/usecases/auth/forget_password_usecase.dart';
import 'package:rotary/domain/usecases/calendar_usecase/get_calendar_all_events_usecase.dart';
import 'package:rotary/domain/usecases/club_usecase/get_club_details.dart';
import 'package:rotary/domain/usecases/club_usecase/get_clubs.dart';
import 'package:rotary/domain/usecases/district_committee_usecase/district_committee_usecase.dart';
import 'package:rotary/domain/usecases/district_governor_usecase/get_district_governor_details.dart';
import 'package:rotary/domain/usecases/district_governor_usecase/get_district_governor_usecase.dart';
import 'package:rotary/domain/usecases/event_usecase/get_event_details_usecase.dart';
import 'package:rotary/domain/usecases/event_usecase/get_upcomming_event_usecase.dart';
import 'package:rotary/domain/usecases/gml_usecase/get_gml_usecase.dart';
import 'package:rotary/domain/usecases/home_usecase/get_home_page_data_usecase.dart';
import 'package:rotary/domain/usecases/members_usecase/get_all_members_usecase.dart';
import 'package:rotary/domain/usecases/members_usecase/search_members_usecase.dart';
import 'package:rotary/domain/usecases/news_usecase/get_news_details_usecase.dart';
import 'package:rotary/domain/usecases/news_usecase/get_news_usecase.dart';
import 'package:rotary/domain/usecases/notification/mark_read_all_notification_usecase.dart';
import 'package:rotary/domain/usecases/profile/update_profile_data_usecase.dart';
import 'package:rotary/domain/usecases/resources_usecase/get_resource_description_usecase.dart';
import 'package:rotary/domain/usecases/resources_usecase/get_resources_details_usecase.dart';
import 'package:rotary/domain/usecases/resources_usecase/get_resources_usecase.dart';
import 'package:rotary/core/utils/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/resources/resources_remote_data_sources.dart';
import '../../domain/usecases/notification/mark_read_notification_usecase.dart';
import '../../domain/usecases/profile/get_profile_data_usecase.dart';

final di = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final firebaseMessaging = await FirebaseMessaging.instance;
    di.registerLazySingleton(() => firebaseMessaging);
    di.registerLazySingleton(() => sharedPreferences);
    di.registerLazySingleton(() => DataConnectionChecker());

    di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

    di.registerLazySingleton(() => NetworkUtil(dio: di()));

    di.registerLazySingleton(() => Dio());

    //usecases

    di.registerLazySingleton(() => GetClubsUseCase(di()));
    di.registerLazySingleton<GetNewsUseCase>(
        () => GetNewsUseCaseImpl(newsRepository: di()));
    di.registerLazySingleton<GetNewsDetailsUseCase>(
        () => GetNewsDetailsUseCaseImpl(newsRepository: di()));

    di.registerLazySingleton<GetClubDetailsUseCase>(
        () => GetClubDetailsUseCaseImpl(clubRepository: di()));

    di.registerLazySingleton<GetAllMembersUseCase>(
        () => GetAllMembersUseCaseImpl(membersRepository: di()));

    di.registerLazySingleton<GetHomePageUSeCase>(
        () => GetHomePageUseCaseImpl(homeRepository: di()));

    di.registerLazySingleton<GetUpcommingEventUseCase>(
        () => GetUpcommingEventUseCaseImpl(eventRepository: di()));

    di.registerLazySingleton<GetEventDetailsUsecase>(
      () => GetEventDetailsUsecaseImpl(di()),
    );

    di.registerLazySingleton<GetDistrictCommitteeUseCase>(
      () => GetDistrictCommitteeUseCaseImpl(
        districtCommitteeRepository: di(),
      ),
    );

    di.registerLazySingleton<GetResourcesUseCase>(
        () => GetResourcesUseCaseImpl(resourcesRepository: di()));
    di.registerLazySingleton<GetResourcesDetailsUseCase>(
        () => GetResourcesDetailsUseCaseImpl(resourcesRepository: di()));

    di.registerLazySingleton<GetDistrictGovernorsUseCase>(() =>
        GetDistrictGovernorsUseCaseImpl(districtGovernorRepository: di()));

    di.registerLazySingleton<GetGmlUsecase>(
        () => GetGmlUsecaseImpl(gmlRepository: di()));

    di.registerLazySingleton<GetDistrictGovernorDetailsUseCase>(() =>
        GetDistrictGovernorDetailsUseCaseImpl(
            districtGovernorRepository: di()));

    di.registerLazySingleton<SearchMemberUsecase>(
        () => SearchMemberUsecaseImpl(membersRepository: di()));

    di.registerLazySingleton<AuthenticateUsecase>(
      () => AuthenticateUsecaseImpl(
        userRepository: di(),
      ),
    );

    di.registerLazySingleton<ForgetPasswordUsecase>(
      () => ForgetPasswordUsecaseImpl(
        userRepository: di(),
      ),
    );

    di.registerLazySingleton<ChangePasswordUsecase>(
      () => ChangePasswordUseCaseImpl(
        userRepository: di(),
      ),
    );

    di.registerLazySingleton<GetProfileDataUsecase>(
      () => GetProfileDataUsecaseImpl(
        profileRepository: di(),
      ),
    );

    di.registerLazySingleton<UpdateProfileDataUsecase>(
      () => UpdateProfileDataUsecaseImpl(
        profileRepository: di(),
      ),
    );

    di.registerLazySingleton<GetResourceDescriptionUseCase>(
      () => GetResourceDescriptionUseCaseImpl(
        di(),
      ),
    );

    di.registerLazySingleton<GetCalendarAllEventUseCase>(
      () => GetCalendarAllEventUseCaseImpl(
        di(),
      ),
    );

    di.registerLazySingleton<MarkReadAllNotificationUseCase>(
      () => MarkReadAllNotificationUseCaseImpl(
        di(),
      ),
    );
    di.registerLazySingleton<MarkReadNotificationUseCase>(
      () => MarkReadNotificationUseCaseImpl(
        di(),
      ),
    );

    //repository

    di.registerLazySingleton<ClubRepository>(
      () => ClubRepositoryImpl(
        remoteDataSource: di(),
        networkInfo: di(),
        userLocalDataSources: di(),
      ),
    );
    di.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(networkInfo: di(), remoteDataSource: di()));

    di.registerLazySingleton<MembersRepository>(() => MembersRepositoryImpl(
        networkInfo: di(),
        membersRemoteDataSource: di(),
        userLocalDataSources: di()));

    di.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        networkInfo: di(),
        userLocalDataSources: di(),
        homePageRemoteDataSource: di()));

    di.registerLazySingleton<EventRepository>(
        () => EventRepositoryImpl(networkInfo: di(), remoteDataSource: di()));

    di.registerLazySingleton<DistrictCommitteeRepository>(() =>
        DistrictCommitteeRepositoryImpl(
            networkInfo: di(), districtCommitteeRemoteDataSource: di()));

    di.registerLazySingleton<ResourcesRepository>(() => ResourcesRepositoryImpl(
        networkInfo: di(), resourcesRemoteDataSource: di()));

    di.registerLazySingleton<DistrictGovernorRepository>(() =>
        DistrictGovernorRepositoryImpl(
            networkInfo: di(), districtGovernorRemoteDataSource: di()));

    di.registerLazySingleton<GmlRepository>(
        () => GmlRepositoryImpl(networkInfo: di(), gmlRemoteDataSource: di()));

    di.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
          networkInfo: di(),
          userRemoteDataSource: di(),
          userLocalDataSources: di()),
    );

    di.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        networkInfo: di(),
        profileRemoteDataSources: di(),
        userLocalDataSources: di(),
        userRepository: di(),
      ),
    );
    di.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
          firebaseMessaging: di(),
          notificationRemoteDataSources: di(),
          userLocalDataSources: di()),
    );

    di.registerLazySingleton<CalendarEventRepository>(
      () => CalendarEventRepositoryImpl(
        networkInfo: di(),
        calendarRemoteDataSources: di(),
      ),
    );

    di.registerLazySingleton<DirectoryRepository>(() =>
        DirectoryRepoImpl(directoryRemoteDataSource: di(), networkInfo: di()));

    // remote data sources

    di.registerLazySingleton<ClubRemoteDataSource>(
      () => ClubRemoteDataSourceImpl(
        networkUtil: di(),
      ),
    );
    di.registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(di()));
    di.registerLazySingleton<MembersRemoteDataSource>(
        () => MembersRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<HomePageRemoteDataSource>(
        () => HomePageRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<EventRemoteDataSource>(
        () => EventRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<DistrictCommitteeRemoteDataSource>(
        () => DistrictCommitteeRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<ResourcesRemoteDataSource>(
        () => ResourcesRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<DistrictGovernorRemoteDataSource>(
        () => DistrictGovernorRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<GmlRemoteDataSource>(
        () => GmlRemoteDataSourceImpl(networkUtil: di()));

    di.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(
        networkUtil: di(),
      ),
    );

    di.registerLazySingleton<ProfileRemoteDataSources>(
      () => ProfileRemoteDataSourcesImpl(
        networkUtil: di(),
      ),
    );
    di.registerLazySingleton<CalendarRemoteDataSources>(
      () => CalendarRemoteDataSourcesImpl(
        networkUtil: di(),
      ),
    );
    di.registerLazySingleton<NotificationRemoteDataSources>(
      () => NotificationRemoteDataSourcesImpl(
        networkUtil: di(),
      ),
    );
    di.registerLazySingleton<DirectoryRemoteDataSource>(
      () => DirectoryRemoteDataSourceImpl(
        networkUtil: di(),
      ),
    );

    //local data sources

    di.registerLazySingleton<UserLocalDataSources>(
      () => UserLocalDataSourcesImpl(
        sharedPreferences: di(),
      ),
    );
  }
}
