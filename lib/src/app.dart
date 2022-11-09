import 'package:auto_pedia/src/blocs/blocs.dart';
import 'package:auto_pedia/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => UserBloc())
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
