import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: const Text('Lista de Afazeres'),
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
                          icon: Icon(Icons.edit, color:Colors.blue[600]),
                          tooltip: 'Editar',
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar Ação'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Deseja editar o item?'),
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
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); 
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _tarefas[index].descricao = controladorModal.text; 
                                            Navigator.of(context).pop(); 
                                          });
                                        },
                                        child: const Text('Confirmar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon( Icons.delete_rounded, color: Colors.red[600]),
                          tooltip: '${_tarefas[index].status}',
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmar Ação'),
                                    content: const Text('Deseja excluir o item da lista?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); 
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _tarefas.remove(_tarefas[index]); 
                                            Navigator.of(context).pop(); 
                                          });
                                        },
                                        child: const Text('Confirmar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon( _tarefas[index].status ? Icons.check_box : Icons.check_box_outline_blank, color: _tarefas[index].status ? Colors.green[600] : Colors.black),
                          tooltip: '${_tarefas[index].status}',
                          onPressed: () {
                            setState(() {
                              _tarefas[index].status ? _tarefas[index].status = false : _tarefas[index].status = true;
                            });
                          },
                        )
                      ],
                    ),
                    title: Text(_tarefas[index].descricao),
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
                      fixedSize: WidgetStatePropertyAll(Size(200, 60)),
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
