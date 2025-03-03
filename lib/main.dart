import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/features/auth/data/data_source/remote_data/remote_data.dart';
import 'package:task1/features/auth/data/repositories/Impl_Repo.dart';
import 'package:task1/features/auth/domain/UseCases/get_current_user_use_case.dart';
import 'package:task1/features/auth/domain/UseCases/sign_up_use_case.dart';
import 'package:task1/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task1/features/auth/presentation/Screens/scn1.dart';
import 'package:task1/features/auth/presentation/controller/providers.dart';
import 'package:task1/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:task1/features/weather/data/datasources/user_remote_user_data_source.dart';
import 'package:task1/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:task1/features/weather/data/repositories/user_repository_impl.dart';
import 'package:task1/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:task1/features/weather/domain/usecases/get_user_usecase.dart';
import 'package:task1/features/weather/presentation/providers/weather_provider.dart';
import 'package:task1/features/weather/presentation/providers/user_provider.dart';
import 'package:task1/features/weather/data/datasources/ai_model_service.dart';
import 'package:task1/features/weather/data/repositories/ai_weather_repository_impl.dart';
import 'package:task1/features/weather/domain/usecases/predict_outdoor_activity_usecase.dart';
import 'package:task1/features/weather/presentation/providers/ai_weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Ai_Weather());
}

class Ai_Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            signInUseCase: SignInUseCase(
              repository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(),
              ),
            ),
            signUpUseCase: SignUpUseCase(
              repository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(),
              ),
            ),
            getCurrentUserUseCase: GetCurrentUserUseCase(
              repository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            getWeatherUseCase: GetWeatherUseCase(
              repository: WeatherRepositoryImpl(
                remoteDataSource: WeatherRemoteDataSource(),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            getUserUseCase: GetUserUseCase(
              repository: UserRepositoryImpl(
                remoteDataSource: UserRemoteDataSource(),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AiWeatherProvider(
            predictOutdoorActivityUseCase: PredictOutdoorActivityUseCase(
              repository: AiWeatherRepositoryImpl(
                aiModelService: AiModelService(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth & Weather App',
        home: WelcomePage(), // Your existing welcome page
      ),
    );
  }
}
