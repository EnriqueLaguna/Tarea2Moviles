import 'package:flutter/material.dart';

void main() => runApp(MyApp());

  bool esMujer = false;
  bool esHombre = false;

  double IMC = 0.0;
  var alturaController = TextEditingController();
  var pesoController = TextEditingController();

  Color colorIconoAltura = Colors.grey;

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2 - Dispositivos Moviles',
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Colors.greenAccent,
        colorScheme: ColorScheme(primary: Colors.green, primaryVariant: Colors.white, secondary: Colors.green, secondaryVariant: Colors.green, surface: Colors.green, background: Colors.green, error: Colors.green, onPrimary: Colors.white, onSecondary: Colors.green, onSurface: Colors.green, onBackground: Colors.green, onError: Colors.green, brightness: Brightness.light),

        // Define the default font family.
        fontFamily: 'Arial',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: homePage(),
    );
  }
}

class homePage extends StatelessWidget {
  const homePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        backgroundColor: Colors.green,
        actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.delete,
            ),
                onPressed: () {
                  alturaController.clear();
                  pesoController.clear();
                },
          )
        ]
      ),
      body: textoInstruccion()
    );
  }
}

class textoInstruccion extends StatefulWidget {

  textoInstruccion({
    Key? key,
  }) : super(key: key);

  @override
  _textoInstruccion createState() => _textoInstruccion();
}

class _textoInstruccion extends State<textoInstruccion> {
  
  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ingrese sus datos para calcular el IMC")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton( 
                  icon: const Icon(Icons.male),
                  color: esHombre? Colors.blue:Colors.black,
                  onPressed: () {
                    esHombre = !esHombre;
                    if(esMujer){
                      esMujer = !esMujer;
                    }
                    setState(() {});
                    },
                  ),
                IconButton( 
                icon: const Icon(Icons.female),
                color: esMujer? Colors.pinkAccent: Colors.black,
                onPressed: () {
                  esMujer = !esMujer;
                  if(esHombre){
                    esHombre = !esHombre;
                  }
                  setState((){});
                },
                )
              ],
            ),
            ingresarAlturaYPeso(),

          ],
        ),
      ),
    );

  }
}

class ingresarAlturaYPeso extends StatefulWidget{
  const ingresarAlturaYPeso({
    Key? key,
  }) : super(key: key);

  @override
  _ingresarAlturaYPeso createState() => _ingresarAlturaYPeso();
}

class _ingresarAlturaYPeso extends State<ingresarAlturaYPeso>{

  var texto_mujeres = '''
    Tabla del IMC para mujeres

        Edad      IMC ideal 
        16-18       19-24 
        19-24       19-24 
        25-34       20-25 
        35-44       21-26 
        45-54       22-27 
        55-64       23-28 
        65-90       25-30
    ''';

    var text_hombres = '''
    Tabla del IMC para hombres

        Edad      IMC ideal 
        16-17       19-24   
        17-18       20-25   
        19-24       21-26 
        25-34       22-27 
        35-54       23-38 
        55-64       24-29 
        65-90       25-30

    ''';


  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.square_foot, size: 40),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: alturaController,
              decoration: InputDecoration(
                labelText: "Ingresar altura (metros)",
                border: OutlineInputBorder(),
                fillColor: Colors.green
              ),
            ),),
        ),
        ListTile(
          leading: Icon(Icons.monitor_weight, size: 40),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: pesoController,
              decoration: InputDecoration(
                labelText: "Ingresar peso (kg)",
                border: OutlineInputBorder()
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: (){
                double IMC = double.parse(pesoController.text) / (double.parse(alturaController.text) *  double.parse(alturaController.text));
                showDialog<String>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Tu IMC es ${IMC.toStringAsFixed(2)}'),
                    content: Text(esHombre?text_hombres:texto_mujeres),
                    actions: <Widget>[
                      TextButton(onPressed: () => Navigator.pop(context, 'OK'), child: const Text('Ok'))
                    ],
                  )
                );
                setState(() {
                  
                });
              },
              child: Text('Calcular'),
            )
          ],
        )
      ],
    );;
  }
}
