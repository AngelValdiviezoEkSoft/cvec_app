import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @titulo1Introduccion.
  ///
  /// In en, this message translates to:
  /// **'SAFE VACATIONS ALWAYS'**
  String get titulo1Introduccion;

  /// No description provided for @titulo2Introduccion.
  ///
  /// In en, this message translates to:
  /// **'¡PLAN AND ACHIEVE THE IMPOSSIBLE!'**
  String get titulo2Introduccion;

  /// No description provided for @hola.
  ///
  /// In en, this message translates to:
  /// **'¡Hello, {userName}!'**
  String hola(Object userName);

  /// No description provided for @bienvenidaLogin.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get bienvenidaLogin;

  /// No description provided for @bienvenidaCvec.
  ///
  /// In en, this message translates to:
  /// **'WELCOME TO CENTRO'**
  String get bienvenidaCvec;

  /// No description provided for @bienvenidaCvec2.
  ///
  /// In en, this message translates to:
  /// **' DE VIAJES ECUADOR {userName}'**
  String bienvenidaCvec2(Object userName);

  /// No description provided for @menuDestinations.
  ///
  /// In en, this message translates to:
  /// **'Destinations'**
  String get menuDestinations;

  /// No description provided for @menuMemberships.
  ///
  /// In en, this message translates to:
  /// **'Memberships'**
  String get menuMemberships;

  /// No description provided for @menuBuyYourLand.
  ///
  /// In en, this message translates to:
  /// **'Buy your land'**
  String get menuBuyYourLand;

  /// No description provided for @menuYourPlannedHome.
  ///
  /// In en, this message translates to:
  /// **'Your planned home'**
  String get menuYourPlannedHome;

  /// No description provided for @menuMagazine.
  ///
  /// In en, this message translates to:
  /// **'Magazine'**
  String get menuMagazine;

  /// No description provided for @userLbl.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userLbl;

  /// No description provided for @passwordLbl.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLbl;

  /// No description provided for @logInLbl.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logInLbl;

  /// No description provided for @barNavLogInLbl.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials'**
  String get barNavLogInLbl;

  /// No description provided for @menuAccountStatementLbl.
  ///
  /// In en, this message translates to:
  /// **'Account statements'**
  String get menuAccountStatementLbl;

  /// No description provided for @menuDebitsLbl.
  ///
  /// In en, this message translates to:
  /// **'Debits'**
  String get menuDebitsLbl;

  /// No description provided for @menuDebtsLbl.
  ///
  /// In en, this message translates to:
  /// **'Debts'**
  String get menuDebtsLbl;

  /// No description provided for @menuSendDepositsLbl.
  ///
  /// In en, this message translates to:
  /// **'Send Deposits'**
  String get menuSendDepositsLbl;

  /// No description provided for @menuPrintReceiptsLbl.
  ///
  /// In en, this message translates to:
  /// **'Print Receipts'**
  String get menuPrintReceiptsLbl;

  /// No description provided for @menuSeeReservationsLbl.
  ///
  /// In en, this message translates to:
  /// **'See Reservations'**
  String get menuSeeReservationsLbl;

  /// No description provided for @menuWebSiteLbl.
  ///
  /// In en, this message translates to:
  /// **'See Web Site'**
  String get menuWebSiteLbl;

  /// No description provided for @menuHelpSupportLbl.
  ///
  /// In en, this message translates to:
  /// **'Help and support'**
  String get menuHelpSupportLbl;

  /// No description provided for @menuLogOutLbl.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get menuLogOutLbl;

  /// No description provided for @receiptsLbl.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get receiptsLbl;

  /// No description provided for @reservationsLbl.
  ///
  /// In en, this message translates to:
  /// **'Reservation List'**
  String get reservationsLbl;

  /// No description provided for @menuReservationsLbl.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get menuReservationsLbl;

  /// No description provided for @searchLbl.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLbl;

  /// No description provided for @photoPaymentReceiptLbl.
  ///
  /// In en, this message translates to:
  /// **'Photo payment receipt'**
  String get photoPaymentReceiptLbl;

  /// No description provided for @amountLbl.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLbl;

  /// No description provided for @receiptNumberLbl.
  ///
  /// In en, this message translates to:
  /// **'Receipt number'**
  String get receiptNumberLbl;

  /// No description provided for @dateLbl.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLbl;

  /// No description provided for @conceptLbl.
  ///
  /// In en, this message translates to:
  /// **'Concept'**
  String get conceptLbl;

  /// No description provided for @notesLbl.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get notesLbl;

  /// No description provided for @paymentLbl.
  ///
  /// In en, this message translates to:
  /// **'Payment in'**
  String get paymentLbl;

  /// No description provided for @holderLbl.
  ///
  /// In en, this message translates to:
  /// **'Holder'**
  String get holderLbl;

  /// No description provided for @saveLbl.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLbl;

  /// No description provided for @cancelLbl.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLbl;

  /// No description provided for @confirmInfoDebLbl.
  ///
  /// In en, this message translates to:
  /// **'Do you confirm that all the data entered is correct?'**
  String get confirmInfoDebLbl;

  /// No description provided for @amountPaymentLbl.
  ///
  /// In en, this message translates to:
  /// **'Payment value'**
  String get amountPaymentLbl;

  /// No description provided for @confirmLbl.
  ///
  /// In en, this message translates to:
  /// **'Yes, continue'**
  String get confirmLbl;

  /// No description provided for @pendingReviewLbl.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingReviewLbl;

  /// No description provided for @approveReviewLbl.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approveReviewLbl;

  /// No description provided for @rejectedReviewLbl.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejectedReviewLbl;

  /// No description provided for @paymentDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Payment date'**
  String get paymentDateLbl;

  /// No description provided for @bankLbl.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bankLbl;

  /// No description provided for @commentsLbl.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get commentsLbl;

  /// No description provided for @paymentDetLbl.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get paymentDetLbl;

  /// No description provided for @detailLbl.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detailLbl;

  /// No description provided for @notUpdtPymntLbl.
  ///
  /// In en, this message translates to:
  /// **'Updated payment notification'**
  String get notUpdtPymntLbl;

  /// No description provided for @msmNotUpdtPymntLbl.
  ///
  /// In en, this message translates to:
  /// **'Your payment notification has changed status to Pending'**
  String get msmNotUpdtPymntLbl;

  /// No description provided for @msmValidateAmounLbl.
  ///
  /// In en, this message translates to:
  /// **'Please enter the amount'**
  String get msmValidateAmounLbl;

  /// No description provided for @myProfileLbl.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfileLbl;

  /// No description provided for @profileLbl.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileLbl;

  /// No description provided for @chngPasswLbl.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get chngPasswLbl;

  /// No description provided for @settingLbl.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get settingLbl;

  /// No description provided for @privPolLbl.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privPolLbl;

  /// No description provided for @termCondLbl.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termCondLbl;

  /// No description provided for @moreLbl.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreLbl;

  /// No description provided for @namLastNameLbl.
  ///
  /// In en, this message translates to:
  /// **'First and Last Name'**
  String get namLastNameLbl;

  /// No description provided for @idNumberLbl.
  ///
  /// In en, this message translates to:
  /// **'Identification number'**
  String get idNumberLbl;

  /// No description provided for @cellNumberLbl.
  ///
  /// In en, this message translates to:
  /// **'Cell phone'**
  String get cellNumberLbl;

  /// No description provided for @emailLbl.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLbl;

  /// No description provided for @directionLbl.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get directionLbl;

  /// No description provided for @altEmailLbl.
  ///
  /// In en, this message translates to:
  /// **'Alternative Email'**
  String get altEmailLbl;

  /// No description provided for @brDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get brDateLbl;

  /// No description provided for @languageLbl.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLbl;

  /// No description provided for @brightnessLbl.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightnessLbl;

  /// No description provided for @lghtModeLbl.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lghtModeLbl;

  /// No description provided for @drkModeLbl.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get drkModeLbl;

  /// No description provided for @automaticLbl.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automaticLbl;

  /// No description provided for @chngPsswLbl.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get chngPsswLbl;

  /// No description provided for @orderPsswFrmLbl.
  ///
  /// In en, this message translates to:
  /// **'Create a new password that is at least 8 characters long.'**
  String get orderPsswFrmLbl;

  /// No description provided for @enterNewPsswLbl.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPsswLbl;

  /// No description provided for @repeatNewPsswLbl.
  ///
  /// In en, this message translates to:
  /// **'Repeat your new password'**
  String get repeatNewPsswLbl;

  /// No description provided for @tabAlsDebsLbl.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tabAlsDebsLbl;

  /// No description provided for @searchContPlanLbl.
  ///
  /// In en, this message translates to:
  /// **'Search by contract plan'**
  String get searchContPlanLbl;

  /// No description provided for @totalLbl.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLbl;

  /// No description provided for @paidLbl.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLbl;

  /// No description provided for @balanceLbl.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceLbl;

  /// No description provided for @stateLbl.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get stateLbl;

  /// No description provided for @statePreContLbl.
  ///
  /// In en, this message translates to:
  /// **'Pre Contract'**
  String get statePreContLbl;

  /// No description provided for @stateFinishedLbl.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get stateFinishedLbl;

  /// No description provided for @stateActiveLbl.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get stateActiveLbl;

  /// No description provided for @stateOpenLbl.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get stateOpenLbl;

  /// No description provided for @stateAnullLbl.
  ///
  /// In en, this message translates to:
  /// **'Anulalled'**
  String get stateAnullLbl;

  /// No description provided for @stateClosLbl.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get stateClosLbl;

  /// No description provided for @statePreLiqLbl.
  ///
  /// In en, this message translates to:
  /// **'Pre Liquidated'**
  String get statePreLiqLbl;

  /// No description provided for @stateLiquidationLbl.
  ///
  /// In en, this message translates to:
  /// **'Liquidated'**
  String get stateLiquidationLbl;

  /// No description provided for @stateFinalizedLbl.
  ///
  /// In en, this message translates to:
  /// **'Finalized'**
  String get stateFinalizedLbl;

  /// No description provided for @statePaidLbl.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statePaidLbl;

  /// No description provided for @fontSizeLbl.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSizeLbl;

  /// No description provided for @serverLbl.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get serverLbl;

  /// No description provided for @keyLbl.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get keyLbl;

  /// No description provided for @welcomeLbl.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeLbl;

  /// No description provided for @beginLbl.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get beginLbl;

  /// No description provided for @msmWelcomeLbl.
  ///
  /// In en, this message translates to:
  /// **'Log in or create your account below and start your journey.'**
  String get msmWelcomeLbl;

  /// No description provided for @stateOpenQuotaAccountStatementLbl.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get stateOpenQuotaAccountStatementLbl;

  /// No description provided for @statePaidQuotaAccountStatementLbl.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statePaidQuotaAccountStatementLbl;

  /// No description provided for @stateAnnulledQuotaAccountStatementLbl.
  ///
  /// In en, this message translates to:
  /// **'Annulled'**
  String get stateAnnulledQuotaAccountStatementLbl;

  /// No description provided for @dueDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDateLbl;

  /// No description provided for @descriptionLbl.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLbl;

  /// No description provided for @installmentAmountLbl.
  ///
  /// In en, this message translates to:
  /// **'Quote Amount'**
  String get installmentAmountLbl;

  /// No description provided for @installmentStatusLbl.
  ///
  /// In en, this message translates to:
  /// **'Quote Status'**
  String get installmentStatusLbl;

  /// No description provided for @receiptLbl.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receiptLbl;

  /// No description provided for @paymentMethodLbl.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodLbl;

  /// No description provided for @amountPaidLbl.
  ///
  /// In en, this message translates to:
  /// **'Amount Paid'**
  String get amountPaidLbl;

  /// No description provided for @paymentStatusLbl.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatusLbl;

  /// No description provided for @accountStatusReportLbl.
  ///
  /// In en, this message translates to:
  /// **'Account status report'**
  String get accountStatusReportLbl;

  /// No description provided for @customerLbl.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerLbl;

  /// No description provided for @orderValidatePasswordLbl.
  ///
  /// In en, this message translates to:
  /// **'Your password must contain at least'**
  String get orderValidatePasswordLbl;

  /// No description provided for @capitalLetterValidatePasswordLbl.
  ///
  /// In en, this message translates to:
  /// **'A capital letter'**
  String get capitalLetterValidatePasswordLbl;

  /// No description provided for @lowerLetterValidatePasswordLbl.
  ///
  /// In en, this message translates to:
  /// **'A lowercase letter'**
  String get lowerLetterValidatePasswordLbl;

  /// No description provided for @numberValidatePasswordLbl.
  ///
  /// In en, this message translates to:
  /// **'A number'**
  String get numberValidatePasswordLbl;

  /// No description provided for @specialCharacterValidatePasswordLbl.
  ///
  /// In en, this message translates to:
  /// **'A special character'**
  String get specialCharacterValidatePasswordLbl;

  /// No description provided for @minimumTenCharacterValidatePasswordLbl.
  ///
  /// In en, this message translates to:
  /// **'Minimum 10 characters'**
  String get minimumTenCharacterValidatePasswordLbl;

  /// No description provided for @msmLog1Lbl.
  ///
  /// In en, this message translates to:
  /// **'We are validating'**
  String get msmLog1Lbl;

  /// No description provided for @msmLog2Lbl.
  ///
  /// In en, this message translates to:
  /// **'your credentials'**
  String get msmLog2Lbl;

  /// No description provided for @msmSafeLbl.
  ///
  /// In en, this message translates to:
  /// **'We are recording'**
  String get msmSafeLbl;

  /// No description provided for @msmSafePayLbl.
  ///
  /// In en, this message translates to:
  /// **'your payment'**
  String get msmSafePayLbl;

  /// No description provided for @msmSafeDeviceLbl.
  ///
  /// In en, this message translates to:
  /// **'your device'**
  String get msmSafeDeviceLbl;

  /// No description provided for @msmUpdateLbl.
  ///
  /// In en, this message translates to:
  /// **'We are updating'**
  String get msmUpdateLbl;

  /// No description provided for @msmSafeInfoProfLbl.
  ///
  /// In en, this message translates to:
  /// **'your information'**
  String get msmSafeInfoProfLbl;

  /// No description provided for @reservReportLbl.
  ///
  /// In en, this message translates to:
  /// **'Reservation Report'**
  String get reservReportLbl;

  /// No description provided for @reservSeqLbl.
  ///
  /// In en, this message translates to:
  /// **'Reservation Sequence'**
  String get reservSeqLbl;

  /// No description provided for @checkInDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Check-in Date'**
  String get checkInDateLbl;

  /// No description provided for @checkInLbl.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkInLbl;

  /// No description provided for @checkOutDateLbl.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get checkOutDateLbl;

  /// No description provided for @checkOutLbl.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get checkOutLbl;

  /// No description provided for @hotelLbl.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotelLbl;

  /// No description provided for @includesLbl.
  ///
  /// In en, this message translates to:
  /// **'Includes'**
  String get includesLbl;

  /// No description provided for @contractSeqLbl.
  ///
  /// In en, this message translates to:
  /// **'Contract Sequence'**
  String get contractSeqLbl;

  /// No description provided for @roomsLbl.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get roomsLbl;

  /// No description provided for @statusLbl.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLbl;

  /// No description provided for @categoryLbl.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLbl;

  /// No description provided for @adminServLbl.
  ///
  /// In en, this message translates to:
  /// **'Administrative Services'**
  String get adminServLbl;

  /// No description provided for @observationLbl.
  ///
  /// In en, this message translates to:
  /// **'Observation'**
  String get observationLbl;

  /// No description provided for @authSignatLbl.
  ///
  /// In en, this message translates to:
  /// **'Authorized signature'**
  String get authSignatLbl;

  /// No description provided for @clientSignatLbl.
  ///
  /// In en, this message translates to:
  /// **'Client signature'**
  String get clientSignatLbl;

  /// No description provided for @persRespAdmLbl.
  ///
  /// In en, this message translates to:
  /// **'Person responsible for admission'**
  String get persRespAdmLbl;

  /// No description provided for @thkYourPaymentLbl.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your payment'**
  String get thkYourPaymentLbl;

  /// No description provided for @establishmentLbl.
  ///
  /// In en, this message translates to:
  /// **'Establishment'**
  String get establishmentLbl;

  /// No description provided for @officeLbl.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get officeLbl;

  /// No description provided for @phoneLbl.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLbl;

  /// No description provided for @orderQrLbl.
  ///
  /// In en, this message translates to:
  /// **'Frame the QR code within the purple frame'**
  String get orderQrLbl;

  /// No description provided for @pleaseWaitLbl.
  ///
  /// In en, this message translates to:
  /// **'Please Wait'**
  String get pleaseWaitLbl;

  /// No description provided for @enterLbl.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enterLbl;

  /// No description provided for @noDataLbl.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noDataLbl;

  /// No description provided for @logoutMsmLbl.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutMsmLbl;

  /// No description provided for @confirmOnlyLbl.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get confirmOnlyLbl;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
