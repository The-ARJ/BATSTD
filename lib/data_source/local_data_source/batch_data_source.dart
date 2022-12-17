import 'package:institute_objectbox/helper/objectbox.dart';
import 'package:institute_objectbox/model/batch.dart';
import 'package:institute_objectbox/model/student.dart';

import '../../state/objectbox_state.dart';

class BatchDataSource {
  // Get the objectBox instance from state
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addBatch(Batch batch) async {
    try {
      return objectBoxInstance.addBatch(batch);
    } catch (e) {
      return 0;
    }
  }

  Future<List<Batch>> getAllBatch() async {
    try {
      return Future.value(objectBoxInstance.getAllBatch());
    } catch (e) {
      throw Exception('Error in getting all batch');
    }
  }

  Future<List<Student>> getStudentByBatchName(String batchName) {
    try {
      return Future.value(objectBoxInstance.getStudentByBatchName(batchName));
    } catch (e) {
      throw Exception('Error in getting all student');
    }
  }
}
