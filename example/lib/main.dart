import 'package:flutter/material.dart';
import 'package:survicate_flutter_sdk/models/survicate_answer_model.dart';
import 'package:survicate_flutter_sdk/models/user_traits_model.dart';
import 'package:survicate_flutter_sdk/survicate_flutter_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  SurvicateFlutterSdk survicateFlutterSdk;
  String surveyIdDisplayed;
  String surveyIdAnswered;
  num questionIdAnswered;
  SurvicateAnswerModel answer;
  String surveyIdClosed;
  String surveyIdCompleted;

  @override
  void initState() {
    super.initState();
    if(survicateFlutterSdk == null){
      survicateFlutterSdk = SurvicateFlutterSdk();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Survicate Flutter SDK example app'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                onPressed: () {
                  survicateFlutterSdk.invokeEvent('SURVEY');
                },
                child: Text('Invoke event SURVEY'),
              ),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                onPressed: () {
                  survicateFlutterSdk.enterScreen('SCREEN');
                },
                child: Text('Enter screen SCREEN'),
              ),
              RaisedButton(
                onPressed: () {
                  survicateFlutterSdk.leaveScreen('SCREEN');
                },
                child: Text('Leave screen SCREEN'),
              ),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                onPressed: () {
                  survicateFlutterSdk.setUserTraits(UserTraitsModel(userId: '1', firstName: 'USER'));
                },
                child: Text('Set userId = 1 and first name = USER'),
              ),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                onPressed: () {
                  survicateFlutterSdk.reset();
                },
                child: Text('Reset'),
              ),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    surveyIdDisplayed = null;
                    surveyIdAnswered = null;
                    questionIdAnswered = null;
                    answer = null;
                    surveyIdClosed = null;
                    surveyIdCompleted = null;
                  });
                  survicateFlutterSdk.registerSurveyListeners(
                      callbackSurveyDisplayedListener: (surveyId) {
                        setState(() {
                          surveyIdDisplayed = surveyId;
                        });
                      },
                      callbackQuestionAnsweredListener: (surveyId, questionId, answer) {
                        setState(() {
                          surveyIdAnswered = surveyId;
                          questionIdAnswered = questionId;
                          answer = answer;
                        });
                      },
                      callbackSurveyClosedListener: (surveyId) {
                        setState(() {
                          surveyIdClosed = surveyId;
                        });
                      },
                      callbackSurveyCompletedListener: (surveyId) {
                        setState(() {
                          surveyIdCompleted = surveyId;
                        });
                      }
                  );
                },
                child: Text('Register survey activity listeners'),
              ),
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    surveyIdDisplayed = null;
                    surveyIdAnswered = null;
                    questionIdAnswered = null;
                    answer = null;
                    surveyIdClosed = null;
                    surveyIdCompleted = null;
                  });
                  survicateFlutterSdk.unregisterSurveyListeners();
                },
                child: Text('Unregister survey activity listeners'),
              ),
              SizedBox(
                height: 5.0,
              ),
              surveyIdDisplayed != null
                  ? Text(
                  'Last survey displayed id = $surveyIdDisplayed'
              )
                  : SizedBox(),
              surveyIdDisplayed != null
                  ? SizedBox(
                height: 5.0,
              )
                  : SizedBox(),
              questionIdAnswered != null
                  ? Text(
                  'Last question answered id = $questionIdAnswered from survey id = $surveyIdAnswered, answer type ${answer.type}'
              )
                  : SizedBox(),
              questionIdAnswered != null
                  ? SizedBox(
                height: 5.0,
              )
                  : SizedBox(),
              surveyIdClosed != null
                  ? Text(
                  'Last survey closed id = $surveyIdClosed'
              )
                  : SizedBox(),
              surveyIdClosed != null
                  ? SizedBox(
                height: 5.0,
              )
                  : SizedBox(),
              surveyIdCompleted != null
                  ? Text(
                  'Last survey closed id = $surveyIdCompleted'
              )
                  : SizedBox(),
              surveyIdCompleted != null
                  ? SizedBox(
                height: 5.0,
              )
                  : SizedBox(),
            ],
          ),
        )
      ),
    );
  }
}
