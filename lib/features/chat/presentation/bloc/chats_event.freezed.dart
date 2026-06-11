// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<UserProfile> contacts) contactsUpdated,
    required TResult Function(String query) searchQueryChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<UserProfile> contacts)? contactsUpdated,
    TResult? Function(String query)? searchQueryChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<UserProfile> contacts)? contactsUpdated,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ContactsUpdated value) contactsUpdated,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ContactsUpdated value)? contactsUpdated,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ContactsUpdated value)? contactsUpdated,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsEventCopyWith<$Res> {
  factory $ChatsEventCopyWith(
          ChatsEvent value, $Res Function(ChatsEvent) then) =
      _$ChatsEventCopyWithImpl<$Res, ChatsEvent>;
}

/// @nodoc
class _$ChatsEventCopyWithImpl<$Res, $Val extends ChatsEvent>
    implements $ChatsEventCopyWith<$Res> {
  _$ChatsEventCopyWithImpl(this._value, this._then);

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
    extends _$ChatsEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'ChatsEvent.started()';
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
    required TResult Function(List<UserProfile> contacts) contactsUpdated,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<UserProfile> contacts)? contactsUpdated,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<UserProfile> contacts)? contactsUpdated,
    TResult Function(String query)? searchQueryChanged,
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
    required TResult Function(ContactsUpdated value) contactsUpdated,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ContactsUpdated value)? contactsUpdated,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ContactsUpdated value)? contactsUpdated,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class Started implements ChatsEvent {
  const factory Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$ContactsUpdatedImplCopyWith<$Res> {
  factory _$$ContactsUpdatedImplCopyWith(_$ContactsUpdatedImpl value,
          $Res Function(_$ContactsUpdatedImpl) then) =
      __$$ContactsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UserProfile> contacts});
}

/// @nodoc
class __$$ContactsUpdatedImplCopyWithImpl<$Res>
    extends _$ChatsEventCopyWithImpl<$Res, _$ContactsUpdatedImpl>
    implements _$$ContactsUpdatedImplCopyWith<$Res> {
  __$$ContactsUpdatedImplCopyWithImpl(
      _$ContactsUpdatedImpl _value, $Res Function(_$ContactsUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
  }) {
    return _then(_$ContactsUpdatedImpl(
      null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<UserProfile>,
    ));
  }
}

/// @nodoc

class _$ContactsUpdatedImpl implements ContactsUpdated {
  const _$ContactsUpdatedImpl(final List<UserProfile> contacts)
      : _contacts = contacts;

  final List<UserProfile> _contacts;
  @override
  List<UserProfile> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'ChatsEvent.contactsUpdated(contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_contacts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactsUpdatedImplCopyWith<_$ContactsUpdatedImpl> get copyWith =>
      __$$ContactsUpdatedImplCopyWithImpl<_$ContactsUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<UserProfile> contacts) contactsUpdated,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return contactsUpdated(contacts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<UserProfile> contacts)? contactsUpdated,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return contactsUpdated?.call(contacts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<UserProfile> contacts)? contactsUpdated,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (contactsUpdated != null) {
      return contactsUpdated(contacts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ContactsUpdated value) contactsUpdated,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return contactsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ContactsUpdated value)? contactsUpdated,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return contactsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ContactsUpdated value)? contactsUpdated,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (contactsUpdated != null) {
      return contactsUpdated(this);
    }
    return orElse();
  }
}

abstract class ContactsUpdated implements ChatsEvent {
  const factory ContactsUpdated(final List<UserProfile> contacts) =
      _$ContactsUpdatedImpl;

  List<UserProfile> get contacts;
  @JsonKey(ignore: true)
  _$$ContactsUpdatedImplCopyWith<_$ContactsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchQueryChangedImplCopyWith<$Res> {
  factory _$$SearchQueryChangedImplCopyWith(_$SearchQueryChangedImpl value,
          $Res Function(_$SearchQueryChangedImpl) then) =
      __$$SearchQueryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchQueryChangedImplCopyWithImpl<$Res>
    extends _$ChatsEventCopyWithImpl<$Res, _$SearchQueryChangedImpl>
    implements _$$SearchQueryChangedImplCopyWith<$Res> {
  __$$SearchQueryChangedImplCopyWithImpl(_$SearchQueryChangedImpl _value,
      $Res Function(_$SearchQueryChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchQueryChangedImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchQueryChangedImpl implements SearchQueryChanged {
  const _$SearchQueryChangedImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ChatsEvent.searchQueryChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchQueryChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      __$$SearchQueryChangedImplCopyWithImpl<_$SearchQueryChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(List<UserProfile> contacts) contactsUpdated,
    required TResult Function(String query) searchQueryChanged,
  }) {
    return searchQueryChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(List<UserProfile> contacts)? contactsUpdated,
    TResult? Function(String query)? searchQueryChanged,
  }) {
    return searchQueryChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(List<UserProfile> contacts)? contactsUpdated,
    TResult Function(String query)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Started value) started,
    required TResult Function(ContactsUpdated value) contactsUpdated,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
  }) {
    return searchQueryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Started value)? started,
    TResult? Function(ContactsUpdated value)? contactsUpdated,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
  }) {
    return searchQueryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Started value)? started,
    TResult Function(ContactsUpdated value)? contactsUpdated,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(this);
    }
    return orElse();
  }
}

abstract class SearchQueryChanged implements ChatsEvent {
  const factory SearchQueryChanged(final String query) =
      _$SearchQueryChangedImpl;

  String get query;
  @JsonKey(ignore: true)
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
