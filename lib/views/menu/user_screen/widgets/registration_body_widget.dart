import 'package:flutter/material.dart';
import '/views/menu/user_screen/widgets/switch_widget.dart';
import '/animations/custom_page_route.dart';
import '/views/menu/login_screen/login_screen.dart';
import '../../widgets/rounded_button_widget.dart';
import 'registration_background_widget.dart';
import '/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:uuid/uuid.dart';
import '/controllers/user_controller.dart';

class RegistrationBodyWidget extends StatefulWidget {
  const RegistrationBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RegistrationBodyWidgetState createState() => _RegistrationBodyWidgetState();
}

class _RegistrationBodyWidgetState extends State<RegistrationBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  late User user;

  @override
  void initState() {
    super.initState();

    final id = Uuid().v4();
    user = User(id: id, dateOfBirth: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: RegistrationBackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "REGISTRATION",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(244, 190, 199, 1),
                  borderRadius: BorderRadius.circular(29)),
              child: TextFormField(
                controller: _loginController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct Login';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: "Your login",
                  border: InputBorder.none,
                ),
                onChanged: (name) =>
                    setState(() => user = user.copy(name: name)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(244, 190, 199, 1),
                  borderRadius: BorderRadius.circular(29)),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct Password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),
                  hintText: "Password",
                  border: InputBorder.none,
                ),
                onChanged: (password) =>
                    setState(() => user = user.copy(password: password)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(244, 190, 199, 1),
                  borderRadius: BorderRadius.circular(29)),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      _passwordController.text != value) {
                    return 'Please enter same passwords';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),
                  hintText: "Repeat Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            // BirthdayWidget(
            //   birthday: user.dateOfBirth,
            //   onChangedBirthday: (dateOfBirth) =>
            //       setState(() => user = user.copy(dateOfBirth: dateOfBirth)),
            // ),
            SwitchWidget(
              title: 'Are you creator?',
              value: user.settings.isCreator,
              onChanged: (isCreator) {
                final settings = user.settings.copy(
                  isCreator: isCreator,
                );

                setState(() => user = user.copy(settings: settings));
              },
            ),
            RoundedButtonWidget(
                text: "SIGN UP",
                press: checkRegistration,
                color: const Color(0xFF6F35A5),
                textColor: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account? ",
                  style: TextStyle(
                    color: Color(0xFF6F35A5),
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(CustomPageRoute(
                          child: const LoginScreen(),
                        )),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6F35A5),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void checkRegistration() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    await UserController.addUsers(user);
    await UserController.setUser(user);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }
}
