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
  String get viewPrivacyPolicy => '查看隐私政策';

  @override
  String get termsOfService => '服务条款';

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
  String deleteMultipleMessage(Object count) {
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
  String get roundedSquare => '圆角方形';

  @override
  String get diamond => '菱形';

  @override
  String get qrLogo => '二维码标志';

  @override
  String get gallery => '图库';
}
