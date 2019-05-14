import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_record.jorm.dart';

part 'todo_record.g.dart';

@JsonSerializable(nullable: true)
class TodoRecord {
  TodoRecord();

  TodoRecord.make(
    this.title,
    this.complete,
  );

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: false)
  String title;

  @Column(isNullable: false)
  bool complete;

  factory TodoRecord.fromJson(Map<String, dynamic> json) => _$TodoRecordFromJson(json);

  Map<String, dynamic> toJson() => _$TodoRecordToJson(this);
}

@GenBean()
class TodoRecordBean extends Bean<TodoRecord> with _TodoRecordBean {
  TodoRecordBean(Adapter adapter)
      : super(adapter);

  final String tableName = 'todo';
}
