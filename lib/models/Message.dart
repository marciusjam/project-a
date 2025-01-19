/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Message type in your schema. */
class Message extends amplify_core.Model {
  static const classType = const _MessageModelType();
  final String id;
  final String? _messageid;
  final String? _content;
  final amplify_core.TemporalDateTime? _timestamp;
  final User? _sender;
  final Group? _group;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  MessageModelIdentifier get modelIdentifier {
      return MessageModelIdentifier(
        id: id
      );
  }
  
  String get messageid {
    try {
      return _messageid!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get content {
    try {
      return _content!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime get timestamp {
    try {
      return _timestamp!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  User? get sender {
    return _sender;
  }
  
  Group? get group {
    return _group;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Message._internal({required this.id, required messageid, required content, required timestamp, sender, group, createdAt, updatedAt}): _messageid = messageid, _content = content, _timestamp = timestamp, _sender = sender, _group = group, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Message({String? id, required String messageid, required String content, required amplify_core.TemporalDateTime timestamp, User? sender, Group? group}) {
    return Message._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      messageid: messageid,
      content: content,
      timestamp: timestamp,
      sender: sender,
      group: group);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
      id == other.id &&
      _messageid == other._messageid &&
      _content == other._content &&
      _timestamp == other._timestamp &&
      _sender == other._sender &&
      _group == other._group;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Message {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("messageid=" + "$_messageid" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("timestamp=" + (_timestamp != null ? _timestamp!.format() : "null") + ", ");
    buffer.write("sender=" + (_sender != null ? _sender!.toString() : "null") + ", ");
    buffer.write("group=" + (_group != null ? _group!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Message copyWith({String? messageid, String? content, amplify_core.TemporalDateTime? timestamp, User? sender, Group? group}) {
    return Message._internal(
      id: id,
      messageid: messageid ?? this.messageid,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
      group: group ?? this.group);
  }
  
  Message copyWithModelFieldValues({
    ModelFieldValue<String>? messageid,
    ModelFieldValue<String>? content,
    ModelFieldValue<amplify_core.TemporalDateTime>? timestamp,
    ModelFieldValue<User?>? sender,
    ModelFieldValue<Group?>? group
  }) {
    return Message._internal(
      id: id,
      messageid: messageid == null ? this.messageid : messageid.value,
      content: content == null ? this.content : content.value,
      timestamp: timestamp == null ? this.timestamp : timestamp.value,
      sender: sender == null ? this.sender : sender.value,
      group: group == null ? this.group : group.value
    );
  }
  
  Message.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _messageid = json['messageid'],
      _content = json['content'],
      _timestamp = json['timestamp'] != null ? amplify_core.TemporalDateTime.fromString(json['timestamp']) : null,
      _sender = json['sender'] != null
        ? json['sender']['serializedData'] != null
          ? User.fromJson(new Map<String, dynamic>.from(json['sender']['serializedData']))
          : User.fromJson(new Map<String, dynamic>.from(json['sender']))
        : null,
      _group = json['group'] != null
        ? json['group']['serializedData'] != null
          ? Group.fromJson(new Map<String, dynamic>.from(json['group']['serializedData']))
          : Group.fromJson(new Map<String, dynamic>.from(json['group']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'messageid': _messageid, 'content': _content, 'timestamp': _timestamp?.format(), 'sender': _sender?.toJson(), 'group': _group?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'messageid': _messageid,
    'content': _content,
    'timestamp': _timestamp,
    'sender': _sender,
    'group': _group,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<MessageModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<MessageModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final MESSAGEID = amplify_core.QueryField(fieldName: "messageid");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static final SENDER = amplify_core.QueryField(
    fieldName: "sender",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final GROUP = amplify_core.QueryField(
    fieldName: "group",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Group'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Message";
    modelSchemaDefinition.pluralName = "Messages";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id"], name: null),
      amplify_core.ModelIndex(fields: const ["messageid"], name: "messagesByMessageid"),
      amplify_core.ModelIndex(fields: const ["userId"], name: "byUserMessages")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Message.MESSAGEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Message.CONTENT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Message.TIMESTAMP,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Message.SENDER,
      isRequired: false,
      targetNames: ['userId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Message.GROUP,
      isRequired: false,
      targetNames: ['userId'],
      ofModelName: 'Group'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _MessageModelType extends amplify_core.ModelType<Message> {
  const _MessageModelType();
  
  @override
  Message fromJson(Map<String, dynamic> jsonData) {
    return Message.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Message';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Message] in your schema.
 */
class MessageModelIdentifier implements amplify_core.ModelIdentifier<Message> {
  final String id;

  /** Create an instance of MessageModelIdentifier using [id] the primary key. */
  const MessageModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'MessageModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is MessageModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}