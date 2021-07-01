

import 'package:hrm_app/utility/constant.dart';
import 'package:rxdart/rxdart.dart';

class switchtimewidgetBloc{

  final _changewidget=PublishSubject<bool>();
  Stream<bool> get changevalue=>_changewidget.stream;
  changevalueonclick(bool flag)async{
    _changewidget.sink.add(flag);
    Constant.changePuch=flag;

  }

  dispose(){
    _changewidget.close();
  }

}

final switchtimebloc=switchtimewidgetBloc();