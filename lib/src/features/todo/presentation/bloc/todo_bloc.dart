import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webreinvent_todo/src/core/constants/shared_pref_constants.dart';
import 'package:webreinvent_todo/src/core/constants/string_constants.dart';
import 'package:webreinvent_todo/src/features/todo/data/model/todo_model.dart';
import 'package:webreinvent_todo/src/features/todo/domain/entities/todo_entity.dart';
import 'package:webreinvent_todo/src/features/todo/domain/usecases/todo_usecase.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoUseCase todoUseCase;

  TodoBloc({required this.todoUseCase}) : super(TodoState(tasks: [])) {
    on<LoadTasks>((event, emit) async {
      emit(state.copyWith(status: TodoStatus.loading));
      await _loading();
      final task = await todoUseCase.loadTask(keyName: SharedPrefConstants.task);
      emit(state.copyWith(tasks: task, status: TodoStatus.fetched));
    });

    on<AddTask>((event, emit) async {
      emit(state.copyWith(status: TodoStatus.loading));
      await _loading();
      if (event.title.trim().isEmpty) {
        emit(state.copyWith(errorMessage: StringConstants.taskCantBeEmpty, status: TodoStatus.failure));
      } else {
        final task = await todoUseCase.saveTask(
          keyName: SharedPrefConstants.task,
          data: List<TodoEntity>.from(state.tasks)
            ..add(
              TodoModel(false, event.title),
            ),
        );
        if (task) {
          final data = await todoUseCase.loadTask(keyName: SharedPrefConstants.task);
          emit(state.copyWith(tasks: data, status: TodoStatus.success, errorMessage: null));
        } else {
          emit(state.copyWith(
            tasks: state.tasks,
            status: TodoStatus.failure,
            errorMessage: StringConstants.somethingWentWrong,
          ));
        }
      }
    });

    on<ToggleTaskStatus>((event, emit) async {
      final data =
          await todoUseCase.updateTask(keyName: SharedPrefConstants.task, data: state.tasks, index: event.index);
      final task = await todoUseCase.loadTask(keyName: SharedPrefConstants.task);

      if (data) {
        if (task[event.index].isCompleted) {
          emit(state.copyWith(tasks: task, status: TodoStatus.completed));
        } else {
          emit(state.copyWith(tasks: task, status: TodoStatus.incomplete));
        }
      } else {
        emit(state.copyWith(
          tasks: state.tasks,
          status: TodoStatus.failure,
          errorMessage: StringConstants.somethingWentWrong,
        ));
      }
    });
  }

  Future<void> _loading() async {
    await Future.delayed(Duration(milliseconds: 300));
  }
}
