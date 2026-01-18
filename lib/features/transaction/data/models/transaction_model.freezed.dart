// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get amountValue =>
      throw _privateConstructorUsedError; // Stored as String for BigInt safety
  @HiveField(2)
  int get amountPrecision => throw _privateConstructorUsedError;
  @HiveField(3)
  String get currency => throw _privateConstructorUsedError;
  @HiveField(4)
  String get status =>
      throw _privateConstructorUsedError; // Stored as String for Enum flexibility
  @HiveField(5)
  int get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String amountValue,
      @HiveField(2) int amountPrecision,
      @HiveField(3) String currency,
      @HiveField(4) String status,
      @HiveField(5) int timestamp});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amountValue = null,
    Object? amountPrecision = null,
    Object? currency = null,
    Object? status = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amountValue: null == amountValue
          ? _value.amountValue
          : amountValue // ignore: cast_nullable_to_non_nullable
              as String,
      amountPrecision: null == amountPrecision
          ? _value.amountPrecision
          : amountPrecision // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String amountValue,
      @HiveField(2) int amountPrecision,
      @HiveField(3) String currency,
      @HiveField(4) String status,
      @HiveField(5) int timestamp});
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amountValue = null,
    Object? amountPrecision = null,
    Object? currency = null,
    Object? status = null,
    Object? timestamp = null,
  }) {
    return _then(_$TransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amountValue: null == amountValue
          ? _value.amountValue
          : amountValue // ignore: cast_nullable_to_non_nullable
              as String,
      amountPrecision: null == amountPrecision
          ? _value.amountPrecision
          : amountPrecision // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: HiveTypeIds.transactionModel)
class _$TransactionModelImpl extends _TransactionModel {
  const _$TransactionModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.amountValue,
      @HiveField(2) required this.amountPrecision,
      @HiveField(3) required this.currency,
      @HiveField(4) required this.status,
      @HiveField(5) required this.timestamp})
      : super._();

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String amountValue;
// Stored as String for BigInt safety
  @override
  @HiveField(2)
  final int amountPrecision;
  @override
  @HiveField(3)
  final String currency;
  @override
  @HiveField(4)
  final String status;
// Stored as String for Enum flexibility
  @override
  @HiveField(5)
  final int timestamp;

  @override
  String toString() {
    return 'TransactionModel(id: $id, amountValue: $amountValue, amountPrecision: $amountPrecision, currency: $currency, status: $status, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amountValue, amountValue) ||
                other.amountValue == amountValue) &&
            (identical(other.amountPrecision, amountPrecision) ||
                other.amountPrecision == amountPrecision) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amountValue, amountPrecision,
      currency, status, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel extends TransactionModel {
  const factory _TransactionModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String amountValue,
      @HiveField(2) required final int amountPrecision,
      @HiveField(3) required final String currency,
      @HiveField(4) required final String status,
      @HiveField(5) required final int timestamp}) = _$TransactionModelImpl;
  const _TransactionModel._() : super._();

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get amountValue;
  @override // Stored as String for BigInt safety
  @HiveField(2)
  int get amountPrecision;
  @override
  @HiveField(3)
  String get currency;
  @override
  @HiveField(4)
  String get status;
  @override // Stored as String for Enum flexibility
  @HiveField(5)
  int get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
