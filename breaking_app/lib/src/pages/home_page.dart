import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    List<String> nav = ['personaje', 'episodios', 'frases', 'asesinatos'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Menu'),
      ),
      drawer: Drawer(
        elevation: 0.1,
        child: ListView.builder(
          itemCount: nav.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${nav[index]}'),
              //metodo que depende el index nos va ayudara a irnos a diferentes paginas
              onTap: () => Navigator.of(context).pushNamed(nav[index]),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondo.jpg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.01)),
          ),
        ),
      ),
    );
  }

  Widget _swiperTarjeta() {
    return Container();
  }
}
