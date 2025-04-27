import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lks_project_new/profile_screen.dart';
import 'package:lks_project_new/register_screen.dart';

class LoginScreenStateful extends StatefulWidget {
  const LoginScreenStateful({super.key});

  @override
  State<LoginScreenStateful> createState() => _LoginScreenStatefulState();
}

class _LoginScreenStatefulState extends State<LoginScreenStateful> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderApp(context),
                  SizedBox(height: 20),
                  TitleApp(context),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fil the username';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                      onPressed: () {
                        // asad
                        LoginLogic();
                      },
                      child: Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreenStateful(),
                        ),
                      );
                    },
                    child: Text('Belum punya akun? Daftar disini!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> LoginLogic() async {
    if (!_formKey.currentState!.validate()) return;

    var headers = {'Accept': 'application/json'};
    var data = FormData.fromMap({
      'username': _usernameController.text,
      'password': _passwordController.text,
    });

    var dio = Dio();
    try {
      var response = await dio.request(
        'http://flaminggo.my.id/api/login',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        String token = response.data['token'] ?? '';
        String foto = response.data['mu_photo'] ?? '';
        String namaLengkap = response.data['user_data']['mu_fullname'] ?? '';
        String phone = response.data['user_data']['mu_phone'] ?? '';
        String alamat = response.data['user_data']['mu_alamat'] ?? '';
        print(json.encode(response.data));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ProfileScreenPage(
                  token: token,
                  foto: foto,
                  namaLengkap: namaLengkap,
                  phone: phone,
                  alamat: alamat,
                ),
          ),
        );
      } else {
        print(response.data['error']);
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Widget HeaderApp(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/Logo.png', height: 100),
          Text(
            'LKS\nMart',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF486b8b),
            ),
          ),
        ],
      ),
    );
  }

  Widget TitleApp(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign In',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Enter your username and password to sign in!',
              style: TextStyle(fontSize: 12, color: Color(0xFFb5b5b5)),
            ),
          ],
        ),
      ),
    );
  }
}
