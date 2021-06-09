import 'package:breaking_app/src/provider/frases_provider.dart';
import 'package:breaking_app/src/provider/muertos_provider.dart';
import 'package:breaking_app/src/provider/personaje_provider.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'personaje': (BuildContext context) => PersonajeProvider(),
    'frases': (BuildContext context) => FrasesProvider(),
    'muertos': (BuildContext context) => MuertosProvider()
  };
}
