import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'QR Scanner'**
  String get appName;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @scanQRCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQRCode;

  /// No description provided for @createQRCode.
  ///
  /// In en, this message translates to:
  /// **'Create QR Code'**
  String get createQRCode;

  /// No description provided for @alignCameraToScan.
  ///
  /// In en, this message translates to:
  /// **'Align camera to scan QR code'**
  String get alignCameraToScan;

  /// No description provided for @scanned.
  ///
  /// In en, this message translates to:
  /// **'Scanned'**
  String get scanned;

  /// No description provided for @generated.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get generated;

  /// No description provided for @codeType.
  ///
  /// In en, this message translates to:
  /// **'Code Type'**
  String get codeType;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @wifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get wifi;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @social.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get social;

  /// No description provided for @enterURL.
  ///
  /// In en, this message translates to:
  /// **'Enter URL'**
  String get enterURL;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter text'**
  String get enterText;

  /// No description provided for @textLabel.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textLabel;

  /// No description provided for @textHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your text'**
  String get textHint;

  /// No description provided for @textRequired.
  ///
  /// In en, this message translates to:
  /// **'Text is required'**
  String get textRequired;

  /// No description provided for @ssid.
  ///
  /// In en, this message translates to:
  /// **'Network Name (SSID)'**
  String get ssid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @securityType.
  ///
  /// In en, this message translates to:
  /// **'Security Type'**
  String get securityType;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @wep.
  ///
  /// In en, this message translates to:
  /// **'WEP'**
  String get wep;

  /// No description provided for @wpa.
  ///
  /// In en, this message translates to:
  /// **'WPA/WPA2'**
  String get wpa;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @profileURL.
  ///
  /// In en, this message translates to:
  /// **'Profile URL'**
  String get profileURL;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @openInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open in Browser'**
  String get openInBrowser;

  /// No description provided for @addToContacts.
  ///
  /// In en, this message translates to:
  /// **'Add to Contacts'**
  String get addToContacts;

  /// No description provided for @connectToWiFi.
  ///
  /// In en, this message translates to:
  /// **'Connect to WiFi'**
  String get connectToWiFi;

  /// No description provided for @openInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMaps;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @manageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Manage in-app notifications'**
  String get manageNotifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get changeLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @customizeTheme.
  ///
  /// In en, this message translates to:
  /// **'Customize app theme'**
  String get customizeTheme;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @viewPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'View privacy policy'**
  String get viewPrivacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @viewTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'View terms of service'**
  String get viewTermsOfService;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Camera Permission Required'**
  String get cameraPermissionRequired;

  /// No description provided for @cameraPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'This app cannot work without camera permission. Please grant permission in settings.'**
  String get cameraPermissionMessage;

  /// No description provided for @goToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings'**
  String get goToSettings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @qrCodeSaved.
  ///
  /// In en, this message translates to:
  /// **'QR code saved successfully'**
  String get qrCodeSaved;

  /// No description provided for @qrCodeShared.
  ///
  /// In en, this message translates to:
  /// **'QR code shared'**
  String get qrCodeShared;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @invalidURL.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get invalidURL;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmail;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhone;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @noHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get noHistoryYet;

  /// No description provided for @scanOrCreateQR.
  ///
  /// In en, this message translates to:
  /// **'Scan or create your first QR code'**
  String get scanOrCreateQR;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get deleteConfirmation;

  /// No description provided for @deleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get deleteMessage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @saveAsImage.
  ///
  /// In en, this message translates to:
  /// **'Save as Image'**
  String get saveAsImage;

  /// No description provided for @saveAsPDF.
  ///
  /// In en, this message translates to:
  /// **'Save as PDF'**
  String get saveAsPDF;

  /// No description provided for @exportOptions.
  ///
  /// In en, this message translates to:
  /// **'Export Options'**
  String get exportOptions;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @shortMessage.
  ///
  /// In en, this message translates to:
  /// **'Short Message'**
  String get shortMessage;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get selected;

  /// No description provided for @noScannedQR.
  ///
  /// In en, this message translates to:
  /// **'No scanned QR codes yet'**
  String get noScannedQR;

  /// No description provided for @noScannedBarcode.
  ///
  /// In en, this message translates to:
  /// **'No scanned barcodes yet'**
  String get noScannedBarcode;

  /// No description provided for @noGeneratedQR.
  ///
  /// In en, this message translates to:
  /// **'No generated QR codes yet'**
  String get noGeneratedQR;

  /// No description provided for @noGeneratedBarcode.
  ///
  /// In en, this message translates to:
  /// **'No generated barcodes yet'**
  String get noGeneratedBarcode;

  /// No description provided for @selectItems.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectItems;

  /// No description provided for @qrCodes.
  ///
  /// In en, this message translates to:
  /// **'QR Codes'**
  String get qrCodes;

  /// No description provided for @barcodes.
  ///
  /// In en, this message translates to:
  /// **'Barcodes'**
  String get barcodes;

  /// No description provided for @deleteMultipleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} items?'**
  String deleteMultipleMessage(Object count);

  /// No description provided for @deleteSingleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get deleteSingleMessage;

  /// No description provided for @scanQROrBarcode.
  ///
  /// In en, this message translates to:
  /// **'Align camera to scan QR code or barcode'**
  String get scanQROrBarcode;

  /// No description provided for @qrColorSettings.
  ///
  /// In en, this message translates to:
  /// **'QR Code Colors'**
  String get qrColorSettings;

  /// No description provided for @qrColor.
  ///
  /// In en, this message translates to:
  /// **'QR Color'**
  String get qrColor;

  /// No description provided for @backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get backgroundColor;

  /// No description provided for @bodyShape.
  ///
  /// In en, this message translates to:
  /// **'Body Shape'**
  String get bodyShape;

  /// No description provided for @square.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get square;

  /// No description provided for @circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get circle;

  /// No description provided for @roundedSquare.
  ///
  /// In en, this message translates to:
  /// **'Rounded Square'**
  String get roundedSquare;

  /// No description provided for @diamond.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get diamond;

  /// No description provided for @qrLogo.
  ///
  /// In en, this message translates to:
  /// **'QR Logo'**
  String get qrLogo;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @eyeStyle.
  ///
  /// In en, this message translates to:
  /// **'Eye Style'**
  String get eyeStyle;

  /// No description provided for @dataModuleShape.
  ///
  /// In en, this message translates to:
  /// **'Data Shape'**
  String get dataModuleShape;

  /// No description provided for @backgroundStyle.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get backgroundStyle;

  /// No description provided for @gradient.
  ///
  /// In en, this message translates to:
  /// **'Gradient'**
  String get gradient;

  /// No description provided for @rounded.
  ///
  /// In en, this message translates to:
  /// **'Rounded'**
  String get rounded;

  /// No description provided for @instagramGradient.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagramGradient;

  /// No description provided for @sunsetGradient.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunsetGradient;

  /// No description provided for @oceanGradient.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get oceanGradient;

  /// No description provided for @fireGradient.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fireGradient;

  /// No description provided for @itemsDeleted.
  ///
  /// In en, this message translates to:
  /// **'{count} items deleted'**
  String itemsDeleted(Object count);

  /// No description provided for @deleteConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get deleteConfirmationTitle;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @termsOfServiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceTitle;

  /// No description provided for @ppSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Collected Information'**
  String get ppSection1Title;

  /// No description provided for @ppSection1Content.
  ///
  /// In en, this message translates to:
  /// **'QR Scanner app collects the following information to improve user experience:\n\n• Content of QR codes you scan (stored locally on your device)\n• QR codes you create (stored locally on your device)\n• App usage preferences (theme, language, etc.)\n\nAll data is stored locally on your device and is not sent to our servers.'**
  String get ppSection1Content;

  /// No description provided for @ppSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Camera Permission'**
  String get ppSection2Title;

  /// No description provided for @ppSection2Content.
  ///
  /// In en, this message translates to:
  /// **'Camera access permission is required to use the QR code scanning feature. The camera is only used during QR code scanning and no images are recorded or shared.'**
  String get ppSection2Content;

  /// No description provided for @ppSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Storage Permission'**
  String get ppSection3Title;

  /// No description provided for @ppSection3Content.
  ///
  /// In en, this message translates to:
  /// **'Storage permission may be required to save QR codes as images. This permission is only used to save QR code images upon your request.'**
  String get ppSection3Content;

  /// No description provided for @ppSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Data Security'**
  String get ppSection4Title;

  /// No description provided for @ppSection4Content.
  ///
  /// In en, this message translates to:
  /// **'All your data is stored encrypted on your device. No personal information is shared with third parties.'**
  String get ppSection4Content;

  /// No description provided for @ppSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Advertisements'**
  String get ppSection5Title;

  /// No description provided for @ppSection5Content.
  ///
  /// In en, this message translates to:
  /// **'The app may display advertisements through Google AdMob. AdMob may use device information for ad delivery. For more information, please review Google\'s privacy policy.'**
  String get ppSection5Content;

  /// No description provided for @ppSection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Children\'s Privacy'**
  String get ppSection6Title;

  /// No description provided for @ppSection6Content.
  ///
  /// In en, this message translates to:
  /// **'Our app does not knowingly collect personal information from children under 13. Parents should supervise their children\'s use of the app.'**
  String get ppSection6Content;

  /// No description provided for @ppSection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Changes'**
  String get ppSection7Title;

  /// No description provided for @ppSection7Content.
  ///
  /// In en, this message translates to:
  /// **'This privacy policy may be updated from time to time. You will be notified within the app when significant changes occur.'**
  String get ppSection7Content;

  /// No description provided for @ppSection8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Contact'**
  String get ppSection8Title;

  /// No description provided for @ppSection8Content.
  ///
  /// In en, this message translates to:
  /// **'For questions about this privacy policy, please contact us.\n\nLast Updated: October 10, 2025'**
  String get ppSection8Content;

  /// No description provided for @tosSection1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance'**
  String get tosSection1Title;

  /// No description provided for @tosSection1Content.
  ///
  /// In en, this message translates to:
  /// **'By using the QR Scanner app, you agree to these terms of service. If you do not agree to these terms, please do not use the app.'**
  String get tosSection1Content;

  /// No description provided for @tosSection2Title.
  ///
  /// In en, this message translates to:
  /// **'2. License'**
  String get tosSection2Title;

  /// No description provided for @tosSection2Content.
  ///
  /// In en, this message translates to:
  /// **'You are granted a limited, non-transferable, non-exclusive license to use the QR Scanner app for personal, non-commercial use.'**
  String get tosSection2Content;

  /// No description provided for @tosSection3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Terms of Use'**
  String get tosSection3Title;

  /// No description provided for @tosSection3Content.
  ///
  /// In en, this message translates to:
  /// **'When using the app:\n\n• You will not create QR codes for illegal content\n• You will not violate the rights of others\n• You will not use the app maliciously\n• You will not share spam or harmful content'**
  String get tosSection3Content;

  /// No description provided for @tosSection4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Disclaimer'**
  String get tosSection4Title;

  /// No description provided for @tosSection4Content.
  ///
  /// In en, this message translates to:
  /// **'The app is provided \"as is\". We are not responsible for any damages that may arise from the content or use of QR codes.\n\nMake sure the QR codes you scan are safe. Be careful with QR codes from unknown sources.'**
  String get tosSection4Content;

  /// No description provided for @tosSection5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Content Responsibility'**
  String get tosSection5Title;

  /// No description provided for @tosSection5Content.
  ///
  /// In en, this message translates to:
  /// **'You are solely responsible for the content of the QR codes you create and scan. Do not create illegal or harmful content.'**
  String get tosSection5Content;

  /// No description provided for @tosSection6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Service Changes'**
  String get tosSection6Title;

  /// No description provided for @tosSection6Content.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to change the app\'s features, content, or availability without prior notice.'**
  String get tosSection6Content;

  /// No description provided for @tosSection7Title.
  ///
  /// In en, this message translates to:
  /// **'7. Account Suspension'**
  String get tosSection7Title;

  /// No description provided for @tosSection7Content.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to suspend or terminate your access to the app if you violate these terms.'**
  String get tosSection7Content;

  /// No description provided for @tosSection8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Intellectual Property'**
  String get tosSection8Title;

  /// No description provided for @tosSection8Content.
  ///
  /// In en, this message translates to:
  /// **'All content, design, and code of the app are protected by copyright. Unauthorized copying, distribution, or modification is prohibited.'**
  String get tosSection8Content;

  /// No description provided for @tosSection9Title.
  ///
  /// In en, this message translates to:
  /// **'9. Third-Party Links'**
  String get tosSection9Title;

  /// No description provided for @tosSection9Content.
  ///
  /// In en, this message translates to:
  /// **'The app may contain links to third-party websites or services. We are not responsible for the content or privacy practices of these sites.'**
  String get tosSection9Content;

  /// No description provided for @tosSection10Title.
  ///
  /// In en, this message translates to:
  /// **'10. Warranty Disclaimer'**
  String get tosSection10Title;

  /// No description provided for @tosSection10Content.
  ///
  /// In en, this message translates to:
  /// **'The app is provided without any warranty. We do not guarantee that it will operate uninterrupted or error-free.'**
  String get tosSection10Content;

  /// No description provided for @tosSection11Title.
  ///
  /// In en, this message translates to:
  /// **'11. Changes to Terms'**
  String get tosSection11Title;

  /// No description provided for @tosSection11Content.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to change these terms of service at any time. Significant changes will be announced within the app.'**
  String get tosSection11Content;

  /// No description provided for @tosSection12Title.
  ///
  /// In en, this message translates to:
  /// **'12. Contact'**
  String get tosSection12Title;

  /// No description provided for @tosSection12Content.
  ///
  /// In en, this message translates to:
  /// **'For questions about these terms of service, please contact us.\n\nLast Updated: October 10, 2025'**
  String get tosSection12Content;

  /// No description provided for @emailAppCannotOpen.
  ///
  /// In en, this message translates to:
  /// **'Cannot open email app'**
  String get emailAppCannotOpen;

  /// No description provided for @flashControlFailed.
  ///
  /// In en, this message translates to:
  /// **'Flash control failed'**
  String get flashControlFailed;

  /// No description provided for @cameraPermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Camera permission required'**
  String get cameraPermissionNeeded;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grantPermission;

  /// No description provided for @scannedQRCodes.
  ///
  /// In en, this message translates to:
  /// **'Scanned QR Codes'**
  String get scannedQRCodes;

  /// No description provided for @noQRScannedYet.
  ///
  /// In en, this message translates to:
  /// **'No QR codes scanned yet'**
  String get noQRScannedYet;

  /// No description provided for @scannedLabel.
  ///
  /// In en, this message translates to:
  /// **'Scanned'**
  String get scannedLabel;

  /// No description provided for @generatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get generatedLabel;

  /// No description provided for @flashOn.
  ///
  /// In en, this message translates to:
  /// **'Flash On'**
  String get flashOn;

  /// No description provided for @flashOff.
  ///
  /// In en, this message translates to:
  /// **'Flash Off'**
  String get flashOff;

  /// No description provided for @normalMode.
  ///
  /// In en, this message translates to:
  /// **'Normal Mode'**
  String get normalMode;

  /// No description provided for @batchScanMode.
  ///
  /// In en, this message translates to:
  /// **'Batch Scan'**
  String get batchScanMode;

  /// No description provided for @scannedCodesLabel.
  ///
  /// In en, this message translates to:
  /// **'Scanned Codes'**
  String get scannedCodesLabel;

  /// No description provided for @enterCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Or Enter Coordinates'**
  String get enterCoordinates;

  /// No description provided for @enterLocationName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a location name'**
  String get enterLocationName;

  /// No description provided for @cannotOpenMaps.
  ///
  /// In en, this message translates to:
  /// **'Cannot open Google Maps'**
  String get cannotOpenMaps;

  /// No description provided for @invalidCoordinateFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid coordinate format. Example: 41.0082, 28.9784'**
  String get invalidCoordinateFormat;

  /// No description provided for @shareError.
  ///
  /// In en, this message translates to:
  /// **'Share error'**
  String get shareError;

  /// No description provided for @urlCannotOpen.
  ///
  /// In en, this message translates to:
  /// **'Cannot open URL'**
  String get urlCannotOpen;

  /// No description provided for @bugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReport;

  /// No description provided for @reportBugsViaEmail.
  ///
  /// In en, this message translates to:
  /// **'Report bugs via email'**
  String get reportBugsViaEmail;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @usageStatistics.
  ///
  /// In en, this message translates to:
  /// **'Usage Statistics'**
  String get usageStatistics;

  /// No description provided for @totalEvents.
  ///
  /// In en, this message translates to:
  /// **'Total Events'**
  String get totalEvents;

  /// No description provided for @eventTypes.
  ///
  /// In en, this message translates to:
  /// **'Event Types'**
  String get eventTypes;

  /// No description provided for @mostCommon.
  ///
  /// In en, this message translates to:
  /// **'Most Common'**
  String get mostCommon;

  /// No description provided for @firstEvent.
  ///
  /// In en, this message translates to:
  /// **'First Event'**
  String get firstEvent;

  /// No description provided for @lastEvent.
  ///
  /// In en, this message translates to:
  /// **'Last Event'**
  String get lastEvent;

  /// No description provided for @clearAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Clear Analytics'**
  String get clearAnalytics;

  /// No description provided for @analyticsCleared.
  ///
  /// In en, this message translates to:
  /// **'Analytics data cleared'**
  String get analyticsCleared;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'el',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
