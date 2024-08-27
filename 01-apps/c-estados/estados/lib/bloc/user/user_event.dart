
part of 'user_bloc.dart';

@immutable
abstract class UserEvent {

}

class ActivateUser extends UserEvent{
  final User user;

  ActivateUser(this.user); // constructor
}

class ChangeUserAge extends UserEvent {
  final int age;
  ChangeUserAge({required this.age});
}