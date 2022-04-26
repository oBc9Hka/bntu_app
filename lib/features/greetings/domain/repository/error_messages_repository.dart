import '../models/error_message_model.dart';

abstract class ErrorMessagesRepository {
  Future<List<ErrorMessage>> getErrorMessagesList();

  Future<void> submitErrorMessage(String msg);

  Future<void> changeViewedState(String id);

  Future<void> removeErrorMessage(String id);

  Future<String> getUnseenMessages();
}
