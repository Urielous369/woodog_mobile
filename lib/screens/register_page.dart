import 'package:flutter/material.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/routers/app_routes.dart';
import 'package:woodog_app/screens/login_page.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/color.dart';
import 'package:woodog_app/widgets/input_fileds.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomCompletController = TextEditingController();

  Future<ApiResponse> _registerUser() async {
  setState(() {
    loading = true;
  });

  ApiResponse response = await registerUser(
      nomCompletController.text, emailController.text, passwordController.text, context);

  if (response.message == "Inscription réussie") {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Inscription réussie"), backgroundColor: Colors.green));
    AppRoutes.pushToNextPage(context, const LoginPage());
  } else {
    setState(() {
      loading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.message ?? 'Une erreur est survenue'),
        backgroundColor: Colors.red));
  }

  return response;
}


  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const SizedBox(
                height: 22.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Let’s start here",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Fill in your details to begin",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7A7A7A)),
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InputField(
                        label: "Nom",
                        controller: nomCompletController,
                        bgColor: kInputBgColor,
                        textInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.01,
                      ),
                      InputField(
                        label: "Email",
                        controller: emailController,
                        bgColor: kInputBgColor,
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.01,
                      ),
                      PassWordInput(
                        controller: passwordController,
                        text: "Password",
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.08,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (nomCompletController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                    "Vérifiez que vous avez bien rempli tous les champs"),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              setState(() {
                                loading = true;
                              });
                              await _registerUser();
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF7F00), // Orange pur
                                Color(0xFFFFA726), // Orange plus clair
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfigs.screenHeight! * 0.25,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(
                            text: "By signing in, I agree with ",
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "Terms of use\n",
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "and ",
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 16,
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
