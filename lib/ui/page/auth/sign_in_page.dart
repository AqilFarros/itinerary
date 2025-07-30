part of '../page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // final authService = AuthService();
  bool isLoading = false;

  void signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        // await authService.signIn(
        //   email: emailController.text,
        //   password: passwordController.text,
        // );

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.white),
            ),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(AppTheme.defaultMargin * 2),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: AppTheme.defaultMargin),
                Text(
                  "Sign in to continue",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: AppTheme.defaultMargin * 2),
                InputField(
                  controller: emailController,
                  hint: "Enter your email",
                  label: "Email",
                  textInputType: TextInputType.emailAddress,
                  validator: InputValidator.validateEmail,
                ),
                SizedBox(height: AppTheme.defaultMargin),
                InputField(
                  controller: passwordController,
                  label: "Password",
                  hint: "Enter your password",
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: InputValidator.validatePassword,
                ),
                SizedBox(height: AppTheme.defaultMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: isLoading
                      ? [
                          CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ]
                      : [
                          GestureDetector(
                            onTap: () {
                              signIn();
                            },
                            child: Text(
                              "Haven't has an account?",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                          SizedBox(width: AppTheme.defaultMargin),
                          ElevatedButton(
                            onPressed: () {
                              signIn();
                            },
                            child: Text(
                              "Sign in",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
