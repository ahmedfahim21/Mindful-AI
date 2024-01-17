Map<String, dynamic> calculateDassScores(List<int> questionResponses) {

  Map<String, List<List<int>>> severityLevels = {
    "Depression": [
      [0, 9],
      [10, 13],
      [14, 20],
      [21, 27],
      [28, 100000]
    ],
    "Anxiety": [
      [0, 7],
      [8, 9],
      [10, 14],
      [15, 19],
      [20, 100000]
    ],
    "Stress": [
      [0, 14],
      [15, 18],
      [19, 25],
      [26, 33],
      [34, 100000]
    ]
  };
  
   Map<String, List<int>> categoryQuestionMapping = {
    "Depression": [1, 6, 8, 11, 12, 14, 18],
      "Anxiety": [2, 4, 7, 9, 15, 19, 20],
     "Stress": [3, 5, 10, 13, 16, 17, 21]
   };
  
  Map<String, List<int>> categoryQuestionScoreMapping = {};
  
  categoryQuestionMapping.forEach((category, questionsIndices){
    List<int> temp = [];
    for (var questionIndex in questionsIndices) {
      temp.add(questionResponses[questionIndex-1]);
      }  
    categoryQuestionScoreMapping[category] = temp;
  });

  List<String> labels = ["Normal", "Mild", "Moderate", "Severe", "Extremely Severe"];
  
  Map<String, int> scores={};
  scores["Depression"] = (categoryQuestionScoreMapping["Depression"]?.reduce((a,b)=>a+b) ?? 0)*2;
  scores["Anxiety"] = (categoryQuestionScoreMapping["Anxiety"]?.reduce((a,b)=>a+b) ?? 0)*2;
  scores["Stress"] = (categoryQuestionScoreMapping["Stress"]?.reduce((a,b)=>a+b) ?? 0)*2;

  Map<String, Map<String, dynamic>> results = {};
  
  scores.forEach((category, score) {
    for (int i = 0; i < severityLevels[category]!.length; i++) {
      List<int> range = severityLevels[category]![i];
      if (range[0] <= score && score <= range[1]) {
        results[category] = {"Score": score, "Severity": labels[i]};
        break;
      }
    }
  });

  return results;
}
