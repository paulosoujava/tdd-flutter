import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isloading) {
            if (isloading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });
          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });
          return SingleChildScrollView(
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
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                        child: Column(
                      children: [
                        EmailInput(),
                        PasswordInput(),
                        SizedBox(
                          width: 32,
                          height: 32,
                        ),
                        LoginButton(),
                        FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.person),
                            label: Text('Criar Conta'.toUpperCase()))
                      ],
                    )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
