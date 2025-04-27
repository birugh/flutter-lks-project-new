import 'package:flutter/material.dart';
import 'package:lks_project_new/login_screen.dart';

class RegisterScreenStateful extends StatefulWidget {
  const RegisterScreenStateful({super.key});

  @override
  State<RegisterScreenStateful> createState() => _RegisterScreenStatefulState();
}

class _RegisterScreenStatefulState extends State<RegisterScreenStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderApp(context),
              SizedBox(height: 10),
              TitlePage(context),
              SizedBox(height: 20),
              FormPage(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget HeaderApp(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Image.asset('assets/Logo.png', height: 100),
        Text(
          'LKS MART',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3c6283),
          ),
        ),
      ],
    ),
  );
}

Widget TitlePage(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Silahkan isi Data Pribadi anda',
            style: TextStyle(fontSize: 18, color: Color(0xFFb2b2b2)),
          ),
        ],
      ),
    ),
  );
}

Widget FormPage(BuildContext context) {
  final namaLengkapController = TextEditingController();
  final alamatController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Form(
        child: Center(
          child: Column(
            children: [
              TextField(
                context,
                'Nama Lengkap',
                'Nama Lengkap',
                namaLengkapController,
              ),
              TextField(context, 'Alamat', 'Alamat', alamatController),
              TextField(context, 'Username', 'Username', usernameController),
              TextField(context, 'Password', 'Password', passwordController),
              TextField(
                context,
                'Konfirmasi Password',
                'Konfirmasi Password',
                confirmPassController,
              ),
              SizedBox(
                width: 500,
                child: ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: Text('Daftar'),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  //
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreenStateful()));
                },
                child: Text('Sudah punya akun? Daftar di sini!'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget TextField(
  BuildContext context,
  String txtTitle,
  String txtLabel,
  var controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        txtTitle,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: txtLabel,
            labelStyle: TextStyle(fontSize: 14),
          ),
          controller: controller,
        ),
      ),
      SizedBox(height: 10),
    ],
  );
}
