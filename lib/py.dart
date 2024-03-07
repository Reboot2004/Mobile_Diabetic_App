import 'package:dartpy/dartpy.dart';
import 'package:dartpy/dartpy_annotations.dart';
//part 'python_helper.g.dart';
class PythonHelper {
  static void initializePython() {
    pyStart();
  }

  static void cleanupPython() {
    pyCleanup();
  }

  @PyFunction(module: 'app_rfc', name: 'predict')
  static Future<String> makePrediction(List<Map<String, dynamic>> inputData) async {
    try {
      final result = '';//await papp_rfc(inputData);
      return result;
    } on DartPyException catch (e) {
      print('Error making prediction: $e');
      rethrow;
    }
  }
}
