// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteListAdapter extends TypeAdapter<QuoteList> {
  @override
  final int typeId = 1;

  @override
  QuoteList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteList(
      name: fields[0] as String,
      isPrebuilt: fields[1] as bool,
      filename: fields[2] as String,
      quoteIndex: fields[4] as int,
      quotes: (fields[3] as List).cast<StoredQuote>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuoteList obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isPrebuilt)
      ..writeByte(2)
      ..write(obj.filename)
      ..writeByte(3)
      ..write(obj.quotes)
      ..writeByte(4)
      ..write(obj.quoteIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
