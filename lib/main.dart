import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'package:eventos_deportivos/ui/homepage/home_page.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';


// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';


//void main() => runApp(MyApp());
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isAmplifySuccessfullyConfigured = false;
    try {
      await _configureAmplify();
      isAmplifySuccessfullyConfigured = true;
    } on AmplifyAlreadyConfiguredException {
      debugPrint('Amplify configuration failed.');
    }
    runApp(
      ProviderScope(
        child: HomePage(
          isAmplifySuccessfullyConfigured: isAmplifySuccessfullyConfigured,
        ),
      ),
    );
  }

Future<void> _configureAmplify() async {
  await Amplify.addPlugins([
    AmplifyAuthCognito(),
    AmplifyDataStore(modelProvider: ModelProvider.instance),
    AmplifyAPI(),
    AmplifyStorageS3()
  ]);
  await Amplify.configure(amplifyconfig);
}

