import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String title;
  final String subtitle;
  final double amount;
  final String date;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });
}

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  List<Transaction> allTransactions = [
    Transaction(
        title: 'Transferencia a Tu Meta',
        subtitle: 'Solicitud 0429214\nBanco Guayaquil\nCarro de Angel',
        amount: -5.00,
        date: '2025-06-13'),//"13/06/2025"
    Transaction(
        title: 'Transferencia a Tu Meta',
        subtitle: 'Solicitud 0429214\nBanco Guayaquil\nCarro de Angel',
        amount: -10.00,
        date: '2025-06-13'),
    Transaction(
        title: 'Mision de Igls. Pentecostales',
        subtitle: 'Transferencia a Banco Pichincha',
        amount: -65.00,
        date: '2025-06-12'),
    Transaction(
        title: 'Caj/auto.ret.',
        subtitle: '514440xxxxxx1007',
        amount: -80.00,
        date: '2025-06-12'),
    Transaction(
        title: 'Comisión + IVA',
        subtitle: 'Banco Pichincha\nDiezmos',
        amount: -0.41,
        date: '2025-06-12'),
    Transaction(
        title: 'Pago',
        subtitle: 'Banco Pichincha',
        amount: 10.25,
        date: '2025-06-11'),
    Transaction(
        title: 'Pago 2',
        subtitle: 'Banco Pichincha',
        amount: 100.25,
        date: '2025-06-10'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<Transaction> filteredTransactions = [];

    Map<String, List<Transaction>> groupedTransactions = {};

    if(searchQuery.isNotEmpty){
      filteredTransactions = allTransactions
        .where((tx) => tx.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

      for (var tx in filteredTransactions) {
        groupedTransactions.putIfAbsent(tx.date, () => []).add(tx);
      }
    }
    else{
      for (var tx in allTransactions) {
        groupedTransactions.putIfAbsent(tx.date, () => []).add(tx);
      }
    }
    
    return Container(
      width: size.width,
      height: size.height * 0.82,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: groupedTransactions.entries.map((entry) {
                
                String descDia = '';
                String descMes = '';
                String descAnio = '';

                DateTime date = DateTime.parse(entry.key);
                //String formattedDate = DateFormat('dd/MM/yyyy').format(date);

                if(date.day == DateTime.now().day){
                  descDia = 'Hoy';
                }
                else{
                  if(date.day == DateTime.now().day - 1){
                    descDia = 'Ayer';
                  }
                  else{
                    descDia = DateFormat('EEEE', 'es_ES').format(date);
                    descDia = capitalizar_PrimeraLetra(descDia);
                  }
                }

                descMes = DateFormat('MMMM', 'es_ES').format(date);
                descMes = capitalizar_PrimeraLetra(descMes);
                descAnio = '${date.year}';                  

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    */
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$descDia ${date.day}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$descMes $descAnio',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ...entry.value.map((tx) => Card(
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Text(tx.title),
                            subtitle: Text(tx.subtitle),
                            trailing: Text(
                              '${tx.amount < 0 ? '-' : ''} \$${tx.amount.abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

String capitalizar_PrimeraLetra(String texto) {
  if (texto.isEmpty) return texto;
  return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
}