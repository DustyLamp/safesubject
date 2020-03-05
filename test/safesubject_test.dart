import 'package:flutter_test/flutter_test.dart';

import 'package:safesubject/safesubject.dart';

void main() {
  test('recovers after deletion', (){
    final SafeBehaviorSubject<bool> safeSubject = SafeBehaviorSubject<bool>();
    safeSubject.close();
    safeSubject.listen((bool result){
      expect(result, true);
    });
    safeSubject.sink.add(true);
  });
}
