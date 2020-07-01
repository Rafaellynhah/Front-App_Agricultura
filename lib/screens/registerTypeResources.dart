import 'dart:convert';

import 'package:agriculturapp/helpers/login_delegate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterTypeScreenResources extends StatefulWidget {
  @override
  _RegisterTypeScreenResourcesState createState() => _RegisterTypeScreenResourcesState();
}

class _RegisterTypeScreenResourcesState extends State<RegisterTypeScreenResources> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  Widget _constroiCadastroNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                ),
              ]),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              hintText: 'Nome',
              hintStyle: TextStyle(color: Colors.white54),
            ),
            controller: _nomeController,
          ),
        ),
      ],
    );
  }

  Widget _btnCadastrar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          cadastrarTipoRecurso().then((success) {
            if (success) {
              showDialog(
                builder: (context) => AlertDialog(
                  title: Text('Cadastrado realizado com sucesso!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _nomeController.text = '';
                      },
                      child: Text('OK'),
                    )
                  ],
                ),
                context: context,
              );
              return;
            } else {
              showDialog(
                builder: (context) => AlertDialog(
                  title: Text('Erro ao Cadastrar!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    )
                  ],
                ),
                context: context,
              );
              return;
            }
          });
        },
        padding: EdgeInsets.all(15.0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.white,
        child: Text(
          'CADASTRAR',
          style: TextStyle(
            color: Color(0xFF00C853),
            letterSpacing: 2.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<bool> cadastrarTipoRecurso() async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params["nome"] = _nomeController.text;

    var body = json.encode(params);

    var response = await http.post("http://10.0.2.2:8090/tiporecurso/cadastrar",
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
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
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Cadastrar Tipo de Recurso',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _constroiCadastroNome(),
                  _btnCadastrar(),
                  SizedBox(height: 20.0),
                  //_botaoRegistrar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
