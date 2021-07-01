import 'package:rxdart/subjects.dart';

class switchwidgetBloc{
  final _changewidget=PublishSubject<bool>();
  Stream<bool> get changevalue=>_changewidget.stream;
  changevalueonclick(bool flag)async{
    _changewidget.sink.add(flag);
  }

  dispose(){
   _changewidget.close();
  }

}

final switchbloc=switchwidgetBloc();