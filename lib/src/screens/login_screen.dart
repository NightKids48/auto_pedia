part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginIsFailed) {
              Commons().showSnackbar(context, state.message);
            } else if (state is LoginIsSuccess) {
              context.go(routeName.home);
            }
          },
          child: VStack(
            [
              VxBox()
                  .size(context.screenWidth, context.percentHeight * 20)
                  .color(colorName.accentBlue)
                  .bottomRounded(value: 20)
                  .make(),
              'Login'.text.headline5(context).make().p16(),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return VStack(
      [
        TextFieldWidget(
          controller: emailController,
          title: 'Email',
        ),
        8.heightBox,
        TextFieldWidget(
          controller: passController,
          title: 'Password',
          isPassword: true,
        ),
        16.heightBox,
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ButtonWidget(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginUser(
                    email: emailController.text,
                    password: passController.text));
              },
              isLoading: (state is LoginIsLoading) ? true : false,
              text: 'Login',
              color: colorName.accentBlue,
            );
          },
        ),
        16.heightBox,
        'Register here'.text.makeCentered().onTap(() {
          context.go(routeName.register);
        })
      ],
    ).p16();
  }
}
