import 'package:rxdart/rxdart.dart';

class appbarBloc{
  final _changewidget=PublishSubject<bool>();
  Stream<bool> get changevalue=>_changewidget.stream;
  changevalueonclick(bool flag)async{
    _changewidget.sink.add(flag);
  }

  dispose(){
    _changewidget.close();
  }

}

final appbarswitchbloc=appbarBloc();