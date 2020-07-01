import 'dart:convert';

import 'package:agriculturapp/helpers/login_delegate.dart';
import 'package:agriculturapp/services/expenses_services.dart';
import 'package:agriculturapp/services/tipogasto_service.dart';
import 'package:agriculturapp/services/tiporecurso_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class lista_tipogasto extends StatefulWidget {
  @override
  _lista_tipogastoState createState() => _lista_tipogastoState();
}

class _lista_tipogastoState extends State<lista_tipogasto> {
  List<tipogasto_service> tp_gasto;
  GlobalKey<ScaffoldState> _expensesKey;

  @override
  void initState() {
    super.initState();
    tp_gasto = [];
    _expensesKey = GlobalKey();
    _getExpenses();
  }

  _getExpenses() {
    tipogasto_service.getExpenses().then((_tp_gasto) {
      setState(() {
        tp_gasto = _tp_gasto;
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
          rows: tp_gasto
              .map(
                (_tp_gasto) => DataRow(
              cells: [
                DataCell(
                  Container(
                    width: 230,
                    child: Text(
                      _tp_gasto.nome.toString(),
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
        title: const Text('Tipo Gasto'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => LoginDelegate.mudarParaTelaDeCadastrarTipoDeGastos(context),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF00C853),
                    Color(0xFF00E676),
                    Color(0xFF69F0AE),
                    Color(0xFFB9F6CA),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Perfil'),
            ),
            ListTile(
              title: Text('Recursos'),
              onTap: () => LoginDelegate.mudarParaTelaDeRecursos(context),
            ),
            ListTile(
              title: Text('Gastos'),
              onTap: () => LoginDelegate.mudarParaTelaDeGastos(context),
            ),
            ListTile(
              title: Text('Tipo de Recurso'),
              onTap: () => LoginDelegate.mudarParaTelaDeTipodeRecurso(context),
            ),
            ListTile(
              title: Text('Tipo de Gasto'),
              onTap: () => LoginDelegate.mudarParaTelaDeTipodeGsto(context),
            ),
          ],
        ),
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
