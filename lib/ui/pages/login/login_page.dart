import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            SizedBox(
              width: 32,
              height: 52,
            ),
            HeadLine1(text: 'Login'),
            SizedBox(
              width: 32,
              height: 52,
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: presenter.validateEmail,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColorLight,
                        )),
                    obscureText: true,
                  ),
                  SizedBox(
                    width: 32,
                    height: 32,
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text('Entrar'.toUpperCase()),
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta'.toUpperCase()))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
