import 'package:flutter/material.dart';
// import 'package:our_kahoot/views/question_creator_screen.dart';
//import '../models/data_layer.dart';
import './registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Login'),
              validator: (text) => text!.isEmpty ? 'Enter your login' : null,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (text) => text!.isEmpty ? 'Enter your password' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _validate, child: const Text('Continue')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.route);
              },
              child: const Text('Registration'),
            )
          ],
        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

                                                        //final name = _nameController.text;
                                                        //final password = _passwordController.text;

    //check validation of user if ok then:

    // get status of user
                                                        //final status = 'creator';
    //Navigator.of(context)
      //  .pushReplacementNamed(QuestionCreatorScreen.route, arguments: status);
  }
}
