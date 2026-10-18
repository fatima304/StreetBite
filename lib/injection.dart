import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/data/repositories/stripe_payment_repository_impl.dart';
import 'package:get_it/get_it.dart';

// Core
import 'package:food_delivery/core/network/dio_factory.dart';

// Services
import 'package:food_delivery/services/auth_service.dart';
import 'package:food_delivery/services/meal_api_service.dart';
import 'package:food_delivery/services/stripe_payment_service.dart';
import 'package:food_delivery/services/stripe_api_service.dart';

// Data Sources
import 'data/datasources/biometric_datasource.dart';
import 'data/datasources/device_info_datasource.dart';
import 'data/datasources/meal_cache_data_source.dart';

// Repositories
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/cart_repository.dart';
import 'data/repositories/favourites_repository.dart';
import 'data/repositories/meal_repository_factory.dart';
import 'data/repositories/orders_repository.dart';
import 'data/repositories/profile_repository.dart';

// Domain
import 'package:food_delivery/domain/repositories/auth_repository.dart';
import 'package:food_delivery/domain/repositories/home_repository.dart';
import 'package:food_delivery/domain/repositories/stripe_payment_repository.dart';

// Presentation - Blocs & Cubits
import 'package:food_delivery/presentation/blocs/auth_cubit.dart';
import 'package:food_delivery/presentation/blocs/biometric_cubit.dart';
import 'package:food_delivery/presentation/blocs/cart_bloc.dart';
import 'package:food_delivery/presentation/blocs/device_info_cubit.dart';
import 'package:food_delivery/presentation/blocs/favourites_cubit.dart';
import 'package:food_delivery/presentation/blocs/home_cubit.dart';
import 'package:food_delivery/presentation/blocs/meal_details_cubit.dart';
import 'package:food_delivery/presentation/blocs/search_cubit.dart';
import 'package:food_delivery/presentation/blocs/stripe_payment_cubit.dart';
import 'package:food_delivery/presentation/blocs/theme_bloc.dart';

// Dependency Injection
final getIt = GetIt.instance;

void setupDependencies() {
  // Core Services

  getIt.registerLazySingleton<AuthService>(() => AuthService());

  getIt.registerLazySingleton<Dio>(DioFactory.createMealDio);

  // Authentication
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthService>()),
  );

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));

  //Theme
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc());

  //Home & Search
  getIt.registerLazySingleton<MealCacheDataSource>(() => MealCacheDataSource());

  getIt.registerLazySingleton<MealApiService>(
    () => MealApiService(getIt<Dio>()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => MealRepositoryFactory.create(
      api: getIt<MealApiService>(),
      cache: getIt<MealCacheDataSource>(),
    ),
  );

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));

  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<HomeRepository>()),
  );

  //Meal Details
  getIt.registerFactory<MealDetailsCubit>(
    () => MealDetailsCubit(getIt<HomeRepository>()),
  );

  // Cart
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepository(FirebaseFirestore.instance, FirebaseAuth.instance),
  );

  // One shared cart instance across the authenticated app.
  getIt.registerLazySingleton<CartBloc>(
    () => CartBloc(getIt<CartRepository>(), FirebaseAuth.instance),
  );

  // Favourites
  getIt.registerLazySingleton<FavouritesRepository>(
    () =>
        FavouritesRepository(FirebaseFirestore.instance, FirebaseAuth.instance),
  );

  getIt.registerLazySingleton<FavouritesCubit>(
    () => FavouritesCubit(getIt<FavouritesRepository>(), FirebaseAuth.instance),
  );

  // Profile
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
  );

  // Orders
  getIt.registerLazySingleton<OrdersRepository>(
    () => OrdersRepository(FirebaseFirestore.instance, FirebaseAuth.instance),
  );

  // Stripe Payment
  getIt.registerLazySingleton<StripeApiService>(
    () => StripeApiService(DioFactory.createStripeDio()),
  );

  getIt.registerLazySingleton<StripePaymentService>(
    () => StripePaymentService(
      secretKey: const String.fromEnvironment('STRIPE_TEST_SECRET_KEY'),
      api: getIt<StripeApiService>(),
    ),
  );

  getIt.registerLazySingleton<StripePaymentRepository>(
    () => StripePaymentRepositoryImpl(getIt<StripePaymentService>()),
  );

  getIt.registerFactory<StripePaymentCubit>(
    () => StripePaymentCubit(getIt<StripePaymentRepository>()),
  );

  // Device Info
  getIt.registerLazySingleton<DeviceInfoDataSource>(
    () => DeviceInfoDataSource(),
  );

  getIt.registerFactory<DeviceInfoCubit>(
    () => DeviceInfoCubit(getIt<DeviceInfoDataSource>()),
  );

  // Biometrics
  getIt.registerLazySingleton<BiometricDataSource>(() => BiometricDataSource());

  getIt.registerFactory<BiometricCubit>(
    () => BiometricCubit(getIt<BiometricDataSource>()),
  );
}
