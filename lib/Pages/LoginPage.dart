import 'package:app/Components/SnackbarComponent.dart';
import 'package:app/Controllers/UserController.dart';
import 'package:app/Pages/HomePage.dart';
import 'package:app/Pages/RegisterPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final UserController userController = UserController();
  String _email = '';
  String _password = '';
  bool _obscureText = true;

  void sendRequest() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      int responseCode = await userController.authUser(_email, _password);
      if (responseCode == 201) {
        SnackbarComponent.build('Bienvenue', context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomePage(title: 'MediSync - Accueil')));
      } else {
        SnackbarComponent.build('Une erreur est survenue', context);
      }
    } else {
      SnackbarComponent.build(
          'Veuillez saisir des identifiants valides', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(children: [
                const Image(image: AssetImage('assets/logo.png')),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Email : ')),
                    validator: (valeur) {
                      if (valeur == null || valeur.isEmpty) {
                        _email = '';
                      } else {
                        _email = valeur;
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration:
                          const InputDecoration(label: Text('Password: ')),
                      validator: (valeur) {
                        if (valeur == null || valeur.isEmpty) {
                          _password = '';
                        } else {
                          _password = valeur;
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () => setState(() {
                            _obscureText = !_obscureText;
                          }),
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ]),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                InkWell(
                    child: Text('Pas encore de compte ?',
                        style: TextStyle(color: Colors.blue.shade900)),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage(
                                title: 'MediSync - Inscrivez vous')))),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendRequest();
                    }
                  },
                  child: const Text("Se connecter",
                      style: TextStyle(color: Colors.white)),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
