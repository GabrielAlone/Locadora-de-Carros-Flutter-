import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  bool ligado = false;
  bool seguro = false;
  bool gps = false;
  double valor = 1;
  String opcao = "Economico";

  void clicarIcone() {
    print("Clicou no coração");
  }

  void alterarSwitch(bool novoValor) {
    setState(() {
      ligado = novoValor;
      print(novoValor);
    });
  }

  void alterarSeguro(bool novoValor) {
    setState(() {
      seguro = novoValor;
      print(novoValor);
    });
  }

  void alterarGps(bool novoValor) {
    setState(() {
      gps = novoValor;
      print(novoValor);
    });
  }

  void alterarSlider(double novoValor) {
    setState(() {
      valor = novoValor;
      print(novoValor);
    });
  }

  void alterarOpcao(String novaOpcao) {
    setState(() {
      opcao = novaOpcao;
      print(novaOpcao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        // SEGMENTED BUTTON

        appBar: AppBar(
          title: Text("Locadora de Carros"),
          backgroundColor: Color.fromARGB(255, 110, 110, 192),
        ),

        body: Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Escolha de Carro"),
              SizedBox(height: 10),

              SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: "Economico",
                    label: Text("Carro Econômico"),
                  ),

                  ButtonSegment(
                    value: "SUV",
                    label: Text("SUV"),
                  ),

                  ButtonSegment(
                    value: "C",
                    label: Text("Carro de Luxo"),
                  ),
                ],

                selected: {opcao},

                onSelectionChanged: (novaSelecao) {
                  alterarOpcao(novaSelecao.first);
                },
              ),

              SizedBox(height: 20),

              // CHECKBOX

              Row(
                children: [
                  Checkbox(
                    value: seguro,
                    onChanged: (valor) {
                      alterarSeguro(valor!);
                    },
                  ),

                  Text("Seguro Completo (R\$40 por dia)"),
                ],
              ),

              // CHECKBOX

              Row(
                children: [
                  Checkbox(
                    value: gps,
                    onChanged: (valor) {
                      alterarGps(valor!);
                    },
                  ),

                  Text("GPS (R\$40 por dia)"),
                ],
              ),

              SizedBox(height: 20),

              // SWITCH

              Row(
                children: [
                  Switch(
                    value: ligado,

                    onChanged: (valor) {
                      alterarSwitch(valor);
                    },
                  ),

                  Text("Motorista Adicional (R\$100)"),
                ],
              ),

              SizedBox(height: 20),

              // SLIDER

              Text("Quantidade de Dias: ${valor.toInt()}"),

              Slider(
                min: 1,
                max: 30,
                value: valor,

                onChanged: (novoValor) {
                  alterarSlider(novoValor);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}