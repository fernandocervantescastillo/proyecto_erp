import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proyecto_erp/pages/NewProducto.dart';
import 'package:proyecto_erp/pages/producto/NewProducto.dart';
import 'package:proyecto_erp/pages/proveedor/NewProveedor.dart';
import 'package:proyecto_erp/pages/proveedor/ProveedoresPage.dart';
import 'package:proyecto_erp/pages/usuario/UsuarioLogin.dart';
import 'package:proyecto_erp/preferencias_usuario.dart';
import 'package:proyecto_erp/provider.dart';
import 'botones_page.dart';


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
  //..customAnimation = CustomAnimation();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    String token = prefs.getToken();
    print("Token: " + token);
    String init;
    if(token == "")
      init = 'login';
    else
      init = 'botones';

    return Provider1(


      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: init,
        routes: {
          'botones'     : ( BuildContext context ) => BotonesPage(),
          'login'     : ( BuildContext context ) => LoginPage(),
          'newProductoPage'     : ( BuildContext context ) => NewProductoPage(),
          'newProveedorPage'     : ( BuildContext context ) => NewProveedorPage(),
          'proveedoresPage'     : ( BuildContext context ) => ProveedoresPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
        builder: (BuildContext context, Widget child) {
          /// make sure that loading can be displayed in front of all other widgets
          return FlutterEasyLoading(child: child);
        },
      ),
    );

  }
}
