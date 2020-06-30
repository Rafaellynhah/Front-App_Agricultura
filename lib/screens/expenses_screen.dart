import 'dart:convert';

import 'package:agriculturapp/helpers/login_delegate.dart';
import 'package:agriculturapp/services/expenses_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExpensesScreen extends StatefulWidget {
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<ExpensesServices> expenses;
  GlobalKey<ScaffoldState> _expensesKey;

  @override
  void initState() {
    super.initState();
    expenses = [];
    _expensesKey = GlobalKey();
    _getExpenses();
  }

  _getExpenses() {
    ExpensesServices.getExpenses().then((_expenses) {
      setState(() {
        expenses = _expenses;
      });
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Mes'),
            ),
            DataColumn(
              label: Text('Quantidade Mensal'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('Media de Gasto'),
            ),
            DataColumn(
              label: Text('Editar / Deletar'),
            ),
          ],
          rows: expenses
              .map(
                (_expenses) => DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 100,
                        child: Text(
                          _expenses.mes.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _expenses.qtdMensal.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _expenses.mediaGasto.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _expensesKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF00E676),
        title: Text('Gastos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => LoginDelegate.mudarParaTelaDeTipodeRecurso(context),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
    );
  }
}
