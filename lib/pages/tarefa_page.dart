import 'package:flutter/material.dart';
import 'package:trilhapp/model/tarefa.dart';
import 'package:trilhapp/repository/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
  var apenasNaoConcluidas = false;
  TextEditingController descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluidas) {
      _tarefas = await tarefaRepository.getTarefasNaoConcluidas();
    } else {
      _tarefas = await tarefaRepository.getTarefas();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar Tarefa"),
                  content: TextField(
                    controller: descricaoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite a tarefa'),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          await tarefaRepository.adicionar(
                              Tarefa(descricaoController.text, false));

                          setState(() {});

                          descricaoController.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Adicionar")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Apenas não concluido",
                    style: TextStyle(fontSize: 16)),
                Switch(
                    value: apenasNaoConcluidas,
                    onChanged: (bool value) {
                      setState(() {
                        apenasNaoConcluidas = value;
                        obterTarefas();
                      });
                    })
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    key: Key(tarefa.id),
                    onDismissed: (DismissDirection direction) async {
                      await tarefaRepository.remove(tarefa.id);
                      obterTarefas();
                    }, // Remove the item from the data source.
                    child: ListTile(
                        title: Text(tarefa.descricao),
                        trailing: Switch(
                          value: tarefa.concluido,
                          onChanged: (bool value) async {
                            await tarefaRepository.alterar(tarefa.id, value);
                            setState(() {});
                          },
                        )),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
