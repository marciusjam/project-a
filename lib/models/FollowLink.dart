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


/** This is an auto generated class representing the FollowLink type in your schema. */
class FollowLink extends amplify_core.Model {
  static const classType = const _FollowLinkModelType();
  final String id;
  final User? _follower;
  final User? _following;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  FollowLinkModelIdentifier get modelIdentifier {
      return FollowLinkModelIdentifier(
        id: id
      );
  }
  
  User? get follower {
    return _follower;
  }
  
  User? get following {
    return _following;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const FollowLink._internal({required this.id, follower, following, createdAt, updatedAt}): _follower = follower, _following = following, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory FollowLink({String? id, User? follower, User? following}) {
    return FollowLink._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      follower: follower,
      following: following);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowLink &&
      id == other.id &&
      _follower == other._follower &&
      _following == other._following;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("FollowLink {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("follower=" + (_follower != null ? _follower!.toString() : "null") + ", ");
    buffer.write("following=" + (_following != null ? _following!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  FollowLink copyWith({User? follower, User? following}) {
    return FollowLink._internal(
      id: id,
      follower: follower ?? this.follower,
      following: following ?? this.following);
  }
  
  FollowLink copyWithModelFieldValues({
    ModelFieldValue<User?>? follower,
    ModelFieldValue<User?>? following
  }) {
    return FollowLink._internal(
      id: id,
      follower: follower == null ? this.follower : follower.value,
      following: following == null ? this.following : following.value
    );
  }
  
  FollowLink.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _follower = json['follower'] != null
        ? json['follower']['serializedData'] != null
          ? User.fromJson(new Map<String, dynamic>.from(json['follower']['serializedData']))
          : User.fromJson(new Map<String, dynamic>.from(json['follower']))
        : null,
      _following = json['following'] != null
        ? json['following']['serializedData'] != null
          ? User.fromJson(new Map<String, dynamic>.from(json['following']['serializedData']))
          : User.fromJson(new Map<String, dynamic>.from(json['following']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'follower': _follower?.toJson(), 'following': _following?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'follower': _follower,
    'following': _following,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<FollowLinkModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<FollowLinkModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final FOLLOWER = amplify_core.QueryField(
    fieldName: "follower",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final FOLLOWING = amplify_core.QueryField(
    fieldName: "following",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FollowLink";
    modelSchemaDefinition.pluralName = "FollowLinks";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["followerId"], name: "byFollowers"),
      amplify_core.ModelIndex(fields: const ["followingId"], name: "byFollowing")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: FollowLink.FOLLOWER,
      isRequired: false,
      targetNames: ['followerId'],
      ofModelName: 'User'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: FollowLink.FOLLOWING,
      isRequired: false,
      targetNames: ['followingId'],
      ofModelName: 'User'
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

class _FollowLinkModelType extends amplify_core.ModelType<FollowLink> {
  const _FollowLinkModelType();
  
  @override
  FollowLink fromJson(Map<String, dynamic> jsonData) {
    return FollowLink.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'FollowLink';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [FollowLink] in your schema.
 */
class FollowLinkModelIdentifier implements amplify_core.ModelIdentifier<FollowLink> {
  final String id;

  /** Create an instance of FollowLinkModelIdentifier using [id] the primary key. */
  const FollowLinkModelIdentifier({
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
  String toString() => 'FollowLinkModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is FollowLinkModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}