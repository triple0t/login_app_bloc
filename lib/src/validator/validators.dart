import 'dart:async';

class Validators {

  static const emailErrorText = 'Invalid email';
  static const passwordErrorText = 'Password not secured';

  emailValidator(String email) {
    if (! email.contains('@')) {
      return emailErrorText;
    }

    return null;
  }
  
  StreamTransformer<String, String> emailValidatorTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      // i am writing this again because i currently can't figure out a way to execute emailValidator() in this method
      // error: Only static members can be accessed in initializers.
      if ( ! email.contains('@') ) {
        sink.addError(emailErrorText);
      } else {
        sink.add(email);
      }
    }
  );

  passwordValidator(String password) {
    if (password.length < 3) {
      return passwordErrorText;
    }

    return null;
  }

  StreamTransformer<String, String> passwordValidatorTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length < 3) {
        sink.addError(passwordErrorText);
      } else {
        sink.add(password);
      }
    }
  );

}