import 'package:breaking_app/src/provider/personaje_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    List<String> nav = ['personaje', 'episodios', 'frases', 'asesinatos'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: Drawer(
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
        child: Column(
          children: [_swiperTarjeta()],
        ),
      ),
    );
  }

  Widget _swiperTarjeta() {
    return Container();
  }
}
