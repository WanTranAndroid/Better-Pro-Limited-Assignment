// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelImplAdapter extends TypeAdapter<_$TransactionModelImpl> {
  @override
  final int typeId = 1;

  @override
  _$TransactionModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TransactionModelImpl(
      id: fields[0] as String,
      amountValue: fields[1] as String,
      amountPrecision: fields[2] as int,
      currency: fields[3] as String,
      status: fields[4] as String,
      timestamp: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$TransactionModelImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amountValue)
      ..writeByte(2)
      ..write(obj.amountPrecision)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      amountValue: json['amountValue'] as String,
      amountPrecision: (json['amountPrecision'] as num).toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amountValue': instance.amountValue,
      'amountPrecision': instance.amountPrecision,
      'currency': instance.currency,
      'status': instance.status,
      'timestamp': instance.timestamp,
    };
