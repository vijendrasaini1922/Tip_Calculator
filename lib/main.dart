import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utip/providers/ThemeProvider.dart';
import 'package:utip/providers/TipCalculatorModel.dart';
import 'package:utip/widgets/bill_amount_field.dart';
import 'package:utip/widgets/tip_slider.dart';
import 'constants.dart';
import 'widgets/person_count.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Tipcalculatormodel()),
        ChangeNotifierProvider(create: (context) => Themeprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<Themeprovider>(context);

    return MaterialApp(
      title: 'UTip Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromARGB(255, 59, 22, 225),
      //   ),
      //   useMaterial3: true,
      // ),
      theme: themeModel.currentTheme,
      home: const MyHomePage(title: 'UTip Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = Provider.of<Tipcalculatormodel>(context);
    final themeModel = Provider.of<Themeprovider>(context);

    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    final totalPerPerson = model.totalPerPerson.toStringAsFixed(2);
    final tipAmount = model.tipAmount.toStringAsFixed(2);
    final grandTotal = model.grandTotal.toStringAsFixed(2);
    final totalPerson = model.totalPerson;
    final tipPercentage = model.tipPercentage;
    final errorMsg = model.errorMsg;
    final billAmount = model.billTotal;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarSize,
        backgroundColor: theme.colorScheme.inversePrimary,
        title: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => themeModel.toggleTheme(),
            icon: themeModel.isDarkMode
                ? Icon(Icons.dark_mode_rounded)
                : Icon(Icons.wb_sunny),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text("Total Per Person", style: style),
                    Text(
                      "\$ $totalPerPerson",
                      style: style.copyWith(
                        fontSize: theme.textTheme.displaySmall?.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BillAmountField(
                      billAmount: billAmount.toStringAsFixed(2),
                      onChanged: (value) {
                        model.updateBillTotal(double.parse(value));
                      },
                    ),
                    const SizedBox(height: 16.0),
                    PersonWidget(
                      theme: theme,
                      totalPerson: totalPerson,
                      onDecrement: () {
                        if (totalPerson > 1) {
                          model.updatePersonCount(totalPerson - 1);
                        }
                      },
                      onIncrement: () {
                        model.updatePersonCount(totalPerson + 1);
                      },
                    ),
                    if (errorMsg.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          errorMsg,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip Amount", style: theme.textTheme.titleMedium),
                        Text(
                          "\$ $tipAmount",
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Grand Total", style: theme.textTheme.titleMedium),
                        Text(
                          "\$ $grandTotal",
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${(model.tipPercentage * 100).round()}%",
                      style: theme.textTheme.titleMedium,
                    ),
                    TipSlider(
                      tipPercentage: tipPercentage,
                      onChanged: (value) {
                        model.updateTipPercentage(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
