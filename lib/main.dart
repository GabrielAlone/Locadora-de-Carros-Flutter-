import 'package:flutter/material.dart';
import 'widgets/botao.dart';
import 'widgets/calculo.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final GlobalKey<NavigatorState> chaveNavegacao =
      GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldMessengerState> chaveMensagem =
      GlobalKey<ScaffoldMessengerState>();

  bool ligado = false;
  bool seguro = false;
  bool gps = false;

  double valor = 1;
  double valorVeiculo = 120;

  String opcao = "Economico";

  Calculo calculo = Calculo();

  @override
  void initState() {
    super.initState();
    atualizarCalculo();
  }

  void atualizarCalculo() {
    calculo.calcular(valorVeiculo, valor, seguro, gps, ligado);
  }

  void alterarSwitch(bool novoValor) {
    setState(() {
      ligado = novoValor;
      atualizarCalculo();
    });
  }

  void alterarSeguro(bool novoValor) {
    setState(() {
      seguro = novoValor;
      atualizarCalculo();
    });
  }

  void alterarGps(bool novoValor) {
    setState(() {
      gps = novoValor;
      atualizarCalculo();
    });
  }

  void alterarSlider(double novoValor) {
    setState(() {
      valor = novoValor;
      atualizarCalculo();
    });
  }

  void alterarOpcao(String novaOpcao) {
    setState(() {
      opcao = novaOpcao;
      valorVeiculo = calculo.valorDoVeiculo(opcao);
      atualizarCalculo();
    });
  }

  void mostrarAlert(String mensagem) {
    final contexto = chaveNavegacao.currentContext;

    if (contexto == null) return;

    showDialog(
      context: contexto,
      builder: (contextoDialog) {
        return AlertDialog(
          title: Text("Confirmar Reserva"),
          content: SingleChildScrollView(
            child: Text(mensagem),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextoDialog);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextoDialog);

                chaveMensagem.currentState?.showSnackBar(
                  SnackBar(
                    content: Text("Reserva realizada com sucesso!"),
                  ),
                );
              },
              child: Text("Confirmar Reserva"),
            ),
          ],
        );
      },
    );
  }

  void finalizarReserva() {
    atualizarCalculo();

    mostrarAlert(
      "Veículo: ${calculo.nomeVeiculo(opcao)}\n"
      "Dias: ${valor.toInt()}\n"
      "Seguro: ${seguro ? 'Sim' : 'Não'}\n"
      "GPS: ${gps ? 'Sim' : 'Não'}\n"
      "Motorista adicional: ${ligado ? 'Sim' : 'Não'}\n\n"
      "Valor bruto: R\$ ${calculo.valorBruto.toStringAsFixed(2)}\n"
      "Desconto: R\$ ${calculo.desconto.toStringAsFixed(2)}\n"
      "Valor final: R\$ ${calculo.valorFinal.toStringAsFixed(2)}\n"
      "Categoria: ${calculo.categoria}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: chaveNavegacao,
      scaffoldMessengerKey: chaveMensagem,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Locadora de Carros"),
          backgroundColor: Color.fromARGB(255, 110, 110, 192),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                      value: "Luxo",
                      label: Text("Carro de Luxo"),
                    ),
                  ],
                  selected: {opcao},
                  onSelectionChanged: (novaSelecao) {
                    alterarOpcao(novaSelecao.first);
                  },
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: seguro,
                      onChanged: (novoValor) {
                        alterarSeguro(novoValor!);
                      },
                    ),
                    Expanded(
                      child: Text("Seguro Completo (R\$ 40 por dia)"),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Checkbox(
                      value: gps,
                      onChanged: (novoValor) {
                        alterarGps(novoValor!);
                      },
                    ),
                    Expanded(
                      child: Text("GPS (R\$ 15 por dia)"),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Switch(
                      value: ligado,
                      onChanged: alterarSwitch,
                    ),
                    Expanded(
                      child: Text("Motorista Adicional (R\$ 100)"),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Text("Quantidade de Dias: ${valor.toInt()}"),

                Slider(
                  min: 1,
                  max: 30,
                  divisions: 29,
                  value: valor,
                  onChanged: alterarSlider,
                ),

                SizedBox(height: 20),
                Divider(),

                Text(
                  "Resumo da Locação",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text("Veículo: ${calculo.nomeVeiculo(opcao)}"),
                Text("Dias: ${valor.toInt()}"),
                Text("Seguro: ${seguro ? 'Sim' : 'Não'}"),
                Text("GPS: ${gps ? 'Sim' : 'Não'}"),
                Text("Motorista adicional: ${ligado ? 'Sim' : 'Não'}"),

                SizedBox(height: 10),

                Text(
                  "Valor bruto: R\$ ${calculo.valorBruto.toStringAsFixed(2)}",
                ),
                Text(
                  "Desconto: R\$ ${calculo.desconto.toStringAsFixed(2)}",
                ),
                Text(
                  "Valor final: R\$ ${calculo.valorFinal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Categoria: ${calculo.categoria}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                meuBotao(
                  "Finalizar Reserva",
                  Color.fromARGB(255, 110, 110, 192),
                  finalizarReserva,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}