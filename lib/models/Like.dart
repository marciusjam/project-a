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


/** This is an auto generated class representing the Like type in your schema. */
class Like extends amplify_core.Model {
  static const classType = const _LikeModelType();
  final String id;
  final User? _user;
  final String? _userId;
  final Post? _post;
  final String? _postId;
  final Comment? _comment;
  final String? _commentId;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  Comment? get comment {
    return _comment;
  }
  
  String? get commentId {
    return _commentId;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Like._internal({required this.id, user, userId, post, postId, comment, commentId, createdAt, updatedAt}): _user = user, _userId = userId, _post = post, _postId = postId, _comment = comment, _commentId = commentId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Like({String? id, User? user, String? userId, Post? post, String? postId, Comment? comment, String? commentId}) {
    return Like._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      user: user,
      userId: userId,
      post: post,
      postId: postId,
      comment: comment,
      commentId: commentId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Like &&
      id == other.id &&
      _user == other._user &&
      _userId == other._userId &&
      _post == other._post &&
      _postId == other._postId &&
      _comment == other._comment &&
      _commentId == other._commentId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Like {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("postId=" + "$_postId" + ", ");
    buffer.write("commentId=" + "$_commentId" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Like copyWith({String? id, User? user, String? userId, Post? post, String? postId, Comment? comment, String? commentId}) {
    return Like._internal(
      id: id ?? this.id,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      post: post ?? this.post,
      postId: postId ?? this.postId,
      comment: comment ?? this.comment,
      commentId: commentId ?? this.commentId);
  }
  
  Like copyWithModelFieldValues({
    ModelFieldValue<String>? id,
    ModelFieldValue<User?>? user,
    ModelFieldValue<String?>? userId,
    ModelFieldValue<Post?>? post,
    ModelFieldValue<String?>? postId,
    ModelFieldValue<Comment?>? comment,
    ModelFieldValue<String?>? commentId
  }) {
    return Like._internal(
      id: id == null ? this.id : id.value,
      user: user == null ? this.user : user.value,
      userId: userId == null ? this.userId : userId.value,
      post: post == null ? this.post : post.value,
      postId: postId == null ? this.postId : postId.value,
      comment: comment == null ? this.comment : comment.value,
      commentId: commentId == null ? this.commentId : commentId.value
    );
  }
  
  Like.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _userId = json['userId'],
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _postId = json['postId'],
      _comment = json['comment']?['serializedData'] != null
        ? Comment.fromJson(new Map<String, dynamic>.from(json['comment']['serializedData']))
        : null,
      _commentId = json['commentId'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user?.toJson(), 'userId': _userId, 'post': _post?.toJson(), 'postId': _postId, 'comment': _comment?.toJson(), 'commentId': _commentId, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'user': _user,
    'userId': _userId,
    'post': _post,
    'postId': _postId,
    'comment': _comment,
    'commentId': _commentId,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USER = amplify_core.QueryField(
    fieldName: "user",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'User'));
  static final USERID = amplify_core.QueryField(fieldName: "userId");
  static final POST = amplify_core.QueryField(
    fieldName: "post",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Post'));
  static final POSTID = amplify_core.QueryField(fieldName: "postId");
  static final COMMENT = amplify_core.QueryField(
    fieldName: "comment",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Comment'));
  static final COMMENTID = amplify_core.QueryField(fieldName: "commentId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Like";
    modelSchemaDefinition.pluralName = "Likes";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Like.USER,
      isRequired: false,
      ofModelName: 'User',
      associatedKey: User.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Like.USERID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Like.POST,
      isRequired: false,
      ofModelName: 'Post',
      associatedKey: Post.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Like.POSTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Like.COMMENT,
      isRequired: false,
      ofModelName: 'Comment',
      associatedKey: Comment.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Like.COMMENTID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _LikeModelType extends amplify_core.ModelType<Like> {
  const _LikeModelType();
  
  @override
  Like fromJson(Map<String, dynamic> jsonData) {
    return Like.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Like';
  }
}