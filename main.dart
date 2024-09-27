import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController controlador = TextEditingController();
  final TextEditingController controladorModal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 8, 15),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 120, 111, 82),
          title: Center(
            child: Text('Lista de Afazeres',
                style: GoogleFonts.montserrat(fontSize: 27)),
          ),
          foregroundColor: const Color.fromARGB(255, 239, 233, 244),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[600]),
                          tooltip: 'Editar',
                          onPressed: () {
                            setState(() {
                              showDialog(
                                barrierColor: const Color.fromARGB(52, 0, 0, 0),
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar Ação',
                                        textAlign: TextAlign.center),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Deseja editar o item?',
                                            textAlign: TextAlign.center),
                                        TextField(
                                          controller: controladorModal,
                                          decoration: const InputDecoration(
                                            hintText: 'Descrição',
                                            border: OutlineInputBorder(),
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (controladorModal
                                                  .text.isEmpty) {
                                                return;
                                              }
                                              setState(() {
                                                _tarefas[index].descricao =
                                                    controladorModal.text;
                                                controladorModal.clear();
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: const Text('Confirmar'),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_rounded,
                              color: Colors.red[600]),
                          tooltip: 'Excluir',
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar Ação',
                                        textAlign: TextAlign.center),
                                    content: const Text(
                                        'Deseja excluir o item da lista?',
                                        textAlign: TextAlign.center),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _tarefas
                                                    .remove(_tarefas[index]);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: const Text('Confirmar'),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                              _tarefas[index].status
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: _tarefas[index].status
                                  ? Colors.green[600]
                                  : Colors.brown[800]),
                          tooltip:
                              _tarefas[index].status ? 'Feito' : 'Não feito',
                          onPressed: () {
                            setState(() {
                              _tarefas[index].status
                                  ? _tarefas[index].status = false
                                  : _tarefas[index].status = true;
                            });
                          },
                        )
                      ],
                    ),
                    title: Text(_tarefas[index].descricao,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 239, 233, 244))),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 239, 233, 244)),
                      controller: controlador,
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(200, 60)),
                    ),
                    child: const Text('Adicionar Tarefa'),
                    onPressed: () {
                      if (controlador.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        _tarefas.add(
                          Tarefa(
                            descricao: controlador.text,
                            status: false,
                          ),
                        );
                        controlador.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}
