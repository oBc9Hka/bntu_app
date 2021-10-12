class Speciality {
  String? id;
  String? facultyBased;
  String? name;
  String? number;
  String? about;
  String? qualification;
  String? trainingDurationDayFull; //дневное полное
  String? trainingDurationDayShort; //дневное сокращённое
  String? trainingDurationCorrespondenceFull; //заочное полное
  String? trainingDurationCorrespondenceShort; //заочное сокращённое
  List<dynamic>? entranceTestsFull; //вступительные экзамены на полное
  List<dynamic>? entranceShort; //вступительные экзамены на сокращённое
  // план приёма текущий год
  String? admissionCurrentDayFullBudget; //места дневное полное бюджет
  String? admissionCurrentDayShortBudget; //места дневное сокращённое бюджет
  String? admissionCurrentDayFullPaid; //места дневное полное платное
  String? admissionCurrentDayShortPaid; //места дневное сокращённое платное

  String?
      admissionCurrentCorrespondenceFullBudget; //места заочное полное бюджет
  String?
      admissionCurrentCorrespondenceShortBudget; //места заочное сокращённое бюджет
  String? admissionCurrentCorrespondenceFullPaid; //места заочное полное платное
  String?
      admissionCurrentCorrespondenceShortPaid; //места заочное сокращённое платное

  // проходные баллы прошлый год
  String? passScorePrevYearDayFullBudget; //баллы дневное полное бюджет
  String? passScorePrevYearDayShortBudget; //баллы дневное сокращённое бюджет
  String? passScorePrevYearDayFullPaid; //баллы дневное полное платное
  String? passScorePrevYearDayShortPaid; //баллы дневное сокращённое платное

  String?
      passScorePrevYearCorrespondenceFullBudget; //баллы заочное полное бюджет
  String?
      passScorePrevYearCorrespondenceShortBudget; //баллы заочное сокращённое бюджет
  String?
      passScorePrevYearCorrespondenceFullPaid; //баллы заочное полное платное
  String?
      passScorePrevYearCorrespondenceShortPaid; //баллы заочное сокращённое платное

  //план приема прошлый год
  String? admissionPrevYearDayFullBudget; //места дневное полное бюджет
  String? admissionPrevYearDayShortBudget; //места дневное сокращённое бюджет
  String? admissionPrevYearDayFullPaid; //места дневное полное платное
  String? admissionPrevYearDayShortPaid; //места дневное сокращённое платное

  String?
      admissionPrevYearCorrespondenceFullBudget; //места заочное полное бюджет
  String?
      admissionPrevYearCorrespondenceShortBudget; //места заочное сокращённое бюджет
  String?
      admissionPrevYearCorrespondenceFullPaid; //места заочное полное платное
  String?
      admissionPrevYearCorrespondenceShortPaid; //места заочное сокращённое платное

  //проходные баллы позапрошлый год
  String? passScoreBeforeLastYearDayFullBudget; //баллы дневное полное бюджет
  String?
      passScoreBeforeLastYearDayShortBudget; //баллы дневное сокращённое бюджет
  String? passScoreBeforeLastYearDayFullPaid; //баллы дневное полное платное
  String?
      passScoreBeforeLastYearDayShortPaid; //баллы дневное сокращённое платное

  String?
      passScoreBeforeLastYearCorrespondenceFullBudget; //баллы заочное полное бюджет
  String?
      passScoreBeforeLastYearCorrespondenceShortBudget; //баллы заочное сокращённое бюджет
  String?
      passScoreBeforeLastYearCorrespondenceFullPaid; //баллы заочное полное платное
  String?
      passScoreBeforeLastYearCorrespondenceShortPaid; //баллы заочное сокращённое платное

  Speciality(
      {this.id,
      this.facultyBased,
      this.name,
      this.number,
      this.about,
      this.qualification,
      this.trainingDurationDayFull,
      this.trainingDurationDayShort,
      this.trainingDurationCorrespondenceFull,
      this.trainingDurationCorrespondenceShort,
      this.entranceTestsFull,
      this.entranceShort,
      this.admissionCurrentDayFullBudget,
      this.admissionCurrentDayShortBudget,
      this.admissionCurrentDayFullPaid,
      this.admissionCurrentDayShortPaid,
      this.admissionCurrentCorrespondenceFullBudget,
      this.admissionCurrentCorrespondenceShortBudget,
      this.admissionCurrentCorrespondenceFullPaid,
      this.admissionCurrentCorrespondenceShortPaid,
      this.passScorePrevYearDayFullBudget,
      this.passScorePrevYearDayShortBudget,
      this.passScorePrevYearDayFullPaid,
      this.passScorePrevYearDayShortPaid,
      this.passScorePrevYearCorrespondenceFullBudget,
      this.passScorePrevYearCorrespondenceShortBudget,
      this.passScorePrevYearCorrespondenceFullPaid,
      this.passScorePrevYearCorrespondenceShortPaid,
      this.admissionPrevYearDayFullBudget,
      this.admissionPrevYearDayShortBudget,
      this.admissionPrevYearDayFullPaid,
      this.admissionPrevYearDayShortPaid,
      this.admissionPrevYearCorrespondenceFullBudget,
      this.admissionPrevYearCorrespondenceShortBudget,
      this.admissionPrevYearCorrespondenceFullPaid,
      this.admissionPrevYearCorrespondenceShortPaid,
      this.passScoreBeforeLastYearDayFullBudget,
      this.passScoreBeforeLastYearDayShortBudget,
      this.passScoreBeforeLastYearDayFullPaid,
      this.passScoreBeforeLastYearDayShortPaid,
      this.passScoreBeforeLastYearCorrespondenceFullBudget,
      this.passScoreBeforeLastYearCorrespondenceShortBudget,
      this.passScoreBeforeLastYearCorrespondenceFullPaid,
      this.passScoreBeforeLastYearCorrespondenceShortPaid});

  Speciality.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          facultyBased: data['facultyBased'],
          name: data['name'],
          number: data['number'],
          about: data['about'],
          qualification: data['qualification'],
          trainingDurationDayFull: data['trainingDurationDayFull'],
          trainingDurationDayShort: data['trainingDurationDayShort'],
          trainingDurationCorrespondenceFull:
              data['trainingDurationCorrespondenceFull'],
          trainingDurationCorrespondenceShort:
              data['trainingDurationCorrespondenceShort'],
          entranceTestsFull: data['entranceTestsFull'],
          entranceShort: data['entranceShort'],
          admissionCurrentDayFullBudget: data['admissionCurrentDayFullBudget'],
          admissionCurrentDayShortBudget:
              data['admissionCurrentDayShortBudget'],
          admissionCurrentDayFullPaid: data['admissionCurrentDayFullPaid'],
          admissionCurrentDayShortPaid: data['admissionCurrentDayShortPaid'],
          admissionCurrentCorrespondenceFullBudget:
              data['admissionCurrentCorrespondenceFullBudget'],
          admissionCurrentCorrespondenceShortBudget:
              data['admissionCurrentCorrespondenceShortBudget'],
          admissionCurrentCorrespondenceFullPaid:
              data['admissionCurrentCorrespondenceFullPaid'],
          admissionCurrentCorrespondenceShortPaid:
              data['admissionCurrentCorrespondenceShortPaid'],
          passScorePrevYearDayFullBudget:
              data['passScorePrevYearDayFullBudget'],
          passScorePrevYearDayShortBudget:
              data['passScorePrevYearDayShortBudget'],
          passScorePrevYearDayFullPaid: data['passScorePrevYearDayFullPaid'],
          passScorePrevYearDayShortPaid: data['passScorePrevYearDayShortPaid'],
          passScorePrevYearCorrespondenceFullBudget:
              data['passScorePrevYearCorrespondenceFullBudget'],
          passScorePrevYearCorrespondenceShortBudget:
              data['passScorePrevYearCorrespondenceShortBudget'],
          passScorePrevYearCorrespondenceFullPaid:
              data['passScorePrevYearCorrespondenceFullPaid'],
          passScorePrevYearCorrespondenceShortPaid:
              data['passScorePrevYearCorrespondenceShortPaid'],
          admissionPrevYearDayFullBudget:
              data['admissionPrevYearDayFullBudget'],
          admissionPrevYearDayShortBudget:
              data['admissionPrevYearDayShortBudget'],
          admissionPrevYearDayFullPaid: data['admissionPrevYearDayFullPaid'],
          admissionPrevYearDayShortPaid: data['admissionPrevYearDayShortPaid'],
          admissionPrevYearCorrespondenceFullBudget:
              data['admissionPrevYearCorrespondenceFullBudget'],
          admissionPrevYearCorrespondenceShortBudget:
              data['admissionPrevYearCorrespondenceShortBudget'],
          admissionPrevYearCorrespondenceFullPaid:
              data['admissionPrevYearCorrespondenceFullPaid'],
          admissionPrevYearCorrespondenceShortPaid:
              data['admissionPrevYearCorrespondenceShortPaid'],
          passScoreBeforeLastYearDayFullBudget:
              data['passScoreBeforeLastYearDayFullBudget'],
          passScoreBeforeLastYearDayShortBudget:
              data['passScoreBeforeLastYearDayShortBudget'],
          passScoreBeforeLastYearDayFullPaid:
              data['passScoreBeforeLastYearDayFullPaid'],
          passScoreBeforeLastYearDayShortPaid:
              data['passScoreBeforeLastYearDayShortPaid'],
          passScoreBeforeLastYearCorrespondenceFullBudget:
              data['passScoreBeforeLastYearCorrespondenceFullBudget'],
          passScoreBeforeLastYearCorrespondenceShortBudget:
              data['passScoreBeforeLastYearCorrespondenceShortBudget'],
          passScoreBeforeLastYearCorrespondenceFullPaid:
              data['passScoreBeforeLastYearCorrespondenceFullPaid'],
          passScoreBeforeLastYearCorrespondenceShortPaid:
              data['passScoreBeforeLastYearCorrespondenceShortPaid'],
        );
}
