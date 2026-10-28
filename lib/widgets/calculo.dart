
class Calculo {
  double valorBruto = 0;
  double desconto = 0;
  double valorFinal = 0;
  String categoria = "Cliente Bronze";

  void calcular(
    double valorVeiculo,
    double dias,
    bool seguro,
    bool gps,
    bool motorista,
  ) {
    double diaria = valorVeiculo;

    if (seguro) {
      diaria = diaria + 40;
    }

    if (gps) {
      diaria = diaria + 15;
    }

    valorBruto = diaria * dias;

    if (motorista) {
      valorBruto = valorBruto + 100;
    }

    if (dias >= 15) {
      desconto = valorBruto * 0.10;
    } else if (dias >= 7) {
      desconto = valorBruto * 0.05;
    } else {
      desconto = 0;
    }

    valorFinal = valorBruto - desconto;

    if (valorFinal <= 1000) {
      categoria = "Cliente Bronze";
    } else if (valorFinal <= 3000) {
      categoria = "Cliente Prata";
    } else if (valorFinal <= 5000) {
      categoria = "Cliente Ouro";
    } else {
      categoria = "Cliente Platinum";
    }
  }

  double valorDoVeiculo(String opcao) {
    if (opcao == "Economico") {
      return 120;
    } else if (opcao == "SUV") {
      return 180;
    } else {
      return 300;
    }
  }

  String nomeVeiculo(String opcao) {
    if (opcao == "Economico") {
      return "Carro Econômico";
    } else if (opcao == "SUV") {
      return "SUV";
    } else {
      return "Carro de Luxo";
    }
  }
}
