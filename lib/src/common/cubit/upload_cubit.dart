import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadCubit extends Cubit<UploadState> {
  FirebaseStorage storage;

  UploadCubit(this.storage) : super(UploadState());

  void uploadUserProfile(File file, String uid) {
    final storageRef = storage.ref();
    var uploadTask = storageRef.child('$uid/profile.jpg').putFile(file);
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      emit(state.copyWith(status: UploadStatus.uploading));
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          emit(state.copyWith(percent: progress));
          break;
        case TaskState.success:
          final imageUrl =
              await storageRef.child('$uid/profile.jpg').getDownloadURL();
          emit(state.copyWith(url: imageUrl, status: UploadStatus.success));
          break;
        case TaskState.paused:
        case TaskState.canceled:
        case TaskState.error:
          break;
      }
    });
  }
}

enum UploadStatus {
  init,
  uploading,
  success,
  fail,
}

class UploadState extends Equatable {
  final UploadStatus status;
  final double? percent;
  final String? url;

  const UploadState({
    this.status = UploadStatus.init,
    this.percent = 0,
    this.url,
  });

  UploadState copyWith({
    UploadStatus? status,
    String? url,
    double? percent,
  }) {
    return UploadState(
      status: status ?? this.status,
      percent: percent ?? this.percent,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [
        status,
        percent,
        url,
      ];
}
