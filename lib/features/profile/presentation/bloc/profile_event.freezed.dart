// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(UserProfile? profile) profileUpdated,
    required TResult Function(String displayName, String status)
        editProfileRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(UserProfile? profile)? profileUpdated,
    TResult? Function(String displayName, String status)? editProfileRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(UserProfile? profile)? profileUpdated,
    TResult Function(String displayName, String status)? editProfileRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(EditProfileRequested value) editProfileRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(EditProfileRequested value)? editProfileRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(EditProfileRequested value)? editProfileRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEventCopyWith<$Res> {
  factory $ProfileEventCopyWith(
          ProfileEvent value, $Res Function(ProfileEvent) then) =
      _$ProfileEventCopyWithImpl<$Res, ProfileEvent>;
}

/// @nodoc
class _$ProfileEventCopyWithImpl<$Res, $Val extends ProfileEvent>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ProfileEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(UserProfile? profile) profileUpdated,
    required TResult Function(String displayName, String status)
        editProfileRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(UserProfile? profile)? profileUpdated,
    TResult? Function(String displayName, String status)? editProfileRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(UserProfile? profile)? profileUpdated,
    TResult Function(String displayName, String status)? editProfileRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(EditProfileRequested value) editProfileRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(EditProfileRequested value)? editProfileRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(EditProfileRequested value)? editProfileRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class Started implements ProfileEvent {
  const factory Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$ProfileUpdatedImplCopyWith<$Res> {
  factory _$$ProfileUpdatedImplCopyWith(_$ProfileUpdatedImpl value,
          $Res Function(_$ProfileUpdatedImpl) then) =
      __$$ProfileUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserProfile? profile});
}

/// @nodoc
class __$$ProfileUpdatedImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$ProfileUpdatedImpl>
    implements _$$ProfileUpdatedImplCopyWith<$Res> {
  __$$ProfileUpdatedImplCopyWithImpl(
      _$ProfileUpdatedImpl _value, $Res Function(_$ProfileUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(_$ProfileUpdatedImpl(
      freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
    ));
  }
}

/// @nodoc

class _$ProfileUpdatedImpl implements ProfileUpdated {
  const _$ProfileUpdatedImpl(this.profile);

  @override
  final UserProfile? profile;

  @override
  String toString() {
    return 'ProfileEvent.profileUpdated(profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdatedImpl &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdatedImplCopyWith<_$ProfileUpdatedImpl> get copyWith =>
      __$$ProfileUpdatedImplCopyWithImpl<_$ProfileUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(UserProfile? profile) profileUpdated,
    required TResult Function(String displayName, String status)
        editProfileRequested,
  }) {
    return profileUpdated(profile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(UserProfile? profile)? profileUpdated,
    TResult? Function(String displayName, String status)? editProfileRequested,
  }) {
    return profileUpdated?.call(profile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(UserProfile? profile)? profileUpdated,
    TResult Function(String displayName, String status)? editProfileRequested,
    required TResult orElse(),
  }) {
    if (profileUpdated != null) {
      return profileUpdated(profile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(EditProfileRequested value) editProfileRequested,
  }) {
    return profileUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(EditProfileRequested value)? editProfileRequested,
  }) {
    return profileUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(EditProfileRequested value)? editProfileRequested,
    required TResult orElse(),
  }) {
    if (profileUpdated != null) {
      return profileUpdated(this);
    }
    return orElse();
  }
}

abstract class ProfileUpdated implements ProfileEvent {
  const factory ProfileUpdated(final UserProfile? profile) =
      _$ProfileUpdatedImpl;

  UserProfile? get profile;
  @JsonKey(ignore: true)
  _$$ProfileUpdatedImplCopyWith<_$ProfileUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditProfileRequestedImplCopyWith<$Res> {
  factory _$$EditProfileRequestedImplCopyWith(_$EditProfileRequestedImpl value,
          $Res Function(_$EditProfileRequestedImpl) then) =
      __$$EditProfileRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String displayName, String status});
}

/// @nodoc
class __$$EditProfileRequestedImplCopyWithImpl<$Res>
    extends _$ProfileEventCopyWithImpl<$Res, _$EditProfileRequestedImpl>
    implements _$$EditProfileRequestedImplCopyWith<$Res> {
  __$$EditProfileRequestedImplCopyWithImpl(_$EditProfileRequestedImpl _value,
      $Res Function(_$EditProfileRequestedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? status = null,
  }) {
    return _then(_$EditProfileRequestedImpl(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditProfileRequestedImpl implements EditProfileRequested {
  const _$EditProfileRequestedImpl(
      {required this.displayName, required this.status});

  @override
  final String displayName;
  @override
  final String status;

  @override
  String toString() {
    return 'ProfileEvent.editProfileRequested(displayName: $displayName, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileRequestedImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileRequestedImplCopyWith<_$EditProfileRequestedImpl>
      get copyWith =>
          __$$EditProfileRequestedImplCopyWithImpl<_$EditProfileRequestedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(UserProfile? profile) profileUpdated,
    required TResult Function(String displayName, String status)
        editProfileRequested,
  }) {
    return editProfileRequested(displayName, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(UserProfile? profile)? profileUpdated,
    TResult? Function(String displayName, String status)? editProfileRequested,
  }) {
    return editProfileRequested?.call(displayName, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(UserProfile? profile)? profileUpdated,
    TResult Function(String displayName, String status)? editProfileRequested,
    required TResult orElse(),
  }) {
    if (editProfileRequested != null) {
      return editProfileRequested(displayName, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ProfileUpdated value) profileUpdated,
    required TResult Function(EditProfileRequested value) editProfileRequested,
  }) {
    return editProfileRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ProfileUpdated value)? profileUpdated,
    TResult? Function(EditProfileRequested value)? editProfileRequested,
  }) {
    return editProfileRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ProfileUpdated value)? profileUpdated,
    TResult Function(EditProfileRequested value)? editProfileRequested,
    required TResult orElse(),
  }) {
    if (editProfileRequested != null) {
      return editProfileRequested(this);
    }
    return orElse();
  }
}

abstract class EditProfileRequested implements ProfileEvent {
  const factory EditProfileRequested(
      {required final String displayName,
      required final String status}) = _$EditProfileRequestedImpl;

  String get displayName;
  String get status;
  @JsonKey(ignore: true)
  _$$EditProfileRequestedImplCopyWith<_$EditProfileRequestedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
