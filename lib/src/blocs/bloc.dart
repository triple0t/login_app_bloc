
import 'dart:async';
import 'package:mylogin_app_demo/src/validator/validators.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Validators {
  // i'm a little bit worried about using this error. 
  // TODO: need to better understand how  broadcast works

  StreamController _emailController = StreamController<String>.broadcast();
  StreamController _passwordController = StreamController<String>.broadcast(); // BehaviorSubject can be used here as well.

  void addEmailStream(String value) {
    _emailController.sink.add(value);
    // why not these? 
    // _emailController.add(value);
    // this one below receives a string
    // _emailController.addStream(value);
  }

  void addPasswordStram(String value) {
    _passwordController.sink.add(value);
  }

  // get email => _emailController.stream.transform( emailTransformer() );
  get email => _emailController.stream.transform( emailValidatorTransformer );

  // get password => _passwordController.stream.transform(passwordTransformer());
  get password => _passwordController.stream.transform( passwordValidatorTransformer );

  get button => Observable.combineLatest2(email, password, (e, p) => {'email': e, 'password': p } );

  submit(Map<String, dynamic> v) {
    // we need a way to combine two streams, email and password stream
    print('Value: ${v.values}');  
    String email = v['email'];
    String password = v['password'];

    print('Email is: $email and Password is: $password');
  }

  // this seems to have an error
  // i was trying to locate another method to merge stream without using rxdart
  // TODO: find another way to merge two streams with Dart core

  Stream<bool> createCs(Stream a, Stream b) {
    return new StreamZip([a, b]).map((ab) => true);
  }
  


  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

final Bloc bloc = Bloc();