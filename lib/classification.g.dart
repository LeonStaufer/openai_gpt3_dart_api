// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationApiParameters _$ClassificationApiParametersFromJson(
    Map<String, dynamic> json) {
  return ClassificationApiParameters(
    json['model'] as String,
    json['query'] as String,
    examples: (json['examples'] as List<dynamic>?)
        ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
    file: json['file'] as String?,
    labels:
        (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
    searchModel: json['search_model'] as String,
    temperature: json['temperature'] as num,
    logprobs: json['logprobs'] as int?,
    maxExamples: json['max_examples'] as int,
    logitBias: (json['logit_bias'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as num),
    ),
    returnPrompt: json['return_prompt'] as bool,
    returnMetadata: json['return_metadata'] as bool,
    expand:
        (json['expand'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ClassificationApiParametersToJson(
    ClassificationApiParameters instance) {
  final val = <String, dynamic>{
    'model': instance.model,
    'query': instance.query,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('examples', instance.examples);
  writeNotNull('file', instance.file);
  writeNotNull('labels', instance.labels);
  val['search_model'] = instance.searchModel;
  val['temperature'] = instance.temperature;
  writeNotNull('logprobs', instance.logprobs);
  val['max_examples'] = instance.maxExamples;
  writeNotNull('logit_bias', instance.logitBias);
  val['return_prompt'] = instance.returnPrompt;
  val['return_metadata'] = instance.returnMetadata;
  writeNotNull('expand', instance.expand);
  return val;
}

ClassificationApiResult _$ClassificationApiResultFromJson(
    Map<String, dynamic> json) {
  return ClassificationApiResult(
    json['completion'],
    json['label'] as String,
    json['model'] as String,
    json['object'] as String,
    json['prompt'] as String?,
    json['search_model'] as String,
    (json['selected_examples'] as List<dynamic>)
        .map((e) =>
            ClassificationExampleData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ClassificationApiResultToJson(
    ClassificationApiResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('completion', instance.completion);
  val['label'] = instance.label;
  val['model'] = instance.model;
  val['object'] = instance.object;
  writeNotNull('prompt', instance.prompt);
  val['search_model'] = instance.searchModel;
  val['selected_examples'] = instance.selectedExamples;
  return val;
}

ClassificationExampleData _$ClassificationExampleDataFromJson(
    Map<String, dynamic> json) {
  return ClassificationExampleData(
    json['document'] as int,
    json['label'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$ClassificationExampleDataToJson(
        ClassificationExampleData instance) =>
    <String, dynamic>{
      'document': instance.document,
      'label': instance.label,
      'text': instance.text,
    };
