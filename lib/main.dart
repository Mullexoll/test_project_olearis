import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_flutter/bloc/olearis_bloc.dart';

import 'presentation/screens/sign_in.screen.dart';

void main() {
  runApp(const OlearisTestApp());
}

class OlearisTestApp extends StatelessWidget {
  const OlearisTestApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OlearisBloc()..add(OlearisAppLoaded()),
      child: MaterialApp(
        title: 'Olearis Test App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
