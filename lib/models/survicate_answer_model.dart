class SurvicateAnswerModel {
  /// Answer type
  final String type;
  /// Answer ID. Applicable only for type = [‘single’, ‘smiley_scale’, ‘dropdown_list’]
  final int id;
  /// Array of answer IDs. Applicable only for type = [‘multiple’]
  final List<int> ids;
  /// Context value of the answer. Applicable only for type = [‘text’, ‘nps’, ‘date’, ‘rating’]
  final String value;

  SurvicateAnswerModel.fromMap(Map<String,dynamic> survicateAnswerMap)
  : type = survicateAnswerMap['type'],
    id = survicateAnswerMap['id'],
    ids = survicateAnswerMap['ids'],
    value = survicateAnswerMap['value'];
}