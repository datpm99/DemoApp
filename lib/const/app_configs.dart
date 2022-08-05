class AppConfigs {
  static const String appVersion = '1.0.0';
  static const String appName = 'MDO';

  //Type login.
  static const String loginEContract = 'eContract';
  static const String loginESignature = 'eSignature';
  static const String loginEDocument = 'eDocument';
  static const String externalGroup = 'EXTERNAL_GROUP';
  static const String externalPersonal = 'EXTERNAL_PERSONAL';
  static const String internal = 'INTERNAL';

  //Code support.
  static String codePhone = 'CSKH_PHONE';
  static String codeEmail = 'CSKH_EMAIL';

  //Code api.
  static const int apiBase = 1;
  static const int apiCore = 2;
  static const int apiCommon = 3;

  //Config base.
  static const double logoSize = 40;
  static const int pageSize = 20;
  static const int dayLimit = 90;

  //Max length.
  static const int maxLength5 = 5;
  static const int maxLength8 = 8;
  static const int maxLength15 = 15;
  static const int maxLength50 = 50;
  static const int maxLength255 = 255;
  static const int maxLength500 = 500;
  static const int maxLength1000 = 1000;

  //Type file.
  static const String typePDF = 'pdf';
  static const String typeDOCX = 'docx';
  static const String typeXLSX = 'xlsx';
  static const String fileMain = 'FILE_MAIN';
  static const String fileAttach = 'FILE_ATTACH';

  //Document state.
  static const String inProgress = 'IN_PROGRESS';
  static const String reject = 'REJECT';
  static const String complete = 'COMPLETE';
  static const String draft = 'DRAFT';
  static const String cancel = 'CANCEL';
  static const String processed = 'PROCESSED';
  static const String rejected = 'REJECTED';
  static const String unprocessed = 'UNPROCESSED';
  static const String promulgate = 'PROMULGATE';
  static const String promulgateCancel = 'PROMULGATE_CANCEL';

  //Action.
  static const String addReviewer = 'ADD_REVIEWER';
  static const String addFlashesSigner = 'ADD_FLASHES_SIGNER';
  static const String addFlashes = 'ADD_FLASHES';

  static const String changeMainSigner = 'CHANGE_MAIN_SIGNER';
  static const String changeFlashesSigner = 'CHANGE_FLASHES_SIGNER';
  static const String changeReviewer = 'CHANGE_REVIEWER';
  static const String changeMain = 'CHANGE_MAIN';
  static const String changeReview = 'CHANGE_REVIEW';

  static const String approveMainSign = 'APPROVE_MAIN_SIGN';
  static const String approveFlashesSign = 'APPROVE_FLASHES_SIGN';
  static const String approveReview = 'APPROVE_REVIEW';

  //Type sign.
  static const String reviewer = 'REVIEWER';
  static const String main = 'MAIN';
  static const String flashes = 'FLASHES';
  static const String all = 'ALL';
  static const String sign = 'SIGN';
}
