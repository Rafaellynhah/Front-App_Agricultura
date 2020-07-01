import 'dart:convert';

import 'package:agriculturapp/helpers/login_delegate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterResourceScreen extends StatefulWidget {
  @override
  _RegisterResourceScreenState createState() => _RegisterResourceScreenState();
}

class _RegisterResourceScreenState extends State<RegisterResourceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _qtd_incialController = TextEditingController();
  final _produtividade_esperadaController = TextEditingController();
  final _dtEntradaController = TextEditingController();


  String dropDownValue = 'Plantação';

  Widget _constroiCadastroNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome do Recurso',
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

  Widget _constroiCadastroQtdInicial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Quantidade inicial',
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
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              hintText: 'Quantidade',
              hintStyle: TextStyle(color: Colors.white54),
            ),
            controller: _qtd_incialController,
          ),
        ),
      ],
    );
  }

  Widget _constroiCadastroTipoRecurso() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tipo de Recurso',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 325,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropDownValue,
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              iconSize: 50,
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                });
              },
              items: <String>['Plantação', 'Animal'].map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _constroiCadastroProdutividadeEsperada() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Produtividade Esperada',
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
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              hintText: 'Produtividade Esperada',
              hintStyle: TextStyle(color: Colors.white54),
            ),
            controller: _produtividade_esperadaController,
          ),
        ),
      ],
    );
  }

  Widget _constroiCadastroiDtEntrada() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Data Entrada',
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
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              hintText: 'Data',
              hintStyle: TextStyle(color: Colors.white54),
            ),
            controller: _dtEntradaController,
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
          cadastrarRecurso().then((success) {
            if (success) {
              showDialog(
                builder: (context) => AlertDialog(
                  title: Text('Cadastrado realizado com sucesso!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _nomeController.text = '';
                        _qtd_incialController.text = '';
                        _produtividade_esperadaController.text = '';
                        _dtEntradaController.text = '';
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

  Future<bool> cadastrarRecurso() async {
    Map<String, dynamic> params = Map<String, dynamic>();

    params["nome"] = _nomeController.text;
    params["qtd_inicial"] = _qtd_incialController.text;
    params["produtividade_esperada"] = _produtividade_esperadaController.text;
    params["dt_entrada"] = _dtEntradaController.text;


    var body = json.encode(params);

    var response = await http.post("http://10.0.2.2:8090/recursos/cadastrar",
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
                    'Cadastrar Recurso',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _constroiCadastroNome(),
                  SizedBox(height: 15.0),
                  _constroiCadastroQtdInicial(),
                  SizedBox(height: 15.0),
                  _constroiCadastroTipoRecurso(),
                  SizedBox(height: 15.0),
                  _constroiCadastroProdutividadeEsperada(),
                  SizedBox(height: 15.0),
                  _constroiCadastroiDtEntrada(),
                  SizedBox(height: 15.0),
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
