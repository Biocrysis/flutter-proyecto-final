import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad Personajes'),
      ),
      body: Container(
        child: Column(
          children: [_swiperTarjeta()],
        ),
      ),
    );
  }
}

Widget _swiperTarjeta() {
  return Container(
    child: Text("el swipper"),
  );
}
