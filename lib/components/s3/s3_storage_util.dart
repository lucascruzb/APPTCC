import 'dart:io';
import 'package:listy/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class S3StorageUtil {
  // Método para inicializar o Amplify
  static Future<void> initializeAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      final storage =
          AmplifyStorageS3(prefixResolver: const MyPrefixResolver());
      await Amplify.addPlugins([auth, storage]);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  // Método para fazer upload de um arquivo para o S3
  Future<StorageUploadFileResult<StorageItem>> uploadImage(
      String key, File file) async {
    try {
      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(file.path),
        key: key,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;
      return result;
      //safePrint('Successfully uploaded file: ${result.uploadedItem.key}');
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }

  // Método para baixar um arquivo do S3
  Future<void> downloadToMemory(String key) async {
    try {
      final result = await Amplify.Storage.downloadData(
        key: key,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;

      safePrint('Downloaded data: ${result.bytes}');
    } on StorageException catch (e) {
      safePrint(e.message);
    }
  }

  Future<String> getDownloadUrl({
    required String key,
  }) async {
    try {
      final result = await Amplify.Storage.getUrl(
        key: key,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: Duration(days: 1),
          ),
        ),
      ).result;
      //safePrint(result.url.toString());
      return result.url.toString();
    } on StorageException catch (e) {
      safePrint('Could not get a downloadable URL: $e');
      rethrow;
    }
  }

  // Adicione mais métodos conforme necessário para outras operações do Amplify Storage S3
}

class MyPrefixResolver implements S3PrefixResolver {
  const MyPrefixResolver();

  @override
  Future<String> resolvePrefix({
    required StorageAccessLevel accessLevel,
    String? identityId,
  }) async {
    if (accessLevel == StorageAccessLevel.guest) {
      return '';
    }

    final String accessLevelPrefix;

    if (accessLevel == StorageAccessLevel.protected) {
      accessLevelPrefix = 'Protected/';
    } else {
      accessLevelPrefix = 'Private/';
    }

    final targetIdentityId = identityId ?? await getCurrentUserIdentityId();

    return '$accessLevelPrefix$targetIdentityId/';
  }

  Future<String> getCurrentUserIdentityId() async {
    final authPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final authSession = await authPlugin.fetchAuthSession();
    return authSession.identityIdResult.value;
  }
}
