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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the Comment type in your schema. */
class Comment extends amplify_core.Model {
  static const classType = const _CommentModelType();
  final String id;
  final String? _content;
  final User? _user;
  final String? _userId;
  final Post? _post;
  final String? _postId;
  final amplify_core.TemporalDateTime? _createdOn;
  final amplify_core.TemporalDateTime? _updatedOn;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  User? get user {
    return _user;
  }
  
  String? get userId {
    return _userId;
  }
  
  Post? get post {
    return _post;
  }
  
  String? get postId {
    return _postId;
  }
  
  amplify_core.TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  amplify_core.TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Comment._internal({required this.id, required content, user, userId, post, postId, createdOn, updatedOn, createdAt, updatedAt}): _content = content, _user = user, _userId = userId, _post = post, _postId = postId, _createdOn = createdOn, _updatedOn = updatedOn, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Comment({String? id, required String content, User? user, String? userId, Post? post, String? postId, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Comment._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      content: content,
      user: user,
      userId: userId,
      post: post,
      postId: postId,
      createdOn: createdOn,
      updatedOn: updatedOn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      id == other.id &&
      _content == other._content &&
      _user == other._user &&
      _userId == other._userId &&
      _post == other._post &&
      _postId == other._postId &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("postId=" + "$_postId" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? id, String? content, User? user, String? userId, Post? post, String? postId, amplify_core.TemporalDateTime? createdOn, amplify_core.TemporalDateTime? updatedOn}) {
    return Comment._internal(
      id: id ?? this.id,
      content: content ?? this.content,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      post: post ?? this.post,
      postId: postId ?? this.postId,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn);
  }
  
  Comment copyWithModelFieldValues({
    ModelFieldValue<String>? id,
    ModelFieldValue<String>? content,
    ModelFieldValue<User?>? user,
    ModelFieldValue<String?>? userId,
    ModelFieldValue<Post?>? post,
    ModelFieldValue<String?>? postId,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdOn,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedOn
  }) {
    return Comment._internal(
      id: id == null ? this.id : id.value,
      content: content == null ? this.content : content.value,
      user: user == null ? this.user : user.value,
      userId: userId == null ? this.userId : userId.value,
      post: post == null ? this.post : post.value,
      postId: postId == null ? this.postId : postId.value,
      createdOn: createdOn == null ? this.createdOn : createdOn.value,
      updatedOn: updatedOn == null ? this.updatedOn : updatedOn.value
    );
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _userId = json['userId'],
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _postId = json['postId'],
      _createdOn = json['createdOn'] != null ? amplify_core.TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedOn']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content, 'user': _user?.toJson(), 'userId': _userId, 'post': _post?.toJson(), 'postId': _postId, 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'content': _content,
    'user': _user,
    'userId': _userId,
    'post': _post,
    'postId': _postId,
    'createdOn': _createdOn,
    'updatedOn': _updatedOn,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final ID = amplify_core.QueryField(fieldName: "id");
  static final CONTENT = amplify_core.QueryField(fieldName: "content");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final POST = amplify_core.QueryField(
    fieldName: "post",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Post'));
  static final POSTID = amplify_core.QueryField(fieldName: "postId");
  static final CREATEDON = amplify_core.QueryField(fieldName: "createdOn");
  static final UPDATEDON = amplify_core.QueryField(fieldName: "updatedOn");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["postId", "createdOn"], name: "byPost")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.CONTENT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Comment.USER,
      isRequired: false,
      ofModelName: 'User',
      associatedKey: User.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.USERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Comment.POST,
      isRequired: false,
      ofModelName: 'Post',
      associatedKey: Post.COMMENTS
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.POSTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.CREATEDON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comment.UPDATEDON,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
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

class _CommentModelType extends amplify_core.ModelType<Comment> {
  const _CommentModelType();
  
  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Comment';
  }
}