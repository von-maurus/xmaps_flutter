import 'package:flutter/material.dart';

class GpsAccessWidget extends StatelessWidget {
  const GpsAccessWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AccessBtn(),
      ),
    );
  }
}

class AccessBtn extends StatelessWidget {
  const AccessBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("GPS access its necessary"),
        MaterialButton(
          splashColor: Colors.transparent,
          color: Colors.black,
          shape: const StadiumBorder(),
          child: const Text(
            "Grant Access",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class EnableGPSWidget extends StatelessWidget {
  const EnableGPSWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Must enable GPS access',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
