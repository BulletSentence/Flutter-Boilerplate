
import '../models/token.dart';

class TokenRepository {
  static List<Token> tabela = [
    Token(
      icone: 'assets/focus_fire.png' ,
      nome: 'FOCUS FIRE',
      sigla: 'FCFR',
      preco: 800.00,
    ),
    Token(
      icone: 'assets/paintitblack.png',
      nome: 'PAINT IT BLACK',
      sigla: 'PIBK',
      preco: 900.00,
    ),
    Token(
      icone: 'assets/slowandsteady.png',
      nome: 'SLOW AND STEADY',
      sigla: 'SLST',
      preco: 300,
    ),
    Token(
      icone: 'assets/quiteinspiration.png',
      nome: 'QUITE AN INSPIRATION',
      sigla: 'QAIP',
      preco: 6.32,
    ),
  ];
}
