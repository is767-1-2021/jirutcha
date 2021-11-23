class BMIModel {
  double bmi;
  double bmrf;
  double bmrm;
  bool isNormal;
  bool isUnder;
  bool isOver;
  String comments;
  BMIModel(
      {required this.bmi,
      required this.bmrf,
      required this.bmrm,
      required this.isNormal,
      required this.isOver,
      required this.isUnder,
      required this.comments});
}
