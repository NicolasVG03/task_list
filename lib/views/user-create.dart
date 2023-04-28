import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class UserCreatePage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

  String email = '';
  String password = '';

  void Registrar(BuildContext context) {
   
    if(formKey.currentState!.validate()) {
      formKey.currentState!.save();
      firestore.collection('users').add({
        'email': email,
        'password': password,
      });
      Navigator.of(context).pushNamed('task-list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Obrigatorio';
                  } else if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
                    return 'Email invalido';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                onSaved: (value) =>  {
                  password = value!
                },
                validator: (value) => value!.isEmpty ? 'Senha invalida' : null
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => Registrar(context),
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}