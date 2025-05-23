import 'package:flutter/material.dart';
import '../models/pessoa.dart';
import '../models/turma.dart';

class CoordenadorHomeScreen extends StatefulWidget {
  @override
  _CoordenadorHomeScreenState createState() => _CoordenadorHomeScreenState();
}

class _CoordenadorHomeScreenState extends State<CoordenadorHomeScreen> {
  List<Pessoa> professores = [Pessoa('João Silva'), Pessoa('Maria Oliveira')];
  List<Pessoa> alunos = [Pessoa('Ana Paula'), Pessoa('Carlos Souza')];
  List<Turma> turmas = [Turma('Turma A'), Turma('Turma B')];

  void _adicionarPessoa(List<Pessoa> lista, String titulo) {
    showDialog(
      context: context,
      builder: (context) {
        String nome = '';
        return AlertDialog(
          title: Text('Adicionar $titulo'),
          content: TextField(
            onChanged: (value) => nome = value,
            decoration: InputDecoration(hintText: 'Digite o nome'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nome.isNotEmpty) {
                  setState(() => lista.add(Pessoa(nome)));
                }
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _editarPessoa(List<Pessoa> lista, int index) {
    showDialog(
      context: context,
      builder: (context) {
        String nome = lista[index].nome;
        TextEditingController controller = TextEditingController(text: nome);
        return AlertDialog(
          title: Text('Editar'),
          content: TextField(
            controller: controller,
            onChanged: (value) => nome = value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => lista[index].nome = nome);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirPessoa(List<Pessoa> lista, int index) {
    setState(() => lista.removeAt(index));
  }

  void _adicionarTurma() {
    showDialog(
      context: context,
      builder: (context) {
        String nome = '';
        return AlertDialog(
          title: Text('Adicionar Turma'),
          content: TextField(
            onChanged: (value) => nome = value,
            decoration: InputDecoration(hintText: 'Digite o nome da turma'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nome.isNotEmpty) {
                  setState(() => turmas.add(Turma(nome)));
                }
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _editarTurma(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String nome = turmas[index].nome;
        TextEditingController controller = TextEditingController(text: nome);
        return AlertDialog(
          title: Text('Editar Turma'),
          content: TextField(
            controller: controller,
            onChanged: (value) => nome = value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => turmas[index].nome = nome);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirTurma(int index) {
    setState(() => turmas.removeAt(index));
  }

  Widget _buildPessoaSection(String titulo, List<Pessoa> lista) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titulo,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _adicionarPessoa(lista, titulo),
                ),
              ],
            ),
            ...List.generate(lista.length, (index) {
              return ListTile(
                title: Text(lista[index].nome),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editarPessoa(lista, index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _excluirPessoa(lista, index),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTurmaSection() {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Turmas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _adicionarTurma),
              ],
            ),
            ...List.generate(turmas.length, (index) {
              return ListTile(
                title: Text(turmas[index].nome),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editarTurma(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _excluirTurma(index),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela do Coordenador')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPessoaSection('Professores', professores),
            _buildPessoaSection('Alunos', alunos),
            _buildTurmaSection(),
          ],
        ),
      ),
    );
  }
}
