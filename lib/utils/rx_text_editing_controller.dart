import 'package:flutter/widgets.dart';
import 'package:rxdart/subjects.dart';

class RxTextEditingController extends TextEditingController {
  PublishSubject<String>? _onEditedSubject;

  PublishSubject<String> getUpdates() {
    if (_onEditedSubject != null) {
      return _onEditedSubject!;
    } else {
      _onEditedSubject = PublishSubject<String>();
      addListener(() => _onEditedSubject!.add(text));
      return _onEditedSubject!;
    }
  }

  @override
  void dispose() {
    _onEditedSubject?.close();
    super.dispose();
  }
}
