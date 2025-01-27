import 'package:bloc/bloc.dart';
import 'package:bookreview/src/common/enum/common_state_status.dart';
import 'package:equatable/equatable.dart';

class AppDataLoadCubit extends Cubit<AppDataLoadState> {
  AppDataLoadCubit() : super(AppDataLoadState()) {
    _loadData();
  }

  void _loadData() async {
    emit(state.copyWith(status: CommonStateStatus.loading));
    await Future.delayed(Duration(milliseconds: 1000));
    emit(state.copyWith(status: CommonStateStatus.loaded));
  }
}

class AppDataLoadState extends Equatable {
  final CommonStateStatus status;

  const AppDataLoadState({this.status = CommonStateStatus.init});

  copyWith({CommonStateStatus? status}) {
    return AppDataLoadState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
