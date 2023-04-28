
import 'package:flutter/material.dart';
import 'views/app.dart';
import 'package:firebase_core/firebase_core.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyAWaD_rLH26wzX5dFDUI96yhyE3oi5x5D8",
  authDomain: "task-list-14d10.firebaseapp.com",
  projectId: "task-list-14d10",
  storageBucket: "task-list-14d10.appspot.com",
  messagingSenderId: "133830225954",
  appId: "1:133830225954:web:032bbace69aeb220239a7b"
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(App());
}
