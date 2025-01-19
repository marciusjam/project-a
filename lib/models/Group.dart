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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Group type in your schema. */
class Group extends amplify_core.Model {
  static const classType = const _GroupModelType();
  final String id;
  final String? _groupdid;
  final String? _name;
  final List<UsersGroups>? _users;
  final String? _userId;
  final List<Message>? _messages;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  GroupModelIdentifier get modelIdentifier {
      return GroupModelIdentifier(
        id: id
      );
  }
  
  String get groupdid {
    try {
      return _groupdid!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<UsersGroups>? get users {
    return _users;
  }
  
  String? get userId {
    return _userId;
  }
  
  List<Message>? get messages {
    return _messages;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Group._internal({required this.id, required groupdid, required name, users, userId, messages, createdAt, updatedAt}): _groupdid = groupdid, _name = name, _users = users, _userId = userId, _messages = messages, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Group({String? id, required String groupdid, required String name, List<UsersGroups>? users, String? userId, List<Message>? messages}) {
    return Group._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      groupdid: groupdid,
      name: name,
      users: users != null ? List<UsersGroups>.unmodifiable(users) : users,
      userId: userId,
      messages: messages != null ? List<Message>.unmodifiable(messages) : messages);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Group &&
      id == other.id &&
      _groupdid == other._groupdid &&
      _name == other._name &&
      DeepCollectionEquality().equals(_users, other._users) &&
      _userId == other._userId &&
      DeepCollectionEquality().equals(_messages, other._messages);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Group {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("groupdid=" + "$_groupdid" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Group copyWith({String? groupdid, String? name, List<UsersGroups>? users, String? userId, List<Message>? messages}) {
    return Group._internal(
      id: id,
      groupdid: groupdid ?? this.groupdid,
      name: name ?? this.name,
      users: users ?? this.users,
      userId: userId ?? this.userId,
      messages: messages ?? this.messages);
  }
  
  Group copyWithModelFieldValues({
    ModelFieldValue<String>? groupdid,
    ModelFieldValue<String>? name,
    ModelFieldValue<List<UsersGroups>?>? users,
    ModelFieldValue<String?>? userId,
    ModelFieldValue<List<Message>?>? messages
  }) {
    return Group._internal(
      id: id,
      groupdid: groupdid == null ? this.groupdid : groupdid.value,
      name: name == null ? this.name : name.value,
      users: users == null ? this.users : users.value,
      userId: userId == null ? this.userId : userId.value,
      messages: messages == null ? this.messages : messages.value
    );
  }
  
  Group.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _groupdid = json['groupdid'],
      _name = json['name'],
      _users = json['users']  is Map
        ? (json['users']['items'] is List
          ? (json['users']['items'] as List)
              .where((e) => e != null)
              .map((e) => UsersGroups.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['users'] is List
          ? (json['users'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => UsersGroups.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _userId = json['userId'],
      _messages = json['messages']  is Map
        ? (json['messages']['items'] is List
          ? (json['messages']['items'] as List)
              .where((e) => e != null)
              .map((e) => Message.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['messages'] is List
          ? (json['messages'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Message.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'groupdid': _groupdid, 'name': _name, 'users': _users?.map((UsersGroups? e) => e?.toJson()).toList(), 'userId': _userId, 'messages': _messages?.map((Message? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'groupdid': _groupdid,
    'name': _name,
    'users': _users,
    'userId': _userId,
    'messages': _messages,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<GroupModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<GroupModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final GROUPDID = amplify_core.QueryField(fieldName: "groupdid");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final USERS = amplify_core.QueryField(
    fieldName: "users",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'UsersGroups'));
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final MESSAGES = amplify_core.QueryField(
    fieldName: "messages",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Message'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Group";
    modelSchemaDefinition.pluralName = "Groups";
    
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
      amplify_core.ModelIndex(fields: const ["groupdid"], name: "groupsByGroupdid"),
      amplify_core.ModelIndex(fields: const ["userId"], name: "byUserGroup")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Group.GROUPDID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Group.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Group.USERS,
      isRequired: false,
      ofModelName: 'UsersGroups',
      associatedKey: UsersGroups.GROUP
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Group.USERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Group.MESSAGES,
      isRequired: false,
      ofModelName: 'Message',
      associatedKey: Message.ID
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

class _GroupModelType extends amplify_core.ModelType<Group> {
  const _GroupModelType();
  
  @override
  Group fromJson(Map<String, dynamic> jsonData) {
    return Group.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Group';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Group] in your schema.
 */
class GroupModelIdentifier implements amplify_core.ModelIdentifier<Group> {
  final String id;

  /** Create an instance of GroupModelIdentifier using [id] the primary key. */
  const GroupModelIdentifier({
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
  String toString() => 'GroupModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is GroupModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}