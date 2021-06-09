import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Personajes'),
              onTap: () {},
            ),
            ListTile(
              title: Text("Episiodos"),
              onTap: () {},
            )
          ],
        ),
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
