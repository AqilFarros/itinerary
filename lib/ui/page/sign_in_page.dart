part of 'page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/sign-up');
                      },
                      child: Text(
                        "Haven't has an account?",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: AppTheme.defaultMargin),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      child: Text(
                        "Sign in",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(color: Colors.white),
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
