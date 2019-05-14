// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoRecord _$TodoRecordFromJson(Map<String, dynamic> json) {
  return TodoRecord()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..complete = json['complete'] as bool;
}

Map<String, dynamic> _$TodoRecordToJson(TodoRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'complete': instance.complete
    };
