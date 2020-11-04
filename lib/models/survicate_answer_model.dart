class SurvicateAnswerModel {
  /// Answer type
  final String type;
  /// Answer ID. Applicable only for type = [‘single’, ‘smiley_scale’, ‘dropdown_list’]
  final int id;
  /// Array of answer IDs. Applicable only for type = [‘multiple’]
  final List<int> ids;
  /// Context value of the answer. Applicable only for type = [‘text’, ‘nps’, ‘date’, ‘rating’]
  final String value;

  /// Expect that there might be answer objects that consist only of the type property.
  SurvicateAnswerModel.fromMap(dynamic survicateAnswerMap)
  : type = survicateAnswerMap['type'],
    id = survicateAnswerMap['id'],
    ids = List<int>.from(survicateAnswerMap['ids']),
    value = survicateAnswerMap['value'];
}