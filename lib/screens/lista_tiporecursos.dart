import 'dart:convert';

import 'package:agriculturapp/helpers/login_delegate.dart';
import 'package:agriculturapp/services/expenses_services.dart';
import 'package:agriculturapp/services/tiporecurso_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class lista_tiporecurso extends StatefulWidget {
  @override
  _lista_tiporecursoState createState() => _lista_tiporecursoState();
}

class _lista_tiporecursoState extends State<lista_tiporecurso> {
  List<tiporecurso_service> tp_recurso;
  GlobalKey<ScaffoldState> _expensesKey;

  @override
  void initState() {
    super.initState();
    tp_recurso = [];
    _expensesKey = GlobalKey();
    _getExpenses();
  }

  _getExpenses() {
    tiporecurso_service.getExpenses().then((_tp_recurso) {
      setState(() {
        tp_recurso = _tp_recurso;
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
              label: Text('Nome'),
            ),
            DataColumn(
              label: Text('Editar / Deletar'),
            ),
          ],
          rows: tp_recurso
              .map(
                (_tp_recurso) => DataRow(
              cells: [
                DataCell(
                  Container(
                    width: 230,
                    child: Text(
                      _tp_recurso.nome.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
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
        title: Text('Tipo de Recurso'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => LoginDelegate.mudarParaTelaDeTipodeGsto(context),
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
