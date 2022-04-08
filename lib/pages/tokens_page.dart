import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/token.dart';
import '../repositories/token_repository.dart';
import 'token_details_page.dart';

class TokenPage extends StatefulWidget {
  TokenPage({Key? key}) : super(key: key);

  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  final tabela = TokenRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'en_US', name: '\$');
  List<Token> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text('Database'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionadas'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87), toolbarTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).bodyText2, titleTextStyle: const TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).headline6,
      );
    }
  }

  mostrarDetalhes(Token token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TokenDetailPage(token: token),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int token) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[token]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(tabela[token].icone),
                    height: 80,
                  ),
            title: Text(
              tabela[token].nome,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tabela[token].preco),
              style: TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[token]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[token]))
                    ? selecionadas.remove(tabela[token])
                    : selecionadas.add(tabela[token]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[token]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(Icons.star),
              label: Text(
                'SAVE',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
