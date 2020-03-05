library safesubject;

import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class SafeSubject<T extends Subject, U> {
  T _subject;

  T Function() subjectConstructor;

  T get subject {
    if (_subject == null || _subject.isClosed) {
      _subject = newSubject();
    }

    return _subject;
  }

  StreamSubscription<U> Function(void Function(U) onData, {Function onError, void Function() onDone, bool cancelOnError}) get listen => subject.stream.listen;
  Stream<U> get stream => subject.stream;
  StreamSink<U> get sink => subject.sink;

  close() {
    if (_subject != null) {
      _subject.close();
    }
  }

  T newSubject();
}

class SafeBehaviorSubject<T> extends SafeSubject<BehaviorSubject<T>, T> {

  T seedValue;

  SafeBehaviorSubject();
  SafeBehaviorSubject.seeded(this.seedValue);

  T get value => subject.value;

  @override
  BehaviorSubject<T> newSubject() {
    if(seedValue != null){
      return BehaviorSubject<T>.seeded(seedValue);
    }

    return BehaviorSubject<T>();
  }
}

class SafePublishSubject<T> extends SafeSubject<PublishSubject<T>, T> {
  @override
  PublishSubject<T> newSubject() {
    return PublishSubject<T>();
  }
}
