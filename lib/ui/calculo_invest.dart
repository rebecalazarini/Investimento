import 'dart:math';

class InvestimentoResultado {
  final double semJuros;
  final double comJuros;

  InvestimentoResultado(this.semJuros, this.comJuros);
}

class InvestimentoHelper {
  static InvestimentoResultado calcular({
    required double aporteMensal,
    required int meses,
    required double taxaJurosMensalPercentual,
  }) {
    double i = taxaJurosMensalPercentual / 100;

    double semJuros = aporteMensal * meses;

    double comJuros = i > 0
        ? aporteMensal * (pow(1 + i, meses) - 1) / i
        : semJuros;

    return InvestimentoResultado(semJuros, comJuros);
  }
}