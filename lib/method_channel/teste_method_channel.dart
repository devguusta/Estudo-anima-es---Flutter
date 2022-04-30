import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TesteMethodChannel extends StatefulWidget {
  const TesteMethodChannel({Key? key}) : super(key: key);

  @override
  State<TesteMethodChannel> createState() => _TesteMethodChannelState();
}

class _TesteMethodChannelState extends State<TesteMethodChannel> {
  String _batteryLevel = 'Unknown battery level.';
  static const platform = MethodChannel('samples.flutter.dev/battery');

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _userEmail = 'User not found';
  String _userPassword = 'User not found';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBatteryLevel();
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_batteryLevel),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_userEmail),
          const SizedBox(
            height: 16,
          ),
          Text(_userPassword),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                late String userName;
                late String userPassword;
                try {
                  final Map result = await platform.invokeMethod(
                    'handleInput',
                    {
                      'email': _emailController.text,
                      'password': _passwordController.text,
                    },
                  );
                  userName = result["email"];
                  userPassword = result["password"];
                } catch (e) {
                  print(e);
                  userName = e.toString();
                }
                setState(() {
                  _userEmail = userName;
                  _userPassword = userPassword;
                });
              },
              child: const Text("Chamar o nativo"))
        ],
      ),
    );
  }
}
