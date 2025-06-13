class BiometriData {
  final String patientName;
  final double predictedClass;
  final String result;
  final double accuracy;
  final List<double> signalSamples;
  final List<double> timeVector;

  BiometriData({
    required this.patientName,
    required this.predictedClass,
    required this.result,
    required this.accuracy,
    required this.signalSamples,
    required this.timeVector,
  });
}
