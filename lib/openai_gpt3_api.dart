import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:openai_gpt3_api/search.dart';

import 'answer.dart';
import 'classification.dart';
import 'completion.dart';
import 'invalid_request_exception.dart';

class GPT3 {
  String apiKey;

  /// Creates the OpenAI GPT-3 helper object.
  ///
  /// You should inject your personal API-key to the program by adding
  /// --dart-define=OPENAI_API_KEY=${OPENAI_API_KEY}
  /// to your flutter arguments.
  GPT3(String apiKey) : apiKey = apiKey;

  Uri _getUri(String apiEndpoint, [Engine engine = Engine.davinci]) {
    if (apiEndpoint == 'classifications' || apiEndpoint == 'answers') {
      return Uri.https('api.openai.com', '/v1/$apiEndpoint');
    }
    return Uri.https(
        'api.openai.com', '/v1/engines/${engine.toString()}/$apiEndpoint');
  }

  /// Post a HTTP call to the given [url] with the data object [body].
  Future<Response> _postHttpCall(Uri url, Map<String, dynamic> body) {
    return http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiKey',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  /// Catch any exceptions from the GPT-3 backend.
  void _catchExceptions(Map<String, dynamic> data) {
    if (data.containsKey('error')) {
      throw InvalidRequestException.fromJson(data['error']);
    }
  }

  /// Post a 'completion' API request to the OpenAI service.
  ///
  /// Throws an [InvalidRequestException] if something goes wrong on the backend.
  ///
  /// For more information, refer to [the OpenAI documentation](https://beta.openai.com/docs/api-reference/completions/create).
  Future<CompletionApiResult> completion(String prompt,
      {int maxTokens = 16,
      num temperature = 1,
      num topP = 1,
      int n = 1,
      bool stream = false,
      int? logProbs,
      bool echo = false,
      Engine engine = Engine.davinci,
      String? stop,
      num presencePenalty = 0,
      num frequencyPenalty = 0,
      int bestOf = 1,
      Map<String, num>? logitBias}) async {
    var data = CompletionApiParameters(prompt,
        maxTokens: maxTokens,
        temperature: temperature,
        bestOf: bestOf,
        echo: echo,
        frequencyPenalty: frequencyPenalty,
        logitBias: logitBias,
        logprobs: logProbs,
        n: n,
        presencePenalty: presencePenalty,
        stop: stop,
        stream: stream,
        topP: topP);

    var reqData = data.toJson();
    var response = await _postHttpCall(_getUri('completions', engine), reqData);
    Map<String, dynamic> map = json.decode(response.body);
    _catchExceptions(map);
    return CompletionApiResult.fromJson(map);
  }

  /// Given a query and a set of documents or labels, the model ranks each
  /// document based on its semantic similarity to the provided [query].
  ///
  /// If [documents] and [file] are both null or both not-null, a [ArgumentError] is thrown.
  /// Throws an [InvalidRequestException] if something goes wrong on the backend.
  /// For more information, refer to [the OpenAI documentation](https://beta.openai.com/docs/api-reference/searches)
  Future<SearchApiResult> search(String query,
      {List<String>? documents,
      String? file,
      int maxRerank = 200,
      bool returnMetadata = false,
      Engine engine = Engine.davinci}) async {
    var data = SearchApiParameters(query,
        documents: documents,
        file: file,
        maxRerank: maxRerank,
        returnMetadata: returnMetadata);
    var reqData = data.toJson();
    var response = await _postHttpCall(_getUri('search', engine), reqData);
    Map<String, dynamic> map = json.decode(response.body);
    _catchExceptions(map);
    return SearchApiResult.fromJson(map);
  }

  /// Classifies the specified query using provided examples.
  ///
  /// The endpoint first searches over the labeled examples to select the
  /// ones most relevant for the particular query. Then, the relevant examples
  /// are combined with the query to construct a prompt to produce the final
  /// label via the completions endpoint.
  ///
  /// Labeled examples can be provided via an uploaded file, or explicitly
  /// listed in the request using the examples parameter for quick tests
  /// and small scale use cases.
  ///
  /// If [examples] and [file] are both null or both not-null, a [ArgumentError] is thrown.
  /// Throws an [InvalidRequestException] if something goes wrong on the backend.
  ///
  /// For more information, refer to [the OpenAI documentation](https://beta.openai.com/docs/api-reference/classifications)
  Future<ClassificationApiResult> classification(Engine model, String query,
      {List<List<String>>? examples,
      String? file,
      List<String>? labels,
      Engine searchModel = Engine.ada,
      num temperature = 0,
      int? logprobs,
      int maxExamples = 200,
      Map<String, num>? logitBias,
      bool returnPrompt = false,
      bool returnMetadata = false,
      List<String>? expand}) async {
    var data = ClassificationApiParameters(model.toString(), query,
        returnMetadata: returnMetadata,
        file: file,
        logitBias: logitBias,
        temperature: temperature,
        examples: examples,
        expand: expand,
        labels: labels,
        logprobs: logprobs,
        maxExamples: maxExamples,
        returnPrompt: returnPrompt,
        searchModel: searchModel.toString());
    var reqData = data.toJson();
    var response = await _postHttpCall(_getUri('classifications'), reqData);
    Map<String, dynamic> map = json.decode(response.body);
    _catchExceptions(map);
    return ClassificationApiResult.fromJson(map);
  }

  /// Answers the specified question using the provided documents and examples.
  ///
  /// The endpoint first searches over provided documents or files to find
  /// relevant context. The relevant context is combined with the provided
  /// examples and question to create the prompt for completion.
  ///
  /// If [documents] and [file] are both null or both not-null, a [ArgumentError] is thrown.
  /// Throws an [InvalidRequestException] if something goes wrong on the backend.
  ///
  /// For more information, refer to [the OpenAI documentation](https://beta.openai.com/docs/api-reference/answers)
  Future<AnswerApiResult> answer(Engine model, String question,
      List<List<String>> examples, String examplesContext,
      {List<String>? documents,
      String? file,
      Engine searchModel = Engine.ada,
      int maxRerank = 200,
      num temperature = 0,
      int? logprobs,
      int maxTokens = 16,
      List<String>? stop,
      int n = 1,
      Map<String, num>? logitBias,
      bool returnMetadata = false,
      bool returnPrompt = false,
      List<String>? expand}) async {
    var data = AnswerApiParameters(
        model.toString(), question, examples, examplesContext,
        documents: documents,
        file: file,
        searchModel: searchModel.toString(),
        maxRerank: maxRerank,
        temperature: temperature,
        logprobs: logprobs,
        maxTokens: maxTokens,
        stop: stop,
        n: n,
        logitBias: logitBias,
        returnPrompt: returnPrompt,
        returnMetadata: returnMetadata,
        expand: expand);
    var reqData = data.toJson();
    var response = await _postHttpCall(_getUri('answers'), reqData);
    Map<String, dynamic> map = json.decode(response.body);
    _catchExceptions(map);
    return AnswerApiResult.fromJson(map);
  }
}

/// The OpenAI GPT-3 engine used in the API call.
///
/// For more information on the engines, refer to [the OpenAI documentation](https://beta.openai.com/docs/engines).
class Engine {
  static const ada = Engine._('ada');
  static const babbage = Engine._('babbage');
  static const curie = Engine._('curie');
  static const curieInstruct = Engine._('curie-instruct-beta');
  static const davinci = Engine._('davinci');
  static const davinciInstruct = Engine._('davinci-instruct-beta');
  final String _string;

  const Engine._(this._string);

  @override
  String toString() => _string;
}
