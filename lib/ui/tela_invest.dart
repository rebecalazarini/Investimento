import 'package:flutter/material.dart';
import 'calculo_invest.dart';

class TelaInvestimento extends StatefulWidget {
  @override
  _TelaInvestimentoState createState() => _TelaInvestimentoState();
}

class _TelaInvestimentoState extends State<TelaInvestimento> {
  final aporteCtrl = TextEditingController();
  final mesesCtrl = TextEditingController();
  final jurosCtrl = TextEditingController();

  InvestimentoResultado? resultado;

  String formatarReais(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void calcular() {
    final aporte = double.tryParse(aporteCtrl.text) ?? 0;
    final meses = int.tryParse(mesesCtrl.text) ?? 0;
    final juros = double.tryParse(jurosCtrl.text) ?? 0;

    setState(() {
      resultado = InvestimentoHelper.calcular(
        aporteMensal: aporte,
        meses: meses,
        taxaJurosMensalPercentual: juros,
      );
    });
  }

  @override
  void dispose() {
    aporteCtrl.dispose();
    mesesCtrl.dispose();
    jurosCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simulador de Investimento')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: aporteCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Aporte Mensal (R\$)'),
            ),
            TextField(
              controller: mesesCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de Meses'),
            ),
            TextField(
              controller: jurosCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Taxa de Juros Mensal (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: calcular, child: Text('Calcular')),
            SizedBox(height: 20),
            if (resultado != null) ...[
              Text('Montante Sem Juros: ${formatarReais(resultado!.semJuros)}'),
              Text('Montante Com Juros: ${formatarReais(resultado!.comJuros)}'),
            ]
          ],
        ),
      ),
    );
  }
}
