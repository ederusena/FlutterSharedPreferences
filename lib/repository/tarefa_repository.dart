import 'package:trilhapp/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionar(Tarefa tarefa) async {
    await Future.delayed(const Duration(microseconds: 200));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<Tarefa>> getTarefas() async {
    await Future.delayed(const Duration(microseconds: 200));
    return _tarefas;
  }

  // listar não concluídas
  Future<List<Tarefa>> getTarefasNaoConcluidas() async {
    await Future.delayed(const Duration(microseconds: 200));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }
}
