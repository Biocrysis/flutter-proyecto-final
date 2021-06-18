// @dart=2.9

import 'package:breaking_app/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class ScrollDesign extends StatelessWidget {
  const ScrollDesign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //se crea el degradado
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.5, 0.6],
        colors: [
          Colors.grey[900],
          Colors.green[900],
        ],
      )),

      child: PageView(
        //fisica para una animacion de rebote
        physics: BouncingScrollPhysics(),
        //escroll HACIA ABAJO
        scrollDirection: Axis.vertical,
        children: [Page1(), HomePage()],
      ),
    ));
  }
}

final now = new DateTime.now();
String g = ('${now.year}/ ${now.month}/ ${now.day}');

class Page1 extends StatelessWidget {
  const Page1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Background(), MainContent()],
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white);
    //safe area evita que los widgets lleguena a tocar los extremos de la pantalla
    return SafeArea(
      //boton, top, puedes acticar o descativar el safe area
      bottom: false,
      top: false,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Text(
            "$g",
            style: textStyle,
          ),
          //Text("Martes",style: textStyle,),
          //expande los widets hasta el maximo d ela pantalla
          Expanded(child: Container()),
          Expanded(child: Container()),
          Expanded(child: Container()),
          Text('Breaking App', style: textStyle),
          Image.asset(
            'assets/flecha.gif',
            scale: 2,
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Color(0xff50c2dd),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Image(
          image: AssetImage(
            'assets/portada.jpg',
          ),
          fit: BoxFit.contain,
        ));
  }
}
