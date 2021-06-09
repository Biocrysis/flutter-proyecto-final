import 'package:flutter/material.dart';

import 'package:breaking_app/src/pages/personaje_detalle.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'personaje': (BuildContext context) => PersonajeDetalle(),
  };
}
