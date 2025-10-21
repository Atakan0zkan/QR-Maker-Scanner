// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '二维码扫描器';

  @override
  String get scan => '扫描';

  @override
  String get create => '创建';

  @override
  String get history => '历史';

  @override
  String get settings => '设置';

  @override
  String get scanQRCode => '扫描二维码';

  @override
  String get createQRCode => '创建二维码';

  @override
  String get alignCameraToScan => '对准相机扫描二维码';

  @override
  String get scanned => '已扫描';

  @override
  String get generated => '已生成';

  @override
  String get codeType => '代码类型';

  @override
  String get url => '网址';

  @override
  String get text => '文本';

  @override
  String get wifi => '无线网络';

  @override
  String get contact => '联系人';

  @override
  String get email => '电子邮件';

  @override
  String get sms => '短信';

  @override
  String get phone => '电话';

  @override
  String get location => '位置';

  @override
  String get social => '社交媒体';

  @override
  String get enterURL => '输入网址';

  @override
  String get enterText => '输入文本';

  @override
  String get textLabel => 'Text';

  @override
  String get textHint => 'Enter your text';

  @override
  String get textRequired => 'Text is required';

  @override
  String get ssid => '网络名称 (SSID)';

  @override
  String get password => '密码';

  @override
  String get securityType => '安全类型';

  @override
  String get none => '无';

  @override
  String get wep => 'WEP';

  @override
  String get wpa => 'WPA/WPA2';

  @override
  String get name => '姓名';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get emailAddress => '电子邮件地址';

  @override
  String get company => '公司';

  @override
  String get subject => '主题';

  @override
  String get message => '消息';

  @override
  String get latitude => '纬度';

  @override
  String get longitude => '经度';

  @override
  String get profileURL => '个人资料网址';

  @override
  String get generate => '生成';

  @override
  String get save => '保存';

  @override
  String get share => '分享';

  @override
  String get delete => '删除';

  @override
  String get copy => '复制';

  @override
  String get open => '打开';

  @override
  String get openInBrowser => '在浏览器中打开';

  @override
  String get addToContacts => '添加到联系人';

  @override
  String get connectToWiFi => '连接到无线网络';

  @override
  String get openInMaps => '在地图中打开';

  @override
  String get call => '拨打';

  @override
  String get sendMessage => '发送消息';

  @override
  String get sendEmail => '发送电子邮件';

  @override
  String get general => '常规';

  @override
  String get notifications => '通知';

  @override
  String get manageNotifications => '管理应用内通知';

  @override
  String get language => '语言';

  @override
  String get changeLanguage => '更改应用语言';

  @override
  String get theme => '主题';

  @override
  String get customizeTheme => '自定义应用主题';

  @override
  String get privacy => '隐私';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get viewPrivacyPolicy => '查看隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get termsOfServiceTitle => 'Terms of Service';

  @override
  String get viewTermsOfService => '查看服务条款';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get cameraPermissionRequired => '需要相机权限';

  @override
  String get cameraPermissionMessage => '此应用无法在没有相机权限的情况下工作。请在设置中授予权限。';

  @override
  String get goToSettings => '前往设置';

  @override
  String get cancel => '取消';

  @override
  String get ok => '确定';

  @override
  String get error => '错误';

  @override
  String get success => '成功';

  @override
  String get qrCodeSaved => '二维码已成功保存';

  @override
  String get qrCodeShared => '二维码已分享';

  @override
  String get copiedToClipboard => '已复制到剪贴板';

  @override
  String get invalidURL => '无效的网址';

  @override
  String get invalidEmail => '无效的电子邮件地址';

  @override
  String get invalidPhone => '无效的电话号码';

  @override
  String get fieldRequired => '此字段为必填项';

  @override
  String get noHistoryYet => '还没有历史记录';

  @override
  String get scanOrCreateQR => '扫描或创建您的第一个二维码';

  @override
  String get deleteConfirmation => '删除确认';

  @override
  String get deleteMessage => '您确定要删除此项目吗？';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get system => '系统';

  @override
  String get saveAsImage => '保存为图片';

  @override
  String get saveAsPDF => '保存为PDF';

  @override
  String get exportOptions => '导出选项';

  @override
  String get website => '网站';

  @override
  String get shortMessage => '短消息';

  @override
  String get selectTheme => '选择主题';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get selected => '已选择';

  @override
  String get noScannedQR => '尚无扫描的二维码';

  @override
  String get noScannedBarcode => '尚无扫描的条形码';

  @override
  String get noGeneratedQR => '尚无生成的二维码';

  @override
  String get noGeneratedBarcode => '尚无生成的条形码';

  @override
  String get selectItems => '选择';

  @override
  String get qrCodes => '二维码';

  @override
  String get barcodes => '条形码';

  @override
  String deleteMultipleMessage(int count) {
    return '您确定要删除 $count 个项目吗？';
  }

  @override
  String get deleteSingleMessage => '您确定要删除此项目吗？';

  @override
  String get scanQROrBarcode => '对准相机扫描二维码或条形码';

  @override
  String get qrColorSettings => '二维码颜色';

  @override
  String get qrColor => '二维码颜色';

  @override
  String get backgroundColor => '背景';

  @override
  String get bodyShape => '主体形状';

  @override
  String get square => '方形';

  @override
  String get circle => '圆形';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get subjectOptional => 'Subject (Optional)';

  @override
  String get messageOptional => 'Message (Optional)';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberRequired => 'Phone number is required';

  @override
  String get locationSearch => 'Search Location (Google Maps)';

  @override
  String get locationExample => 'e.g., Galata Tower, Istanbul';

  @override
  String get locationRequired => 'Location is required';

  @override
  String get locationTitle => 'Location';

  @override
  String get roundedSquare => '圆角方形';

  @override
  String get diamond => '菱形';

  @override
  String get qrLogo => '二维码标志';

  @override
  String get gallery => '图库';

  @override
  String get eyeStyle => 'Eye Style';

  @override
  String get dataModuleShape => 'Data Shape';

  @override
  String get backgroundStyle => 'Background';

  @override
  String get gradient => 'Gradient';

  @override
  String get rounded => 'Rounded';

  @override
  String get instagramGradient => 'Instagram';

  @override
  String get sunsetGradient => 'Sunset';

  @override
  String get oceanGradient => 'Ocean';

  @override
  String get fireGradient => 'Fire';

  @override
  String itemsDeleted(Object count) {
    return '$count items deleted';
  }

  @override
  String get deleteConfirmationTitle => 'Delete Confirmation';

  @override
  String get deleted => 'Deleted';

  @override
  String get oneTimeQR => 'One-Time QR';

  @override
  String get oneTimeQRActive => 'QR code can be scanned once';

  @override
  String get oneTimeQRDefault => 'Unlimited scans';

  @override
  String get qrAnalyticsDashboard => 'QR Analytics Dashboard';

  @override
  String get totalScans => 'Total Scans';

  @override
  String get lastScan => 'Last Scan';

  @override
  String get neverScanned => 'Never scanned';

  @override
  String get activeStatus => 'Active in use';

  @override
  String get notScannedYet => 'Not scanned yet';

  @override
  String get createdDate => 'Created Date';

  @override
  String get oneTimeQRUsed => 'Used';

  @override
  String get oneTimeQRActiveStatus => 'Active';

  @override
  String get analyticsNote => 'Analytics stored locally';

  @override
  String get ppSection1Title => '1. Collected Information';

  @override
  String get ppSection1Content =>
      'QR Scanner collects information to improve user experience. All data is stored locally on your device.';

  @override
  String get ppSection2Title => '2. Camera Permission';

  @override
  String get ppSection2Content =>
      'Camera permission is required to scan QR codes. The camera is only used during scanning.';

  @override
  String get ppSection3Title => '3. Storage Permission';

  @override
  String get ppSection3Content =>
      'Storage permission may be required to save QR codes as images.';

  @override
  String get ppSection4Title => '4. Data Security';

  @override
  String get ppSection4Content =>
      'All your data is stored encrypted on your device. No personal information is shared with third parties.';

  @override
  String get ppSection5Title => '5. Advertisements';

  @override
  String get ppSection5Content =>
      'The app may display advertisements through Google AdMob.';

  @override
  String get ppSection6Title => '6. Children\'s Privacy';

  @override
  String get ppSection6Content =>
      'Our app does not knowingly collect personal information from children under 13.';

  @override
  String get ppSection7Title => '7. Changes';

  @override
  String get ppSection7Content =>
      'This privacy policy may be updated from time to time.';

  @override
  String get ppSection8Title => '8. Contact';

  @override
  String get ppSection8Content =>
      'For questions about this privacy policy, please contact us.\n\nLast Updated: October 10, 2025';

  @override
  String get tosSection1Title => '1. Acceptance';

  @override
  String get tosSection1Content =>
      'By using QR Scanner, you agree to these terms of service.';

  @override
  String get tosSection2Title => '2. License';

  @override
  String get tosSection2Content =>
      'You are granted a limited license for personal, non-commercial use.';

  @override
  String get tosSection3Title => '3. Terms of Use';

  @override
  String get tosSection3Content =>
      'You will not create QR codes with illegal content nor violate the rights of others.';

  @override
  String get tosSection4Title => '4. Disclaimer';

  @override
  String get tosSection4Content =>
      'The app is provided \"as is\". We are not responsible for damages arising from the use of QR codes.';

  @override
  String get tosSection5Title => '5. Content Responsibility';

  @override
  String get tosSection5Content =>
      'You are responsible for the content of the QR codes you create and scan.';

  @override
  String get tosSection6Title => '6. Service Changes';

  @override
  String get tosSection6Content =>
      'We reserve the right to change the app\'s features without prior notice.';

  @override
  String get tosSection7Title => '7. Account Suspension';

  @override
  String get tosSection7Content =>
      'We reserve the right to suspend your access if you violate these terms.';

  @override
  String get tosSection8Title => '8. Intellectual Property';

  @override
  String get tosSection8Content =>
      'All content of the app is protected by copyright.';

  @override
  String get tosSection9Title => '9. Third-Party Links';

  @override
  String get tosSection9Content =>
      'The app may contain links to third-party websites.';

  @override
  String get tosSection10Title => '10. Warranty Disclaimer';

  @override
  String get tosSection10Content => 'The app is provided without any warranty.';

  @override
  String get tosSection11Title => '11. Changes to Terms';

  @override
  String get tosSection11Content =>
      'We reserve the right to change these terms at any time.';

  @override
  String get tosSection12Title => '12. Contact';

  @override
  String get tosSection12Content =>
      'For questions about these terms, please contact us.\n\nLast Updated: October 10, 2025';

  @override
  String get emailAppCannotOpen => '无法打开邮件应用';

  @override
  String get flashControlFailed => '闪光灯控制失败';

  @override
  String get cameraPermissionNeeded => '需要相机权限';

  @override
  String get grantPermission => '授予权限';

  @override
  String scanHistoryDesc(int count) {
    return 'See $count scanned codes';
  }

  @override
  String generateHistoryDesc(int count) {
    return 'See $count generated codes';
  }

  @override
  String get noQRScannedYet => '尚未扫描任何二维码';

  @override
  String get scannedLabel => '已扫描';

  @override
  String get generatedLabel => '已生成';

  @override
  String get flashOn => '闪光灯开启';

  @override
  String get flashOff => '闪光灯关闭';

  @override
  String get normalMode => '普通模式';

  @override
  String get batchScanMode => '批量扫描';

  @override
  String get scannedCodesLabel => '已扫描的代码';

  @override
  String get enterCoordinates => '或输入坐标';

  @override
  String get enterLocationName => '请输入位置名称';

  @override
  String get cannotOpenMaps => '无法打开谷歌地图';

  @override
  String get invalidCoordinateFormat => '无效的坐标格式。示例：41.0082, 28.9784';

  @override
  String get shareError => '分享错误';

  @override
  String get urlCannotOpen => '无法打开URL';

  @override
  String get bugReport => '报告错误';

  @override
  String get reportBugsViaEmail => '通过电子邮件报告错误';

  @override
  String get analytics => 'Analytics';

  @override
  String get usageStatistics => 'Usage Statistics';

  @override
  String get totalEvents => 'Total Events';

  @override
  String get eventTypes => 'Event Types';

  @override
  String get mostCommon => 'Most Common';

  @override
  String get firstEvent => 'First Event';

  @override
  String get lastEvent => 'Last Event';

  @override
  String get clearAnalytics => 'Clear Analytics';

  @override
  String get analyticsCleared => 'Analytics data cleared';
}
