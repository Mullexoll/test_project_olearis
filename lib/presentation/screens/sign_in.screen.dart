import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_flutter/constants/app_assets_constants.dart';
import 'package:olearis_flutter/navigation/navigation.dart';

import '../../bloc/olearis_bloc.dart';
import '../widgets/sign_in_screen_widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    void navigateToHomeScreen(BuildContext context) {
      ApplicationNavigation(context).navigateToHomeScreen();
    }

    void signInEvent(BuildContext context) async {
      BlocProvider.of<OlearisBloc>(context).add(OlearisSignInEvent());
      await Future.delayed(
        const Duration(seconds: 2),
        () => navigateToHomeScreen(context),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Sign In'),
      ),
      body: BlocBuilder<OlearisBloc, OlearisState>(
        builder: (context, state) {
          if (state is OlearisStateLoaded) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: orientation == Orientation.portrait
                        ? screenHeight * 0.85 - keyboardHeight
                        : screenHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          Center(
                            child: Image.asset(
                              AppAssets.appLogo,
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          const Center(
                            child: LoginDemo(),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: (state).emailValue.isEmpty ||
                                        (state).passwordValue.isEmpty
                                    ? null
                                    : () => signInEvent(context),
                                child: state.signInIsLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'Continue',
                                        style: TextStyle(
                                          color: (state).emailValue.isEmpty ||
                                                  (state).passwordValue.isEmpty
                                              ? Colors.grey
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                          fontSize: 25,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
