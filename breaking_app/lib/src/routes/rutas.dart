import 'package:flutter/cupertino.dart';

import 'package:breaking_app/src/pages/home_page.dart';
import 'package:breaking_app/src/pages/personaje_detalle.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'Personaje': (BuildContext context) => PersonajeDetalle(),
  };
}
