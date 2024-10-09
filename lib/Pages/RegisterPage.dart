import 'package:app/Components/SnackbarComponent.dart';
import 'package:app/Controllers/UserController.dart';
import 'package:app/Pages/LoginPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final UserController userController = UserController();
  String _pseudo = '';
  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  void sendRequest() async {
    if (_pseudo.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty) {
      if (_password == _passwordConfirm) {
        int responseCode =
            await userController.registerUser(_email, _password, _pseudo);
        if (responseCode == 201) {
          SnackbarComponent.build('Votre compte a été créé', context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const LoginPage(title: 'MediSync - Connectez vous')));
        } else {
          SnackbarComponent.build('Une erreur est survenue', context);
        }
      } else {
        SnackbarComponent.build(
            'Les mots de passe ne correspondent pas', context);
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
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Pseudo : ')),
                    validator: (valeur) {
                      if (valeur == null || valeur.isEmpty) {
                        _pseudo = '';
                      } else {
                        _pseudo = valeur;
                      }
                      return null;
                    },
                  ),
                ),
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
                      decoration:
                          const InputDecoration(label: Text( 'Mot de passe: ')),
                      obscureText: _obscureText,
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

                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text( 'Confirmation mot de passse: ')),
                      obscureText: _obscureTextConfirm,
                      validator: (valeur) {
                        if (valeur == null || valeur.isEmpty) {
                          _passwordConfirm = '';
                        } else {
                          _passwordConfirm = valeur;
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () =>setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      }),
                      icon: Icon(_obscureTextConfirm
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ]),
                const Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendRequest();
                    }
                  },
                  child: const Text("S'inscrire", style: TextStyle(color: Colors.white)),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
