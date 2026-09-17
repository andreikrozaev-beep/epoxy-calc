import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: EpoxyCalc(), debugShowCheckedModeBanner: false));

class EpoxyCalc extends StatefulWidget {
  const EpoxyCalc({super.key});

  @override
  State<EpoxyCalc> createState() => _EpoxyCalcState();
}

class _EpoxyCalcState extends State<EpoxyCalc> {
  final _aRatioController = TextEditingController(text: '2');
  final _bRatioController = TextEditingController(text: '1');
  final _amountAController = TextEditingController();
  String _result = '';

  void _calculate() {
    final aRatio = double.tryParse(_aRatioController.text) ?? 0;
    final bRatio = double.tryParse(_bRatioController.text) ?? 0;
    final amountA = double.tryParse(_amountAController.text) ?? 0;

    if (aRatio <= 0 || bRatio <= 0 || amountA <= 0) {
      setState(() => _result = 'Введите положительные числа во все поля.');
      return;
    }

    final neededB = amountA * (bRatio / aRatio);
    final total = amountA + neededB;

    setState(() {
      _result =
          '⚠️ Всегда сверяйтесь с инструкцией на упаковке смолы!\n\n'
          'Пропорция: ${aRatio.toInt()}:${bRatio.toInt()}\n'
          'Компонент A: $amountA г\n'
          'Компонент B: ${neededB.toStringAsFixed(2)} г\n'
          'Итого смеси: ${total.toStringAsFixed(2)} г';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор эпоксидки')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(controller: _aRatioController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Часть A (смола)')),
            const SizedBox(height: 8),
            TextField(controller: _bRatioController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Часть B (отвердитель)')),
            const SizedBox(height: 8),
            TextField(controller: _amountAController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Количество A (г)')),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _calculate, child: const Text('Рассчитать')),
            const SizedBox(height: 16),
            Text(_result, style: const TextStyle(fontSize: 15, fontFamily: 'monospace', color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
