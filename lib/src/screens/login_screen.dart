import 'package:flutter/material.dart';
import 'package:mylogin_app_demo/src/blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  build(context) {
    return Container(
      margin: EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          createEmailField(),
          createPasswordField(),
          Container(margin: EdgeInsets.only(top: 20)),
          createSubmitButton()
        ],
      ),
    );
  }

  Widget createEmailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'hello@mail.com',
            labelText: 'Enter your Email',
            // errorText: 'Invalid Email, try again'
            errorText: snapshot.error
          ),
          onChanged: bloc.addEmailStream,
        );
      },
    );
  }

  Widget createPasswordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Enter your Password',
            // errorText: 'Password not secured'
            errorText: snapshot.error
          ),
          onChanged: (v) {
            // print('New Value: ' + v);
            bloc.addPasswordStram(v);
          },
        );
      },
    );
  }

  Widget createSubmitButton() {
    return StreamBuilder(
      stream: bloc.button,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Text('Submit'),
          color: Colors.cyan,
          onPressed: snapshot.hasData ? () {
            print('Submited');
            bloc.submit(snapshot.data);
          } : null, // null will make the button disabled
        );
      },
    );
  }
}
