// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_quote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoredQuoteAdapter extends TypeAdapter<StoredQuote> {
  @override
  final int typeId = 1;

  @override
  StoredQuote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoredQuote(
      quoteText: fields[0] as String,
      authorText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoredQuote obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.quoteText)
      ..writeByte(1)
      ..write(obj.authorText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoredQuoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
