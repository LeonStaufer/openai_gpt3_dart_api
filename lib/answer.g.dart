// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerApiParameters _$AnswerApiParametersFromJson(Map<String, dynamic> json) {
  return AnswerApiParameters(
    json['model'] as String,
    json['question'] as String,
    (json['examples'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
    json['examples_context'] as String,
    documents:
        (json['documents'] as List<dynamic>?)?.map((e) => e as String).toList(),
    file: json['file'] as String?,
    searchModel: json['search_model'] as String,
    maxRerank: json['max_rerank'] as int,
    temperature: json['temperature'] as num,
    logprobs: json['logprobs'] as int?,
    maxTokens: json['max_tokens'] as int,
    stop: (json['stop'] as List<dynamic>?)?.map((e) => e as String).toList(),
    n: json['n'] as int,
    logitBias: (json['logit_bias'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
    returnMetadata: json['return_metadata'] as bool,
    returnPrompt: json['return_prompt'] as bool,
    expand:
        (json['expand'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$AnswerApiParametersToJson(AnswerApiParameters instance) {
  final val = <String, dynamic>{
    'model': instance.model,
    'question': instance.question,
    'examples': instance.examples,
    'examples_context': instance.examplesContext,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('documents', instance.documents);
  writeNotNull('file', instance.file);
  val['search_model'] = instance.searchModel;
  val['max_rerank'] = instance.maxRerank;
  val['temperature'] = instance.temperature;
  writeNotNull('logprobs', instance.logprobs);
  val['max_tokens'] = instance.maxTokens;
  writeNotNull('stop', instance.stop);
  val['n'] = instance.n;
  writeNotNull('logit_bias', instance.logitBias);
  val['return_metadata'] = instance.returnMetadata;
  val['return_prompt'] = instance.returnPrompt;
  writeNotNull('expand', instance.expand);
  return val;
}

AnswerApiResult _$AnswerApiResultFromJson(Map<String, dynamic> json) {
  return AnswerApiResult(
    json['completion'],
    json['model'] as String,
    json['object'] as String,
    json['prompt'] as String?,
    json['search_model'] as String,
    (json['selected_documents'] as List<dynamic>)
        .map((e) => AnswerDocument.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AnswerApiResultToJson(AnswerApiResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('completion', instance.completion);
  val['model'] = instance.model;
  val['object'] = instance.object;
  writeNotNull('prompt', instance.prompt);
  val['search_model'] = instance.searchModel;
  val['selected_documents'] = instance.selectedDocuments;
  return val;
}

AnswerDocument _$AnswerDocumentFromJson(Map<String, dynamic> json) {
  return AnswerDocument(
    json['document'] as int,
    json['metadata'] as String?,
    json['text'] as String,
  );
}

Map<String, dynamic> _$AnswerDocumentToJson(AnswerDocument instance) {
  final val = <String, dynamic>{
    'document': instance.document,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('metadata', instance.metadata);
  val['text'] = instance.text;
  return val;
}
