import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:ecg_info_lock/Core/Constants/app_messages.dart';
import 'package:ecg_info_lock/Data/Models/biometri_data.dart';
import 'package:ecg_info_lock/Logic/Cubit/info_unlock_states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;


class InfoUnlockCubit extends Cubit<InfoUnlockStates> {
  InfoUnlockCubit() : super(Initial());

  String? signalPath;


  Future<void> upload() async {
    try {
      emit(Loading());

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['dat', 'hea', 'xyz'],
        withData: true,
      );

      if (result != null && result.files.length >= 2) {
        final uri = Uri.parse('http://127.0.0.1:5000/predict');
        final request = http.MultipartRequest('POST', uri);

        for (var file in result.files) {
          if (file.bytes != null) {
            request.files.add(http.MultipartFile.fromBytes(
              'file',
              file.bytes!,
              filename: file.name,
            ));
          }
        }

        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          final decoded = jsonDecode(responseBody);
          final String signalId = decoded['patient_id'] ?? '';
          final String patientName = await getPatientName(signalId: signalId);

          final BiometriData biometric = BiometriData(
            predictedClass: (decoded['predicted_class'] ?? 0).toDouble(),
            result: decoded['result'] ?? 'Not Identified',
            accuracy: (decoded['confidence'] ?? 0).toDouble(),
            signalSamples: List<double>.from(decoded['signal_samples'] ?? []),
            timeVector: List<double>.from(decoded['time_vector'] ?? []),
            patientName: patientName, 
          );

          emit(Uploaded(userBiometric: biometric, signalPicked: true));
        }
        
        else {
          emit(Error(error: AppMessages.genericError));
        }
      } 
      else {
        emit(Initial());
        emit(Error(error: AppMessages.uploadedLessFiles));
      }
    } 
    catch (e) {
      emit(Initial());
      emit(Error(error: AppMessages.genericError));
    }
  }

  Future<String> getPatientName({required String signalId}) async {
    String patientName = '';
    switch (signalId) {
      case 's0173lre':
        patientName = 'Patient 049';
        break;

      case 's0236lre':
        patientName = 'Patient 071';
        break;

      case 's0267lre':
        patientName = 'Patient 082';
        break;

      case 's0340lre':
        patientName = 'Patient 191';
        break;

      case 's0432_re':
        patientName = 'Patient 210';
        break;

      default:
        patientName = 'Unknown Patient';
    }

    return patientName;
  }


  Future<void> authenticate({required String identifyingResult}) async {
    if(identifyingResult.isEmpty) {
      emit(Error(error: AppMessages.unlockWithoutBiometric));
      return;
    }
    emit(Loading());
    if(identifyingResult.toLowerCase() != 'identified') {
      emit(Unauthenticated(error: AppMessages.unlockFailed));
    }
    else if (identifyingResult.toLowerCase() == 'identified') {
      emit(Authenticated());
    }
  }



}