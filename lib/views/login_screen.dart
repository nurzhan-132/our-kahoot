import 'package:flutter/material.dart';
import '../game_provider.dart';
import './registration_screen.dart';
import 'game_creator_screen.dart';

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
        backgroundColor: Colors.deepPurpleAccent,
        body: Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Icon(Icons.person_outlined,
                        color: Colors.grey[300], size: 140),
                    SizedBox(height: 13),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              color: Colors.yellow,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                controller: _nameController,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                        Icons.alternate_email_sharp,
                                        size: 30),
                                    labelText: 'username',
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    )),
                                validator: (text) =>
                                    text!.isEmpty ? 'Enter your login' : null,
                              )),
                          SizedBox(height: 10),
                          Container(
                              color: Colors.yellow,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock, size: 30),
                                    labelText: 'password',
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    )),
                                validator: (text) => text!.isEmpty
                                    ? 'Enter your password'
                                    : null,
                              )),
                          SizedBox(height: 10),
                          SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: FlatButton(
                                color: Colors.yellow,
                                textColor: Colors.white,
                                onPressed: _validate,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? --> ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RegistrationScreen.route);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => GameProvider(
                child: const MaterialApp(
              home: GameCreatorScreen(),
            ))));

    //final name = _nameController.text;
    //final password = _passwordController.text;

    //check validation of user if ok then:

    // get status of user
    //final status = 'creator';
    //Navigator.of(context)
    //  .pushReplacementNamed(QuestionCreatorScreen.route, arguments: status);
  }
}
