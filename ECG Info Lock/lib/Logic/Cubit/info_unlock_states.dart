import 'package:ecg_info_lock/Data/Models/biometri_data.dart';

abstract class InfoUnlockStates {}

class Initial extends InfoUnlockStates{}

class Loading extends InfoUnlockStates{}

class Uploaded extends InfoUnlockStates{
  final BiometriData userBiometric;
  final bool signalPicked;
  Uploaded({required this.userBiometric, required this.signalPicked});
}

class Authenticated extends InfoUnlockStates{}

class Error extends InfoUnlockStates {
  final String error;
  Error({required this.error});
}

class Unauthenticated extends InfoUnlockStates {
  final String error;
  Unauthenticated({required this.error});
}

 