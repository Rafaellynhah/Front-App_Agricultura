import 'dart:convert';

import 'package:agriculturapp/helpers/login_delegate.dart';
import 'package:agriculturapp/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List<ResourseServices> resources;
  GlobalKey<ScaffoldState> _resourcesKey;

  @override
  void initState() {
    super.initState();
    resources = [];
    _resourcesKey = GlobalKey();
    _getResources();
  }

  _getResources() {
    ResourseServices.getResources().then((_resources) {
      setState(() {
        resources = _resources;
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
              label: Text('Tipo'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('Quantidade Inicial'),
            ),
            DataColumn(
              label: Text('Quantidade Final'),
            ),
            DataColumn(
              label: Text('Produtividade'),
            ),
            DataColumn(
              label: Text('Produtividade Esperada'),
            ),
            DataColumn(
              label: Text('Problema'),
            ),
            DataColumn(
              label: Text('Editar / Deletar'),
            ),
          ],
          rows: resources
              .map(
                (_resources) => DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 100,
                        child: Text(
                          _resources.nome.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _resources.tipoRecurso.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _resources.qtdInicial.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _resources.qtdFinal.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _resources.produtividade.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _resources.produtividadeEsperada.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        _resources.problema.toString(),
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
      key: _resourcesKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () =>
              LoginDelegate.mudarParaTelaDeCadastrarRecurso(context),
        ),
        backgroundColor: Color(0xFF00E676),
        title: Text('Recursos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.forward,
            ),
            onPressed: () => LoginDelegate.mudarParaTelaDeGastos(context),
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
