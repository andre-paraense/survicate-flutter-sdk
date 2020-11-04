import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survicate_flutter_sdk/models/survicate_answer_model.dart';
import 'package:survicate_flutter_sdk/models/user_traits_model.dart';
import 'package:survicate_flutter_sdk/survicate_flutter_sdk.dart';

void main() {

  const MethodChannel channel = MethodChannel('survicate_flutter_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  final SurvicateFlutterSdk survicateFlutterSdk = SurvicateFlutterSdk();

  setUpAll(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {

      if (methodCall.method == 'registerSurveyDisplayedListener') {
        return true;
      }

      if (methodCall.method == 'unregisterSurveyDisplayedListener') {
        return true;
      }

      if (methodCall.method == 'registerQuestionAnsweredListener') {
        return true;
      }

      if (methodCall.method == 'unregisterQuestionAnsweredListener') {
        return true;
      }

      if (methodCall.method == 'registerSurveyClosedListener') {
        return true;
      }

      if (methodCall.method == 'unregisterSurveyClosedListener') {
        return true;
      }

      if (methodCall.method == 'registerSurveyCompletedListener') {
        return true;
      }

      if (methodCall.method == 'unregisterSurveyCompletedListener') {
        return true;
      }

      if (methodCall.method == 'invokeEvent') {
        return true;
      }

      if (methodCall.method == 'enterScreen') {
        return true;
      }

      if (methodCall.method == 'leaveScreen') {
        return true;
      }

      if (methodCall.method == 'setUserTraits') {
        return true;
      }

      if (methodCall.method == 'reset') {
        return true;
      }

      return survicateFlutterSdk.handlerMethodCalls(methodCall);
    });
  });

  tearDown(() {
    survicateFlutterSdk.onSurveyDisplayedListener = null;
    survicateFlutterSdk.onQuestionAnsweredListener = null;
    survicateFlutterSdk.onSurveyClosedListener = null;
    survicateFlutterSdk.onSurveyCompletedListener = null;
  });

  tearDownAll(() {
    channel.setMockMethodCallHandler(null);
  });

  group('reset', () {
    test('Return true upon correctly calling reset', () async {
      expect(await survicateFlutterSdk.reset(), true);
    });
  });

  group('setUserTraits', () {
    test('Return false if user traits are null', () async {
      expect(await survicateFlutterSdk.setUserTraits(null), false);
    });

    test('Return false if user traits are all null', () async {
      expect(await survicateFlutterSdk.setUserTraits(UserTraitsModel(userId: null,firstName: null,customTraits: null)), false);
    });

    test('Return false if user traits are all empty', () async {
      expect(await survicateFlutterSdk.setUserTraits(UserTraitsModel(userId: null,firstName: null,customTraits: {})), false);
    });

    test('Return true if any user trait is not empty', () async {
      expect(await survicateFlutterSdk.setUserTraits(UserTraitsModel(userId: 'userId',firstName: null,customTraits: {})), true);
    });

    test('Return true if all user traits are not empty', () async {
      expect(await survicateFlutterSdk.setUserTraits(UserTraitsModel(userId: 'userId',firstName: 'userName',customTraits: { 'customKey' : 'customValue'})), true);
    });
  });

  group('leaveScreen', () {
    test('Return false if screen name is null', () async {
      expect(await survicateFlutterSdk.leaveScreen(null), false);
    });

    test('Return false if screen name is empty', () async {
      expect(await survicateFlutterSdk.leaveScreen(''), false);
    });

    test('Return true if screen name is passed', () async {
      expect(await survicateFlutterSdk.leaveScreen('screenName'), true);
    });
  });

  group('enterScreen', () {
    test('Return false if screen name is null', () async {
      expect(await survicateFlutterSdk.enterScreen(null), false);
    });

    test('Return false if screen name is empty', () async {
      expect(await survicateFlutterSdk.enterScreen(''), false);
    });

    test('Return true if screen name is passed', () async {
      expect(await survicateFlutterSdk.enterScreen('screenName'), true);
    });
  });

  group('invokeEvent', () {
    test('Return false if event name is null', () async {
      expect(await survicateFlutterSdk.invokeEvent(null), false);
    });

    test('Return false if event name is empty', () async {
      expect(await survicateFlutterSdk.invokeEvent(''), false);
    });

    test('Return true if event name is passed', () async {
      expect(await survicateFlutterSdk.invokeEvent('eventName'), true);
    });
  });

  group('registerSurveyDisplayedListener', () {
    test('Return false if the callback is null', () async {
      expect(await survicateFlutterSdk.registerSurveyDisplayedListener(null), false);
    });

    test('Return true if the callback is passed and previously registered', () async {
      bool Function(String) previousCallback = (String surveyId) {return false;};
      survicateFlutterSdk.onSurveyDisplayedListener = previousCallback;
      bool Function(String) newCallback = (String surveyId) {return true;};
      expect(await survicateFlutterSdk.registerSurveyDisplayedListener(newCallback), true);
      expect(survicateFlutterSdk.onSurveyDisplayedListener('surveyId'), true);
    });

    test('Return true if the callback is passed and not previously registered', () async {
      bool Function(String) newCallback = (String surveyId) {return true;};
      expect(await survicateFlutterSdk.registerSurveyDisplayedListener(newCallback), true);
      expect(survicateFlutterSdk.onSurveyDisplayedListener('surveyId'), true);
    });
  });

  group('unregisterSurveyDisplayedListener', () {
    test('Return false if the registered listener is null', () async {
      expect(await survicateFlutterSdk.unregisterSurveyDisplayedListener(), false);
    });

    test('Return true if there was a previous registered listener', () async {
      bool Function(String) previousCallback = (String surveyId) {return true;};
      survicateFlutterSdk.onSurveyDisplayedListener = previousCallback;
      expect(await survicateFlutterSdk.unregisterSurveyDisplayedListener(), true);
      expect(survicateFlutterSdk.onSurveyDisplayedListener, null);
    });
  });

  group('registerQuestionAnsweredListener', () {
    test('Return false if the callback is null', () async {
      expect(await survicateFlutterSdk.registerQuestionAnsweredListener(null), false);
    });

    test('Return true if the callback is passed and previously registered', () async {
      bool Function(String, num, SurvicateAnswerModel) previousCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return false;};
      survicateFlutterSdk.onQuestionAnsweredListener = previousCallback;
      bool Function(String, num, SurvicateAnswerModel) newCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return true;};
      expect(await survicateFlutterSdk.registerQuestionAnsweredListener(newCallback), true);
      expect(survicateFlutterSdk.onQuestionAnsweredListener('surveyId', 1, SurvicateAnswerModel.fromMap({'type':'type', 'id': 1, 'ids' : [1,2,3], 'value': 'value'})), true);
    });

    test('Return true if the callback is passed and not previously registered', () async {
      bool Function(String, num, SurvicateAnswerModel) newCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return true;};
      expect(await survicateFlutterSdk.registerQuestionAnsweredListener(newCallback), true);
      expect(survicateFlutterSdk.onQuestionAnsweredListener('surveyId', 1, SurvicateAnswerModel.fromMap({'type':'type', 'id': 1, 'ids' : [1,2,3], 'value': 'value'})), true);
    });
  });

  group('unregisterQuestionAnsweredListener', () {
    test('Return false if the registered listener is null', () async {
      expect(await survicateFlutterSdk.unregisterQuestionAnsweredListener(), false);
    });

    test('Return true if there was a previous registered listener', () async {
      bool Function(String, num, SurvicateAnswerModel) previousCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return true;};
      survicateFlutterSdk.onQuestionAnsweredListener = previousCallback;
      expect(await survicateFlutterSdk.unregisterQuestionAnsweredListener(), true);
      expect(survicateFlutterSdk.onQuestionAnsweredListener, null);
    });
  });

  group('registerSurveyClosedListener', () {
    test('Return false if the callback is null', () async {
      expect(await survicateFlutterSdk.registerSurveyClosedListener(null), false);
    });

    test('Return true if the callback is passed and previously registered', () async {
      bool Function(String) previousCallback = (String surveyId) {return false;};
      survicateFlutterSdk.onSurveyClosedListener = previousCallback;
      bool Function(String) newCallback = (String surveyId) {return true;};
      expect(await survicateFlutterSdk.registerSurveyClosedListener(newCallback), true);
      expect(survicateFlutterSdk.onSurveyClosedListener('surveyId'), true);
    });

    test('Return true if the callback is passed and not previously registered', () async {
      bool Function(String) newCallback = (String surveyId) {return true;};
      expect(await survicateFlutterSdk.registerSurveyClosedListener(newCallback), true);
      expect(survicateFlutterSdk.onSurveyClosedListener('surveyId'), true);
    });
  });

  group('unregisterSurveyClosedListener', () {
    test('Return false if the registered listener is null', () async {
      expect(await survicateFlutterSdk.unregisterSurveyClosedListener(), false);
    });

    test('Return true if there was a previous registered listener', () async {
      bool Function(String) previousCallback = (String surveyId) {return true;};
      survicateFlutterSdk.onSurveyClosedListener = previousCallback;
      expect(await survicateFlutterSdk.unregisterSurveyClosedListener(), true);
      expect(survicateFlutterSdk.onSurveyClosedListener, null);
    });
  });

  group('registerSurveyCompletedListener', () {
    test('Return false if the callback is null', () async {
      expect(await survicateFlutterSdk.registerSurveyCompletedListener(null), false);
    });

    test('Return true if the callback is passed and previously registered', () async {
      bool Function(String) previousCallback = (String surveyId) {return false;};
      survicateFlutterSdk.onSurveyCompletedListener = previousCallback;
      bool Function(String) newCallback = (String surveyId) {return true;};
      expect(await survicateFlutterSdk.registerSurveyCompletedListener(newCallback), true);
      expect(survicateFlutterSdk.onSurveyCompletedListener('surveyId'), true);
    });

    test('Return true if the callback is passed and not previously registered', () async {
      bool Function(String) newCallback = (String surveyId) {return true;};
      expect(await survicateFlutterSdk.registerSurveyCompletedListener(newCallback), true);
      expect(survicateFlutterSdk.onSurveyCompletedListener('surveyId'), true);
    });
  });

  group('unregisterSurveyCompletedListener', () {
    test('Return false if the registered listener is null', () async {
      expect(await survicateFlutterSdk.unregisterSurveyCompletedListener(), false);
    });

    test('Return true if there was a previous registered listener', () async {
      bool Function(String) previousCallback = (String surveyId) {return true;};
      survicateFlutterSdk.onSurveyCompletedListener = previousCallback;
      expect(await survicateFlutterSdk.unregisterSurveyCompletedListener(), true);
      expect(survicateFlutterSdk.onSurveyCompletedListener, null);
    });
  });

  group('handlerMethodCalls', () {
    test('non-existing method callback', () async {
      String argument = 'argument';

      Map<String, String> arguments = {};
      arguments['argument'] = argument;

      try {
        await channel.invokeMethod('non-existing-method', arguments);
        fail("exception not thrown");
      } catch (e) {
        expect(e, isInstanceOf<MissingPluginException>());
      }
    });

    group('onSurveyDisplayedListener', () {
      test('Return false if there is no survey displayed listener attached', () async {
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';

        expect(await channel.invokeMethod('onSurveyDisplayedListener', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyDisplayedListener(newCallback), true);
        expect(await channel.invokeMethod('onSurveyDisplayedListener', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyDisplayedListener(newCallback), true);
        Map<String, String> arguments = {};
        expect(await channel.invokeMethod('onSurveyDisplayedListener', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyDisplayedListener(newCallback), true);
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';
        expect(await channel.invokeMethod('onSurveyDisplayedListener', arguments), true);
      });
    });

    group('onQuestionAnsweredListener', () {
      test('Return false if there is no survey displayed listener attached', () async {
        Map<String, dynamic> arguments = {};
        arguments['surveyId'] = 'surveyId';
        arguments['questionId'] = 1;
        arguments['answer'] = {'type':'type', 'id': 1, 'ids' : [1,2,3], 'value': 'value'};

        expect(await channel.invokeMethod('onQuestionAnsweredListener', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String, num, SurvicateAnswerModel) newCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return true;};
        expect(await survicateFlutterSdk.registerQuestionAnsweredListener(newCallback), true);
        expect(await channel.invokeMethod('onQuestionAnsweredListener', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String, num, SurvicateAnswerModel) newCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return true;};
        expect(await survicateFlutterSdk.registerQuestionAnsweredListener(newCallback), true);
        Map<String, dynamic> arguments = {};
        expect(await channel.invokeMethod('onQuestionAnsweredListener', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments', () async {
        bool Function(String, num, SurvicateAnswerModel) newCallback = (String surveyId, num questionId, SurvicateAnswerModel answer) {return true;};
        expect(await survicateFlutterSdk.registerQuestionAnsweredListener(newCallback), true);
        Map<String, dynamic> arguments = {};
        arguments['surveyId'] = 'surveyId';
        arguments['questionId'] = 1;
        arguments['answer'] = {'type':'type', 'id': 1, 'ids' : [1,2,3], 'value': 'value'};
        expect(await channel.invokeMethod('onQuestionAnsweredListener', arguments), true);
      });
    });

    group('onSurveyClosedListener', () {
      test('Return false if there is no survey displayed listener attached', () async {
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';

        expect(await channel.invokeMethod('onSurveyClosedListener', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyClosedListener(newCallback), true);
        expect(await channel.invokeMethod('onSurveyClosedListener', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyClosedListener(newCallback), true);
        Map<String, String> arguments = {};
        expect(await channel.invokeMethod('onSurveyClosedListener', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyClosedListener(newCallback), true);
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';
        expect(await channel.invokeMethod('onSurveyClosedListener', arguments), true);
      });
    });

    group('onSurveyCompletedListener', () {
      test('Return false if there is no survey displayed listener attached', () async {
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';

        expect(await channel.invokeMethod('onSurveyCompletedListener', arguments), false);
      });

      test('Return false if no argument is passed', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyCompletedListener(newCallback), true);
        expect(await channel.invokeMethod('onSurveyCompletedListener', null), false);
      });

      test('Return false if the expected arguments are not passed', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyCompletedListener(newCallback), true);
        Map<String, String> arguments = {};
        expect(await channel.invokeMethod('onSurveyCompletedListener', arguments), false);
      });

      test('Return true if the listener is called with the expected arguments', () async {
        bool Function(String) newCallback = (String surveyId) {return true;};
        expect(await survicateFlutterSdk.registerSurveyCompletedListener(newCallback), true);
        Map<String, String> arguments = {};
        arguments['surveyId'] = 'surveyId';
        expect(await channel.invokeMethod('onSurveyCompletedListener', arguments), true);
      });
    });
  });
}
