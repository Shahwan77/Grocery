import 'package:get_storage/get_storage.dart';

class Storage{
  String Token = GetStorage().read('authToken') ?? '';
}