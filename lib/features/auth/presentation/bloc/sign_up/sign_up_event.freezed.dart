// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpEventCopyWith<$Res> {
  factory $SignUpEventCopyWith(
          SignUpEvent value, $Res Function(SignUpEvent) then) =
      _$SignUpEventCopyWithImpl<$Res, SignUpEvent>;
}

/// @nodoc
class _$SignUpEventCopyWithImpl<$Res, $Val extends SignUpEvent>
    implements $SignUpEventCopyWith<$Res> {
  _$SignUpEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DisplayNameChangedImplCopyWith<$Res> {
  factory _$$DisplayNameChangedImplCopyWith(_$DisplayNameChangedImpl value,
          $Res Function(_$DisplayNameChangedImpl) then) =
      __$$DisplayNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String displayName});
}

/// @nodoc
class __$$DisplayNameChangedImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$DisplayNameChangedImpl>
    implements _$$DisplayNameChangedImplCopyWith<$Res> {
  __$$DisplayNameChangedImplCopyWithImpl(_$DisplayNameChangedImpl _value,
      $Res Function(_$DisplayNameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
  }) {
    return _then(_$DisplayNameChangedImpl(
      null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DisplayNameChangedImpl implements DisplayNameChanged {
  const _$DisplayNameChangedImpl(this.displayName);

  @override
  final String displayName;

  @override
  String toString() {
    return 'SignUpEvent.displayNameChanged(displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisplayNameChangedImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DisplayNameChangedImplCopyWith<_$DisplayNameChangedImpl> get copyWith =>
      __$$DisplayNameChangedImplCopyWithImpl<_$DisplayNameChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return displayNameChanged(displayName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return displayNameChanged?.call(displayName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (displayNameChanged != null) {
      return displayNameChanged(displayName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return displayNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return displayNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (displayNameChanged != null) {
      return displayNameChanged(this);
    }
    return orElse();
  }
}

abstract class DisplayNameChanged implements SignUpEvent {
  const factory DisplayNameChanged(final String displayName) =
      _$DisplayNameChangedImpl;

  String get displayName;
  @JsonKey(ignore: true)
  _$$DisplayNameChangedImplCopyWith<_$DisplayNameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UsernameChangedImplCopyWith<$Res> {
  factory _$$UsernameChangedImplCopyWith(_$UsernameChangedImpl value,
          $Res Function(_$UsernameChangedImpl) then) =
      __$$UsernameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$UsernameChangedImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$UsernameChangedImpl>
    implements _$$UsernameChangedImplCopyWith<$Res> {
  __$$UsernameChangedImplCopyWithImpl(
      _$UsernameChangedImpl _value, $Res Function(_$UsernameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$UsernameChangedImpl(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UsernameChangedImpl implements UsernameChanged {
  const _$UsernameChangedImpl(this.username);

  @override
  final String username;

  @override
  String toString() {
    return 'SignUpEvent.usernameChanged(username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsernameChangedImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UsernameChangedImplCopyWith<_$UsernameChangedImpl> get copyWith =>
      __$$UsernameChangedImplCopyWithImpl<_$UsernameChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return usernameChanged(username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return usernameChanged?.call(username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (usernameChanged != null) {
      return usernameChanged(username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return usernameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return usernameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (usernameChanged != null) {
      return usernameChanged(this);
    }
    return orElse();
  }
}

abstract class UsernameChanged implements SignUpEvent {
  const factory UsernameChanged(final String username) = _$UsernameChangedImpl;

  String get username;
  @JsonKey(ignore: true)
  _$$UsernameChangedImplCopyWith<_$UsernameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmailChangedImplCopyWith<$Res> {
  factory _$$EmailChangedImplCopyWith(
          _$EmailChangedImpl value, $Res Function(_$EmailChangedImpl) then) =
      __$$EmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailChangedImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$EmailChangedImpl>
    implements _$$EmailChangedImplCopyWith<$Res> {
  __$$EmailChangedImplCopyWithImpl(
      _$EmailChangedImpl _value, $Res Function(_$EmailChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailChangedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailChangedImpl implements EmailChanged {
  const _$EmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'SignUpEvent.emailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      __$$EmailChangedImplCopyWithImpl<_$EmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return emailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return emailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return emailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return emailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(this);
    }
    return orElse();
  }
}

abstract class EmailChanged implements SignUpEvent {
  const factory EmailChanged(final String email) = _$EmailChangedImpl;

  String get email;
  @JsonKey(ignore: true)
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordChangedImplCopyWith<$Res> {
  factory _$$PasswordChangedImplCopyWith(_$PasswordChangedImpl value,
          $Res Function(_$PasswordChangedImpl) then) =
      __$$PasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$PasswordChangedImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$PasswordChangedImpl>
    implements _$$PasswordChangedImplCopyWith<$Res> {
  __$$PasswordChangedImplCopyWithImpl(
      _$PasswordChangedImpl _value, $Res Function(_$PasswordChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$PasswordChangedImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordChangedImpl implements PasswordChanged {
  const _$PasswordChangedImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'SignUpEvent.passwordChanged(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordChangedImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordChangedImplCopyWith<_$PasswordChangedImpl> get copyWith =>
      __$$PasswordChangedImplCopyWithImpl<_$PasswordChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return passwordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return passwordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return passwordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return passwordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(this);
    }
    return orElse();
  }
}

abstract class PasswordChanged implements SignUpEvent {
  const factory PasswordChanged(final String password) = _$PasswordChangedImpl;

  String get password;
  @JsonKey(ignore: true)
  _$$PasswordChangedImplCopyWith<_$PasswordChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmPasswordChangedImplCopyWith<$Res> {
  factory _$$ConfirmPasswordChangedImplCopyWith(
          _$ConfirmPasswordChangedImpl value,
          $Res Function(_$ConfirmPasswordChangedImpl) then) =
      __$$ConfirmPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String confirmPassword});
}

/// @nodoc
class __$$ConfirmPasswordChangedImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$ConfirmPasswordChangedImpl>
    implements _$$ConfirmPasswordChangedImplCopyWith<$Res> {
  __$$ConfirmPasswordChangedImplCopyWithImpl(
      _$ConfirmPasswordChangedImpl _value,
      $Res Function(_$ConfirmPasswordChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmPassword = null,
  }) {
    return _then(_$ConfirmPasswordChangedImpl(
      null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConfirmPasswordChangedImpl implements ConfirmPasswordChanged {
  const _$ConfirmPasswordChangedImpl(this.confirmPassword);

  @override
  final String confirmPassword;

  @override
  String toString() {
    return 'SignUpEvent.confirmPasswordChanged(confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmPasswordChangedImpl &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confirmPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmPasswordChangedImplCopyWith<_$ConfirmPasswordChangedImpl>
      get copyWith => __$$ConfirmPasswordChangedImplCopyWithImpl<
          _$ConfirmPasswordChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return confirmPasswordChanged(confirmPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return confirmPasswordChanged?.call(confirmPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (confirmPasswordChanged != null) {
      return confirmPasswordChanged(confirmPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return confirmPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return confirmPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (confirmPasswordChanged != null) {
      return confirmPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class ConfirmPasswordChanged implements SignUpEvent {
  const factory ConfirmPasswordChanged(final String confirmPassword) =
      _$ConfirmPasswordChangedImpl;

  String get confirmPassword;
  @JsonKey(ignore: true)
  _$$ConfirmPasswordChangedImplCopyWith<_$ConfirmPasswordChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignUpSubmittedImplCopyWith<$Res> {
  factory _$$SignUpSubmittedImplCopyWith(_$SignUpSubmittedImpl value,
          $Res Function(_$SignUpSubmittedImpl) then) =
      __$$SignUpSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignUpSubmittedImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$SignUpSubmittedImpl>
    implements _$$SignUpSubmittedImplCopyWith<$Res> {
  __$$SignUpSubmittedImplCopyWithImpl(
      _$SignUpSubmittedImpl _value, $Res Function(_$SignUpSubmittedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignUpSubmittedImpl implements SignUpSubmitted {
  const _$SignUpSubmittedImpl();

  @override
  String toString() {
    return 'SignUpEvent.signUpSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignUpSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return signUpSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return signUpSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (signUpSubmitted != null) {
      return signUpSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return signUpSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return signUpSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (signUpSubmitted != null) {
      return signUpSubmitted(this);
    }
    return orElse();
  }
}

abstract class SignUpSubmitted implements SignUpEvent {
  const factory SignUpSubmitted() = _$SignUpSubmittedImpl;
}

/// @nodoc
abstract class _$$CheckUsernameUniquenessImplCopyWith<$Res> {
  factory _$$CheckUsernameUniquenessImplCopyWith(
          _$CheckUsernameUniquenessImpl value,
          $Res Function(_$CheckUsernameUniquenessImpl) then) =
      __$$CheckUsernameUniquenessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckUsernameUniquenessImplCopyWithImpl<$Res>
    extends _$SignUpEventCopyWithImpl<$Res, _$CheckUsernameUniquenessImpl>
    implements _$$CheckUsernameUniquenessImplCopyWith<$Res> {
  __$$CheckUsernameUniquenessImplCopyWithImpl(
      _$CheckUsernameUniquenessImpl _value,
      $Res Function(_$CheckUsernameUniquenessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CheckUsernameUniquenessImpl implements CheckUsernameUniqueness {
  const _$CheckUsernameUniquenessImpl();

  @override
  String toString() {
    return 'SignUpEvent.checkUsernameUniqueness()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckUsernameUniquenessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String displayName) displayNameChanged,
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function() signUpSubmitted,
    required TResult Function() checkUsernameUniqueness,
  }) {
    return checkUsernameUniqueness();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String displayName)? displayNameChanged,
    TResult? Function(String username)? usernameChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function()? signUpSubmitted,
    TResult? Function()? checkUsernameUniqueness,
  }) {
    return checkUsernameUniqueness?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String displayName)? displayNameChanged,
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function()? signUpSubmitted,
    TResult Function()? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (checkUsernameUniqueness != null) {
      return checkUsernameUniqueness();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DisplayNameChanged value) displayNameChanged,
    required TResult Function(UsernameChanged value) usernameChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(SignUpSubmitted value) signUpSubmitted,
    required TResult Function(CheckUsernameUniqueness value)
        checkUsernameUniqueness,
  }) {
    return checkUsernameUniqueness(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DisplayNameChanged value)? displayNameChanged,
    TResult? Function(UsernameChanged value)? usernameChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(SignUpSubmitted value)? signUpSubmitted,
    TResult? Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
  }) {
    return checkUsernameUniqueness?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DisplayNameChanged value)? displayNameChanged,
    TResult Function(UsernameChanged value)? usernameChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(SignUpSubmitted value)? signUpSubmitted,
    TResult Function(CheckUsernameUniqueness value)? checkUsernameUniqueness,
    required TResult orElse(),
  }) {
    if (checkUsernameUniqueness != null) {
      return checkUsernameUniqueness(this);
    }
    return orElse();
  }
}

abstract class CheckUsernameUniqueness implements SignUpEvent {
  const factory CheckUsernameUniqueness() = _$CheckUsernameUniquenessImpl;
}
