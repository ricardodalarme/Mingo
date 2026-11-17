///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEn({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => _meta.getTranslation(key) ?? super[key];

  late final TranslationsEn _root = this; // ignore: unused_field

  @override
  TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsEn(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _Translations$acceptInvite$en acceptInvite = _Translations$acceptInvite$en._(_root);
  @override
  late final _Translations$account$en account = _Translations$account$en._(_root);
  @override
  late final _Translations$agreements$en agreements = _Translations$agreements$en._(_root);
  @override
  late final _Translations$annoyanceCheck$en annoyanceCheck = _Translations$annoyanceCheck$en._(
    _root,
  );
  @override
  late final _Translations$authentication$en authentication = _Translations$authentication$en._(
    _root,
  );
  @override
  late final _Translations$capsules$en capsules = _Translations$capsules$en._(_root);
  @override
  late final _Translations$cardSettings$en cardSettings = _Translations$cardSettings$en._(_root);
  @override
  late final _Translations$cardView$en cardView = _Translations$cardView$en._(_root);
  @override
  late final _Translations$cardsList$en cardsList = _Translations$cardsList$en._(_root);
  @override
  late final _Translations$chat$en chat = _Translations$chat$en._(_root);
  @override
  late final _Translations$checkin$en checkin = _Translations$checkin$en._(_root);
  @override
  late final _Translations$common$en common = _Translations$common$en._(_root);
  @override
  late final _Translations$connectTouch$en connectTouch = _Translations$connectTouch$en._(_root);
  @override
  late final _Translations$connectUs$en connectUs = _Translations$connectUs$en._(_root);
  @override
  late final _Translations$createAccount$en createAccount = _Translations$createAccount$en._(_root);
  @override
  late final _Translations$dateNight$en dateNight = _Translations$dateNight$en._(_root);
  @override
  late final _Translations$dates$en dates = _Translations$dates$en._(_root);
  @override
  late final _Translations$day$en day = _Translations$day$en._(_root);
  @override
  late final _Translations$debugSignIn$en debugSignIn = _Translations$debugSignIn$en._(_root);
  @override
  late final _Translations$devices$en devices = _Translations$devices$en._(_root);
  @override
  late final _Translations$distance$en distance = _Translations$distance$en._(_root);
  @override
  late final _Translations$fightStyle$en fightStyle = _Translations$fightStyle$en._(_root);
  @override
  late final _Translations$firstSlip$en firstSlip = _Translations$firstSlip$en._(_root);
  @override
  late final _Translations$games$en games = _Translations$games$en._(_root);
  @override
  late final _Translations$gentleRequest$en gentleRequest = _Translations$gentleRequest$en._(_root);
  @override
  late final _Translations$gentleRequestDetail$en gentleRequestDetail =
      _Translations$gentleRequestDetail$en._(_root);
  @override
  late final _Translations$gifts$en gifts = _Translations$gifts$en._(_root);
  @override
  late final _Translations$globalErrors$en globalErrors = _Translations$globalErrors$en._(_root);
  @override
  late final _Translations$griefSupport$en griefSupport = _Translations$griefSupport$en._(_root);
  @override
  late final _Translations$guides$en guides = _Translations$guides$en._(_root);
  @override
  late final _Translations$hardConversation$en hardConversation =
      _Translations$hardConversation$en._(_root);
  @override
  late final _Translations$help$en help = _Translations$help$en._(_root);
  @override
  late final _Translations$helpSupport$en helpSupport = _Translations$helpSupport$en._(_root);
  @override
  late final _Translations$history$en history = _Translations$history$en._(_root);
  @override
  late final _Translations$ideaDetail$en ideaDetail = _Translations$ideaDetail$en._(_root);
  @override
  late final _Translations$inbox$en inbox = _Translations$inbox$en._(_root);
  @override
  late final _Translations$intro$en intro = _Translations$intro$en._(_root);
  @override
  late final _Translations$invite$en invite = _Translations$invite$en._(_root);
  @override
  late final _Translations$language$en language = _Translations$language$en._(_root);
  @override
  late final _Translations$learned$en learned = _Translations$learned$en._(_root);
  @override
  late final _Translations$lists$en lists = _Translations$lists$en._(_root);
  @override
  late final _Translations$logistics$en logistics = _Translations$logistics$en._(_root);
  @override
  late final _Translations$loveStyle$en loveStyle = _Translations$loveStyle$en._(_root);
  @override
  late final _Translations$memories$en memories = _Translations$memories$en._(_root);
  @override
  late final _Translations$mood$en mood = _Translations$mood$en._(_root);
  @override
  late final _Translations$moodHelp$en moodHelp = _Translations$moodHelp$en._(_root);
  @override
  late final _Translations$need$en need = _Translations$need$en._(_root);
  @override
  late final _Translations$notFound$en notFound = _Translations$notFound$en._(_root);
  @override
  late final _Translations$notes$en notes = _Translations$notes$en._(_root);
  @override
  late final _Translations$notificationPermission$en notificationPermission =
      _Translations$notificationPermission$en._(_root);
  @override
  late final _Translations$notificationPreferences$en notificationPreferences =
      _Translations$notificationPreferences$en._(_root);
  @override
  late final _Translations$partnerProfile$en partnerProfile = _Translations$partnerProfile$en._(
    _root,
  );
  @override
  late final _Translations$partnerStep$en partnerStep = _Translations$partnerStep$en._(_root);
  @override
  late final _Translations$plus$en plus = _Translations$plus$en._(_root);
  @override
  late final _Translations$privacy$en privacy = _Translations$privacy$en._(_root);
  @override
  late final _Translations$profileDetails$en profileDetails = _Translations$profileDetails$en._(
    _root,
  );
  @override
  late final _Translations$profileSetup$en profileSetup = _Translations$profileSetup$en._(_root);
  @override
  late final _Translations$programs$en programs = _Translations$programs$en._(_root);
  @override
  late final _Translations$pronouns$en pronouns = _Translations$pronouns$en._(_root);
  @override
  late final _Translations$questions$en questions = _Translations$questions$en._(_root);
  @override
  late final _Translations$questionsEntry$en questionsEntry = _Translations$questionsEntry$en._(
    _root,
  );
  @override
  late final _Translations$quickSlip$en quickSlip = _Translations$quickSlip$en._(_root);
  @override
  late final _Translations$quizzes$en quizzes = _Translations$quizzes$en._(_root);
  @override
  late final _Translations$received$en received = _Translations$received$en._(_root);
  @override
  late final _Translations$relationshipChanged$en relationshipChanged =
      _Translations$relationshipChanged$en._(_root);
  @override
  late final _Translations$relationshipSettings$en relationshipSettings =
      _Translations$relationshipSettings$en._(_root);
  @override
  late final _Translations$reminders$en reminders = _Translations$reminders$en._(_root);
  @override
  late final _Translations$repair$en repair = _Translations$repair$en._(_root);
  @override
  late final _Translations$rituals$en rituals = _Translations$rituals$en._(_root);
  @override
  late final _Translations$sessionExpired$en sessionExpired = _Translations$sessionExpired$en._(
    _root,
  );
  @override
  late final _Translations$settingsHome$en settingsHome = _Translations$settingsHome$en._(_root);
  @override
  late final _Translations$share$en share = _Translations$share$en._(_root);
  @override
  late final _Translations$slipDetail$en slipDetail = _Translations$slipDetail$en._(_root);
  @override
  late final _Translations$slipKind$en slipKind = _Translations$slipKind$en._(_root);
  @override
  late final _Translations$slipsList$en slipsList = _Translations$slipsList$en._(_root);
  @override
  late final _Translations$spice$en spice = _Translations$spice$en._(_root);
  @override
  late final _Translations$story$en story = _Translations$story$en._(_root);
  @override
  late final _Translations$sundayCard$en sundayCard = _Translations$sundayCard$en._(_root);
  @override
  late final _Translations$tabs$en tabs = _Translations$tabs$en._(_root);
  @override
  late final _Translations$temperature$en temperature = _Translations$temperature$en._(_root);
  @override
  late final _Translations$timeInApp$en timeInApp = _Translations$timeInApp$en._(_root);
  @override
  late final _Translations$today$en today = _Translations$today$en._(_root);
  @override
  late final _Translations$unpair$en unpair = _Translations$unpair$en._(_root);
  @override
  late final _Translations$weeklyReview$en weeklyReview = _Translations$weeklyReview$en._(_root);
  @override
  late final _Translations$welcome$en welcome = _Translations$welcome$en._(_root);
  @override
  late final _Translations$widgets$en widgets = _Translations$widgets$en._(_root);
}

// Path: acceptInvite
class _Translations$acceptInvite$en extends Translations$acceptInvite$pt {
  _Translations$acceptInvite$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Got an invite?';
  @override
  String get titleHighlight => 'invite';
  @override
  String get connectTitle => 'Connect with a code';
  @override
  String get subtitle => 'Type the code the other person sent so you can connect.';
  @override
  String get codeLabel => 'Invite code';
  @override
  String get codeHint => 'E.g. ABCD2345';
  @override
  Map<String, String> get codeErrors => {
    'empty': 'Type the invite code.',
    'tooShort': 'The code has 8 characters.',
    'tooLong': 'The code has 8 characters.',
    'invalid': 'Use letters and numbers only.',
  };
  @override
  String get privacyNote => 'Accepting shares cards and tools. Your private notes stay private.';
  @override
  String get accept => 'Accept';
  @override
  late final _Translations$acceptInvite$connected$en connected =
      _Translations$acceptInvite$connected$en._(_root);
  @override
  late final _Translations$acceptInvite$unusable$en unusable =
      _Translations$acceptInvite$unusable$en._(_root);
  @override
  String get ownCodeTitle => 'That code is yours';
  @override
  String get ownCodeHighlight => 'yours';
  @override
  String get ownCodeText => 'That is your own code. To connect, use your partner\'s code.';
  @override
  Map<String, String> get errors => {
    'ALREADY_PAIRED': 'You are already connected with someone.',
    'COUPLE_FULL': 'That space already has two people.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a bit and try again.',
    'NETWORK': 'No connection. Check your internet and try again.',
    'other': 'Could not connect right now. Try again.',
  };
  @override
  String headline({required Object name}) => 'Connect with ${name}';
  @override
  String get headlineNoName => 'Connect with your person';
  @override
  String get headlineNoNameHighlight => 'your person';
  @override
  String get pageSubtitle => 'Both already use the app? One invites and the other types the code.';
  @override
  String get segmentHaveCode => 'I have a code';
  @override
  String get segmentInvite => 'I want to invite';
  @override
  String get connectAction => 'Connect';
  @override
  String get ownCodeLabel => 'Your invite code';
  @override
  String get ownCodeNote =>
      'Send this code to your person. What each of you has written so far stays private.';
}

// Path: account
class _Translations$account$en extends Translations$account$pt {
  _Translations$account$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get deleteTitle => 'Delete account';
  @override
  String get deleteHighlight => 'account';
  @override
  String get deleteText => 'Your data is erased after 30 days. This needs a fresh sign-in.';
  @override
  String get deleteWarningTitle => 'This also ends the link';
  @override
  String deleteWarning({required Object name}) => 'This also ends the link with ${name}.';
  @override
  String get deleteWarningNoPartner => 'This also ends the link with your partner.';
  @override
  String get deleteAction => 'Delete account';
  @override
  String get deleteConfirmTitle => 'Delete your account?';
  @override
  String get deleteConfirmText =>
      'You have 30 days to change your mind. After that, nothing can be recovered.';
  @override
  String get reauthReason => 'Confirm to delete your account.';
  @override
  String pendingTitle({required Object month, required Object day}) =>
      'Deletion on ${month} ${day}';
  @override
  String pendingHighlight({required Object month, required Object day}) => '${month} ${day}';
  @override
  String get pendingText => 'You can cancel before that.';
  @override
  String get pendingCancel => 'Cancel deletion';
  @override
  String get signOutTitle => 'Sign out?';
  @override
  String get signOutText => 'Remove the local data too?';
  @override
  String signOutPending({required Object count}) =>
      'You have ${count} slips that were not sent yet. Signing out and removing data erases them.';
  @override
  String get signOut => 'Sign out';
  @override
  String get signOutRemove => 'Sign out and remove data';
  @override
  List<String> get months => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'Could not finish now. Try again.',
  };
  @override
  late final _Translations$account$export$en export = _Translations$account$export$en._(_root);
}

// Path: agreements
class _Translations$agreements$en extends Translations$agreements$pt {
  _Translations$agreements$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Agreements';
  @override
  String get add => 'New agreement';
  @override
  String get addTitle => 'New agreement';
  @override
  String get bodyLabel => 'What you agree on';
  @override
  String get bodyHint => 'E.g. Talk about money once a month';
  @override
  Map<String, String> get bodyErrors => {
    'empty': 'Write the agreement.',
    'tooLong': 'Use 200 characters at most.',
  };
  @override
  String get propose => 'Propose';
  @override
  String get confirm => 'Confirm';
  @override
  String get options => 'Agreement options';
  @override
  String get subtitleShared =>
      'Short sentences you agree on. They only count once the other person confirms.';
  @override
  String get subtitlePrivate =>
      'Notes for yourself. When someone joins you they become agreements.';
  @override
  String get emptyTitle => 'No agreements yet';
  @override
  String get emptyTextShared => 'Agree on something small and ask the other person to confirm.';
  @override
  String get emptyTextPrivate => 'Note something you would like to agree on.';
  @override
  String get statusPrivate => 'Only you see it';
  @override
  String get statusConfirmed => 'Confirmed by both';
  @override
  String get statusWaitingPartner => 'Waiting for the other person';
  @override
  String get statusWaitingYou => 'Waiting for you';
  @override
  String get archiveTitle => 'Put this agreement away?';
  @override
  String get archiveTextShared => 'It leaves the list for both of you.';
  @override
  String get archiveTextPrivate => 'It leaves your list.';
  @override
  String get archiveConfirm => 'Put away';
  @override
  String get metaShared => 'What you agreed on';
  @override
  String get metaPrivate => 'Notes for yourself';
  @override
  Map<String, String> get errors => {
    'FREE_LIMIT_REACHED':
        'You reached the free plan limit of agreements. Put one away or see Plus.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not finish that now. Try again.',
  };
}

// Path: annoyanceCheck
class _Translations$annoyanceCheck$en extends Translations$annoyanceCheck$pt {
  _Translations$annoyanceCheck$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Does this still bother you?';
  @override
  String get titleHighlight => 'bother';
  @override
  String age({required Object days, required Object left}) =>
      'You wrote it ${days} days ago · gone in ${left} days';
  @override
  String get talkTitle => 'Talk about it';
  @override
  String get talkText => 'Write a gentle request';
  @override
  String get chatTitle => 'Talk to the chat';
  @override
  String get chatText => 'Only you and the chat';
  @override
  String get letGoTitle => 'Let it go';
  @override
  String get letGoText => 'Delete now, without telling anyone';
  @override
  String get note =>
      'Good things stay forever. What bothered you goes away on its own if you do nothing.';
  @override
  String get letGoConfirmTitle => 'Let it go?';
  @override
  String get letGoConfirmText => 'The note is deleted now and nobody is told.';
  @override
  String get letGoConfirm => 'Delete now';
  @override
  String get letGoDone => 'Note deleted';
  @override
  String get goneTitle => 'That note is gone';
  @override
  String get goneText => 'It expired, was deleted or became a request.';
  @override
  String get close => 'Close';
  @override
  String get errorTitle => 'We could not open the note';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Something went wrong. Try again.',
  };
}

// Path: authentication
class _Translations$authentication$en extends Translations$authentication$pt {
  _Translations$authentication$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get signInTitle => 'Sign in';
  @override
  String get signInSubtitle => 'No email and password. Just Apple or Google.';
  @override
  String get signInNote => 'Signing in takes you straight to your Today.';
  @override
  String get emailSignInFallback => 'Sign in with email and password';
  @override
  String get existingAccountTitle => 'You already have an account';
  @override
  String get existingAccountSubtitle => 'Sign in to pick up where you left off.';
  @override
  String get continueWithApple => 'Continue with Apple';
  @override
  String get continueWithGoogle => 'Continue with Google';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Check your internet and try again.',
    'anonymous_provider_disabled': 'Signing in without an account is off right now.',
    'bad_code_verifier': 'Sign in again to continue.',
    'bad_json': 'Something went wrong. Try again.',
    'bad_jwt': 'Your session ended. Sign in again.',
    'bad_oauth_callback': 'Sign in again to continue.',
    'bad_oauth_state': 'Sign in again to continue.',
    'captcha_failed': 'We could not confirm you are human. Try again.',
    'conflict': 'That did not go through. Try again.',
    'email_address_invalid': 'That email address is not valid.',
    'email_address_not_authorized': 'We cannot send email to that address yet.',
    'email_conflict_identity_not_deletable':
        'This is your only way to sign in, so it cannot be removed.',
    'email_exists': 'This email already has an account.',
    'email_not_confirmed': 'Confirm your email before signing in.',
    'email_provider_disabled': 'New email accounts are closed right now.',
    'flow_state_expired': 'Sign in again to continue.',
    'flow_state_not_found': 'Sign in again to continue.',
    'hook_payload_invalid_content_type': 'Something went wrong. Try again.',
    'hook_payload_over_size_limit': 'Something went wrong. Try again.',
    'hook_timeout': 'That took too long. Try again.',
    'hook_timeout_after_retry': 'That took too long. Try again.',
    'identity_already_exists': 'This account is already linked.',
    'identity_not_found': 'That sign-in method is no longer linked.',
    'insufficient_aal': 'Finish the extra security step first.',
    'invalid_credentials': 'Email or password is incorrect.',
    'invite_not_found': 'This invite expired or was already used.',
    'manual_linking_disabled': 'Linking accounts is off right now.',
    'mfa_challenge_expired': 'That check expired. Try again.',
    'mfa_factor_name_conflict': 'You already have a security key with that name.',
    'mfa_factor_not_found': 'That security key is no longer set up.',
    'mfa_ip_address_mismatch': 'Start and finish setup on the same connection.',
    'mfa_phone_enroll_not_enabled': 'Phone verification is off right now.',
    'mfa_phone_verify_not_enabled': 'Phone verification is off right now.',
    'mfa_totp_enroll_not_enabled': 'Authenticator codes are off right now.',
    'mfa_totp_verify_not_enabled': 'Authenticator codes are off right now.',
    'mfa_verification_failed': 'That code is not right. Try again.',
    'mfa_verification_rejected': 'We could not verify that. Try again later.',
    'mfa_verified_factor_exists': 'This phone is already set up for verification.',
    'mfa_web_authn_enroll_not_enabled': 'Passkey setup is off right now.',
    'mfa_web_authn_verify_not_enabled': 'Passkeys are off right now.',
    'no_authorization': 'Your session ended. Sign in again.',
    'oauth_provider_not_supported': 'That sign-in option is not available.',
    'otp_disabled': 'Sign-in codes are off right now.',
    'otp_expired': 'That code expired. Ask for a new one.',
    'over_email_send_rate_limit': 'Too many emails sent. Wait a bit and try again.',
    'over_request_rate_limit': 'Too many tries in a row. Wait a moment and try again.',
    'over_sms_send_rate_limit': 'Too many texts sent. Wait a bit and try again.',
    'phone_exists': 'This phone number already has an account.',
    'phone_not_confirmed': 'Confirm your phone number before signing in.',
    'phone_provider_disabled': 'New phone accounts are closed right now.',
    'provider_disabled': 'That sign-in option is not available.',
    'provider_email_needs_verification': 'Check your email to finish signing in.',
    'reauthentication_needed': 'Sign in again to continue.',
    'reauthentication_not_valid': 'That code is not right. Try again.',
    'refresh_token_already_used': 'Your session ended. Sign in again.',
    'refresh_token_not_found': 'Your session ended. Sign in again.',
    'request_timeout': 'That took too long. Try again.',
    'same_password': 'Choose a password you have not used here.',
    'saml_assertion_no_email': 'Your organization did not share an email. Contact them.',
    'saml_assertion_no_user_id': 'Your organization did not share an ID. Contact them.',
    'saml_idp_not_found': 'Your organization\'s sign-in is not set up.',
    'saml_provider_disabled': 'Organization sign-in is off right now.',
    'saml_relay_state_expired': 'Sign in again to continue.',
    'saml_relay_state_not_found': 'Sign in again to continue.',
    'session_expired': 'Your session ended. Sign in again.',
    'session_not_found': 'Your session ended. Sign in again.',
    'signup_disabled': 'New accounts are closed right now.',
    'single_identity_not_deletable': 'This is your only way to sign in, so it cannot be removed.',
    'sms_send_failed': 'We could not send the text. Try again.',
    'sso_provider_not_found': 'Your organization\'s sign-in is not set up.',
    'too_many_enrolled_mfa_factors': 'You have reached the limit of security keys.',
    'unexpected_failure': 'Something went wrong. Try again.',
    'user_already_exists': 'This account already exists.',
    'user_banned': 'This account is not available right now.',
    'user_not_found': 'We could not find that account.',
    'user_sso_managed': 'Your organization manages this account.',
    'validation_failed': 'Check the information and try again.',
    'weak_password': 'Choose a stronger password.',
    'other': 'Could not sign you in right now. Try again.',
  };
  @override
  String legal({required Object terms, required Object privacy}) =>
      'By continuing, you confirm you are 18 or older and agree to the ${terms} and the ${privacy}.';
  @override
  String get legalTerms => 'Terms';
  @override
  String get legalPrivacy => 'Privacy Policy';
  @override
  String get legalPlain =>
      'By continuing, you confirm you are 18 or older and agree to the Terms and the Privacy Policy.';
  @override
  String get tryAgain => 'Try again';
}

// Path: capsules
class _Translations$capsules$en extends Translations$capsules$pt {
  _Translations$capsules$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Time capsule';
  @override
  String get text =>
      'Write something to be opened on a future date. Until then nobody reads it, not even you.';
  @override
  String get bodyHint => 'What do you want to say to the future?';
  @override
  Map<String, String> get bodyErrors => {
    'empty': 'Write the message',
    'tooLong': 'The message is too long',
  };
  @override
  String get dateLabel => 'Opens on';
  @override
  String get dateHint => 'Pick a date';
  @override
  Map<String, String> get dateErrors => {
    'empty': 'Pick the day it opens',
    'outOfRange': 'Pick a date between a week and 50 years ahead',
  };
  @override
  String dateFormat({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String get sharedLabel => 'For both of us';
  @override
  String get sharedText => 'Your partner reads it too when the date comes. Off, only you read it.';
  @override
  String get save => 'Save capsule';
  @override
  String get saved => 'Capsule saved';
  @override
  String closedUntil({required Object date}) => 'Closed until ${date}';
  @override
  String get ownerSharedBy => 'Yours, for both';
  @override
  String get ownerPrivate => 'Only yours';
  @override
  String get fromPartner => 'From your partner';
  @override
  String get delete => 'Delete';
  @override
  String get deleteTitle => 'Delete this capsule?';
  @override
  String get deleteText => 'It will be gone before anyone reads it. This cannot be undone.';
  @override
  String get deleteConfirm => 'Delete';
  @override
  String get emptyTitle => 'No capsules yet';
  @override
  String get emptyText => 'Write one and choose the day it opens.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your capsules are still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'CAPSULE_OPENS_TOO_SOON': 'Pick a date at least a week ahead.',
    'CAPSULE_OPENS_TOO_FAR': 'Pick a date within the next 50 years.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your text is still here.',
  };
  @override
  Map<String, String> get deleteErrors => {
    'other': 'Couldn\'t delete this capsule. It\'s still here.',
  };
}

// Path: cardSettings
class _Translations$cardSettings$en extends Translations$cardSettings$pt {
  _Translations$cardSettings$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Weekly card';
  @override
  String get day => 'Day';
  @override
  String get hour => 'Time';
  @override
  String get defaultTitle => 'New slips go on the card';
  @override
  String get defaultSubtitle => 'Each slip can change this later.';
  @override
  String get note => 'Changes apply to the next card.';
  @override
  String get saveError => 'Could not save. Your earlier choice was kept.';
  @override
  String get errorTitle => 'We could not open the settings';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Your choices are still saved. Try again.',
  };
  @override
  String get open => 'Card settings';
}

// Path: cardView
class _Translations$cardView$en extends Translations$cardView$pt {
  _Translations$cardView$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String forPartner({required Object name}) => 'For ${name}';
  @override
  String get forPartnerNoName => 'For your person';
  @override
  String goodThings({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        zero: 'No good things yet',
        one: '1 good thing this week',
        other: '${count} good things this week',
      );
  @override
  List<String> get weekdays => ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  @override
  Map<String, String> get categories => {
    'said': 'said something',
    'did': 'did something',
    'noticed': 'noticed me',
    'helped': 'helped me',
    'other': '',
  };
}

// Path: cardsList
class _Translations$cardsList$en extends Translations$cardsList$pt {
  _Translations$cardsList$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Past cards';
  @override
  String dateShort({required Object month, required Object day}) => '${month} ${day}';
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String slipCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        zero: 'no slips',
        one: '1 slip',
        other: '${count} slips',
      );
  @override
  String get sent => 'Sent';
  @override
  String get received => 'Received';
  @override
  String get opened => 'opened';
  @override
  String get reacted => 'reaction';
  @override
  String get replied => 'replied';
  @override
  String get emptyTitle => 'No cards yet';
  @override
  String get emptyText => 'When a card is sent or arrives, it shows up here. No rush.';
  @override
  String get errorTitle => 'Could not load the cards';
  @override
  String get errorText => 'They are still saved. Try again.';
  @override
  String get detailTitle => 'Card';
  @override
  String get detailErrorTitle => 'Could not open the card';
  @override
  Map<String, String> get errors => {
    'CARD_NOT_FOUND': 'That card is no longer available.',
    'other': 'It is still saved. Try again.',
  };
  @override
  String get reactionPrompt => 'How do you want to reply?';
  @override
  String get reactionThankYou => 'Thank you';
  @override
  String get reactionHug => 'Hug';
  @override
  String get reactionMadeMyDay => 'Made my day';
  @override
  String get reactionNoted => 'Noted';
  @override
  String get reactionError => 'Could not reply right now. Try again.';
  @override
  String responseReceivedName({required Object name}) => '${name}';
  @override
  String get responseReceivedNoName => 'Your person replied';
  @override
  String get responseReceivedVerb => 'replied';
  @override
  String responseQuote({required Object label}) => '“${label}”';
  @override
  String get notFound => 'That card is no longer available.';
  @override
  String get reactionQuoteMadeMyDay => 'That made my week.';
}

// Path: chat
class _Translations$chat$en extends Translations$chat$pt {
  _Translations$chat$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Mascot';
  @override
  String get inputHint => 'Write here';
  @override
  Map<String, String> get draftErrors => {
    'empty': 'Write something to send',
    'tooLong': 'This message is too long',
  };
  @override
  String get send => 'Send';
  @override
  String messagesLeft({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 message left today',
        other: '${count} messages left today',
      );
  @override
  String get saveAsSlip => 'Make it a slip';
  @override
  String get slipSaved => 'Slip saved';
  @override
  String get saveLearning => 'Save as learning';
  @override
  String get learningSheetTitle => 'Save as learning';
  @override
  String get learningSheetTarget => 'What is it about?';
  @override
  String get learningTargetError => 'Pick what this is about.';
  @override
  String get learningSheetHint => 'What you want to keep';
  @override
  Map<String, String> get learningTextErrors => {
    'empty': 'Write what you want to keep',
    'tooLong': 'This is too long',
  };
  @override
  String get learningSave => 'Save';
  @override
  String get learningSaved => 'Learning saved';
  @override
  String get learnedLink => 'What I learned';
  @override
  String get settingsTitle => 'Conversation settings';
  @override
  String get planPlus => 'Plus plan';
  @override
  String get planFree => 'Free plan';
  @override
  String usagePlus({required Object left, required Object limit}) =>
      '${left} of ${limit} messages left today';
  @override
  String get usageFree => 'The chat is part of Plus. The free plan has no messages.';
  @override
  String get sendingTitle => 'What is sent';
  @override
  String get sendingText =>
      'Only the text you type and the last turns of the conversation go to the model, to produce the reply. Nothing is stored unless you save it as a slip or a learning.';
  @override
  String get offline => 'You\'re offline. The chat resumes when you reconnect.';
  @override
  String get interrupted => 'The reply was interrupted.';
  @override
  String get retry => 'Try again';
  @override
  String get limitTitle => 'Today\'s messages are used up';
  @override
  String get limitText => 'Come back tomorrow, or see Plus to talk more.';
  @override
  String get plusTitle => 'The chat is part of Plus';
  @override
  String get plusText => 'The mascot is available on Plus, with 20 messages a day.';
  @override
  String get plusCta => 'See plans';
  @override
  String get unavailableTitle => 'The chat is not available right now';
  @override
  String get unavailableText => 'Try again later.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
  @override
  String get menuLabel => 'More options';
  @override
  late final _Translations$chat$action$en action = _Translations$chat$action$en._(_root);
  @override
  Map<String, String> get greeting => {
    'morning': 'Good morning',
    'afternoon': 'Good afternoon',
    'evening': 'Good evening',
  };
  @override
  String get entryTitle => 'What do you want to talk about?';
  @override
  String get entryHighlight => 'talk';
  @override
  String get starterBothered => 'Something bothered me';
  @override
  String get starterThanks => 'I want to say thanks';
  @override
  String get starterDate => 'A date idea';
  @override
  String get starterTalk => 'Prepare a conversation';
  @override
  String get startHere => 'Start here';
  @override
  String get offlineSlip => 'Make a slip';
  @override
  String get offlineDiary => 'Write in the diary';
  @override
  String get remembersTitle => 'What it sees and remembers';
  @override
  String get remembersAction => 'What I learned';
  @override
  String get remembersText =>
      'It only keeps what you confirm, item by item. You can review and delete it any time.';
}

// Path: checkin
class _Translations$checkin$en extends Translations$checkin$pt {
  _Translations$checkin$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Weekly check-in';
  @override
  String get titleHighlight => 'Weekly';
  @override
  String get introSubtitle => 'Ten minutes. Each of you answers privately first.';
  @override
  String get start => 'Start';
  @override
  String get notThisWeek => 'Not this week';
  @override
  String questionOf({required Object current, required Object total}) =>
      'Question ${current} of ${total}';
  @override
  List<String> get questions => [
    'What was good this week?',
    'What do you want us to do together?',
    'Did anything weigh on you this week?',
    'What do you want me to know?',
  ];
  @override
  String get answerHint => 'Write as much or as little as you want.';
  @override
  String get privateNote => 'Answers stay hidden until both of you finish.';
  @override
  String get next => 'Next';
  @override
  String get finish => 'Finish';
  @override
  String get skip => 'Skip this question';
  @override
  String get skipNote =>
      'Skipping leaves this question blank. The check-in only appears when both of you answer all four.';
  @override
  String get waitingTitle => 'Your answers are kept';
  @override
  String get waitingText => 'Answers appear when both of you have answered all four.';
  @override
  String get waitingIncomplete =>
      'Some questions are still blank. Answers appear when both of you answer all four.';
  @override
  String get answerMissing => 'Answer the missing ones';
  @override
  String get checkAgain => 'Check again';
  @override
  String get review => 'Review my answers';
  @override
  String get discardTitle => 'Discard this answer?';
  @override
  String get discardText => 'The text you wrote was not saved.';
  @override
  String get discard => 'Discard';
  @override
  String get keepWriting => 'Keep writing';
  @override
  String get revealTitle => 'Your answers together';
  @override
  String get revealHighlight => 'together';
  @override
  String get revealSubtitle =>
      'Now that you both finished, both answers to each question are shown.';
  @override
  String get revealNote => 'No scores. Just what each of you wrote.';
  @override
  String get you => 'You';
  @override
  String get partnerFallback => 'Your partner';
  @override
  String get skippedAnswer => 'Skipped this question';
  @override
  String get close => 'Close';
  @override
  String get soloTitle => 'The check-in is for both of you';
  @override
  String get soloText => 'When your person joins, the weekly check-in shows up here.';
  @override
  String get loadErrorTitle => 'Couldn\'t open the check-in';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
  @override
  Map<String, String> get errors => {'other': 'Couldn\'t save that now. Try again.'};
}

// Path: common
class _Translations$common$en extends Translations$common$pt {
  _Translations$common$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get appName => 'Mingo';
  @override
  String get send => 'Send';
  @override
  String get save => 'Save';
  @override
  String get retry => 'Retry';
  @override
  String get loading => 'Loading';
  @override
  String get username => 'Username';
  @override
  String get email => 'Email';
  @override
  String get password => 'Password';
  @override
  String get firstName => 'First Name';
  @override
  String get lastName => 'Last Name';
  @override
  String get genericError => 'Something went wrong';
  @override
  String get discardTitle => 'Discard changes?';
  @override
  String get discardText => 'What you wrote won\'t be saved.';
  @override
  String get discard => 'Discard';
  @override
  String get keepWriting => 'Keep writing';
}

// Path: connectTouch
class _Translations$connectTouch$en extends Translations$connectTouch$pt {
  _Translations$connectTouch$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Touch';
  @override
  String get text => 'Neutral cards, nothing spicy. Do it or skip it, no pressure.';
  @override
  String get switchTitle => 'Touch topics';
  @override
  String get switchText => 'Applies to both of you: if one turns it off, it goes away for both.';
  @override
  String get offTitle => 'Touch topics are off';
  @override
  String get offText =>
      'You or your partner turned them off. You can turn them back on here anytime.';
  @override
  String get emptyTitle => 'No cards right now';
  @override
  String get emptyText => 'Come back later.';
  @override
  String get done => 'Done';
  @override
  String get skip => 'Skip';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t change that right now. Try again.',
  };
}

// Path: connectUs
class _Translations$connectUs$en extends Translations$connectUs$pt {
  _Translations$connectUs$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'I miss us';
  @override
  String get text =>
      'Send “I miss us” with one tap. Light, no guilt. Your partner doesn\'t have to answer.';
  @override
  String get send => 'Send with care';
  @override
  String get plan => 'Suggest a small plan';
  @override
  String get sentNote => 'Sent. No rush to reply.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t send right now. Try again.',
  };
  @override
  String get titleHighlight => 'us';
}

// Path: createAccount
class _Translations$createAccount$en extends Translations$createAccount$pt {
  _Translations$createAccount$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Create account';
  @override
  String get headline => 'Keep it safe';
  @override
  String get headlineHighlight => 'safe';
  @override
  String get subtitleWithSlip =>
      'Your first slip is saved on this phone. Create the account so you do not lose it.';
  @override
  String get subtitleWithoutSlip => 'Create the account to keep your slips and not lose them.';
}

// Path: dateNight
class _Translations$dateNight$en extends Translations$dateNight$pt {
  _Translations$dateNight$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Date night';
  @override
  String get subtitle => 'Ideas for the two of you, picked together.';
  @override
  String get hint => 'E.g. picnic in the park';
  @override
  String get add => 'Add';
  @override
  String get save => 'Save';
  @override
  String get nextTitle => 'Next date';
  @override
  String get ideasTitle => 'Ideas';
  @override
  String get suggestionsTitle => 'To start with';
  @override
  String plannedFor({required Object month, required Object day}) => '${month} ${day}';
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  Map<String, String> get planChoices => {
    'today': 'Plan for today',
    'tomorrow': 'Plan for tomorrow',
    'saturday': 'Plan for Saturday',
    'sunday': 'Plan for Sunday',
    'other': '',
  };
  @override
  String get markDone => 'We did it';
  @override
  String get reopen => 'Back to ideas';
  @override
  String get done => 'Done';
  @override
  String get delete => 'Delete';
  @override
  String get emptyTitle => 'No ideas yet';
  @override
  String get emptyText => 'Write a date idea. You both see it.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your ideas are still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: dates
class _Translations$dates$en extends Translations$dates$pt {
  _Translations$dates$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Dates';
  @override
  String get segmentDates => 'Dates';
  @override
  String get segmentGifts => 'Gifts';
  @override
  String get segmentHolidays => 'Holidays';
  @override
  String get titleLabel => 'Name';
  @override
  String get titleHint => 'E.g. their birthday';
  @override
  Map<String, String> get titleErrors => {
    'empty': 'Give this date a name',
    'tooLong': 'The name is too long',
  };
  @override
  Map<String, String> get kinds => {
    'relationship': 'Relationship',
    'birthday': 'Birthday',
    'first': 'A first time',
    'trip': 'Trip',
    'custom': 'Other',
    'holiday': 'Holiday',
    'reunion': 'Reunion',
    'other': '',
  };
  @override
  String get monthLabel => 'Month';
  @override
  String get dayLabel => 'Day';
  @override
  String get yearLabel => 'Year (optional)';
  @override
  String get yearHint => 'E.g. 1994';
  @override
  String get yearHelp => 'Without the year the date just repeats, with no age.';
  @override
  Map<String, String> get yearErrors => {'invalid': 'Use a year between 1900 and 2200'};
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String dayLine({required Object month, required Object day, required Object kind}) =>
      '${month} ${day} · ${kind}';
  @override
  String dayOnly({required Object month, required Object day}) => '${month} ${day}';
  @override
  String get saveDate => 'Save date';
  @override
  String get delete => 'Delete';
  @override
  String get deleteTitle => 'Delete this date?';
  @override
  String get deleteText => 'It disappears from the calendar for both of you.';
  @override
  String get deleteConfirm => 'Delete';
  @override
  String get add => 'Add';
  @override
  String get emptyDatesTitle => 'No dates yet';
  @override
  String get emptyDatesText => 'Keep birthdays and dates that matter. We remind you ahead.';
  @override
  String get giftsPrivate => 'Gift ideas only you see.';
  @override
  String get giftHint => 'E.g. book of poems';
  @override
  Map<String, String> get giftErrors => {
    'empty': 'Write the gift idea',
    'tooLong': 'The gift idea is too long',
  };
  @override
  String get given => 'Given';
  @override
  String get emptyGiftsTitle => 'No ideas yet';
  @override
  String get emptyGiftsText => 'Jot down gifts when you think of them.';
  @override
  String get emptyHolidaysTitle => 'No holidays here';
  @override
  String get emptyHolidaysText => 'The calendar has no holidays for you yet.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your data is still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: day
class _Translations$day$en extends Translations$day$pt {
  _Translations$day$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String dateLine({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String get previous => 'Previous day';
  @override
  String get next => 'Next day';
  @override
  String get planned => 'Planned date';
  @override
  String get emptyTitle => 'Nothing set for this day';
  @override
  String get emptyText => 'A free day is good too.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
}

// Path: debugSignIn
class _Translations$debugSignIn$en extends Translations$debugSignIn$pt {
  _Translations$debugSignIn$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sign in (debug)';
  @override
  String get signIn => 'Sign in';
  @override
  String get createAccount => 'Create account';
  @override
  String get confirmEmail => 'Account created. Check your email to confirm it before signing in.';
}

// Path: devices
class _Translations$devices$en extends Translations$devices$pt {
  _Translations$devices$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Notification devices';
  @override
  String get subtitle =>
      'Phones that receive notifications for this account. Removing one stops its notifications.';
  @override
  String get current => 'This device';
  @override
  String registeredToday({required Object time}) => 'Registered today at ${time}';
  @override
  String registeredYesterday({required Object time}) => 'Registered yesterday at ${time}';
  @override
  String registeredOn({required Object date}) => 'Registered on ${date}';
  @override
  String get platformIos => 'iPhone';
  @override
  String get platformAndroid => 'Android';
  @override
  String get revokeTitle => 'Stop notifications on this device?';
  @override
  String revokeText({required Object name}) =>
      '${name} will stop receiving notifications for this account.';
  @override
  String get revokeConfirm => 'Stop notifications';
  @override
  String get revoked => 'Notifications stopped on that device.';
  @override
  String get emptyTitle => 'No notification devices';
  @override
  String get emptyText => 'Devices that receive notifications for this account appear here.';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again when you are back online.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'DEVICE_REVOKE_FAILED': 'Couldn\'t stop notifications on that device. Try again.',
    'other': 'Couldn\'t stop notifications on that device. Try again.',
  };
}

// Path: distance
class _Translations$distance$en extends Translations$distance$pt {
  _Translations$distance$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Distance';
  @override
  String get text => 'Two clocks, each in its own time zone, never mixed up.';
  @override
  String get you => 'You';
  @override
  String get partner => 'Your partner';
  @override
  String get noPartner => 'When your partner joins, their clock shows up here.';
  @override
  String get sameZone => 'You are in the same time zone for now.';
  @override
  String reunionDays({required Object n}) => '${n} days until you see each other';
  @override
  String get reunionToday => 'You see each other today';
  @override
  String get reunionTomorrow => 'You see each other tomorrow';
  @override
  String get noReunionTitle => 'No reunion date';
  @override
  String get noReunionText => 'Save a “Reunion” in your dates and the countdown shows here.';
  @override
  String get addReunion => 'Save a date';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
}

// Path: fightStyle
class _Translations$fightStyle$en extends Translations$fightStyle$pt {
  _Translations$fightStyle$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String questionOf({required Object current, required Object total}) =>
      'Question ${current} of ${total}';
  @override
  List<String> get questions => [
    'When the conversation heats up, what do you do first?',
    'If your partner goes quiet mid-fight, you...',
    'After an argument, what usually happens?',
    'What bothers you most in a fight?',
    'When you notice you went too far, you...',
    'What helps you feel normal again?',
  ];
  @override
  List<String> get questionHighlights => [
    'first',
    'goes quiet',
    'happens',
    'bothers',
    'went too far',
    'back to normal',
  ];
  @override
  Map<String, String> get options1 => {
    'pursue': 'I keep talking until it\'s settled.',
    'withdraw': 'I need some time before going on.',
    'repair': 'I try to lighten the mood.',
    'avoid': 'I change the subject so it doesn\'t get worse.',
    'other': '',
  };
  @override
  Map<String, String> get options2 => {
    'pursue': 'I push for them to speak.',
    'withdraw': 'I go quiet too.',
    'repair': 'I calmly ask what happened.',
    'avoid': 'I leave it for later.',
    'other': '',
  };
  @override
  Map<String, String> get options3 => {
    'pursue': 'I look for the conversation right away.',
    'withdraw': 'I spend some time alone.',
    'repair': 'I think about what I can fix.',
    'avoid': 'I\'d rather not go back to it.',
    'other': '',
  };
  @override
  Map<String, String> get options4 => {
    'pursue': 'Getting no answer.',
    'withdraw': 'Feeling pressured.',
    'repair': 'Seeing that we don\'t understand each other.',
    'avoid': 'The conversation dragging on.',
    'other': '',
  };
  @override
  Map<String, String> get options5 => {
    'pursue': 'I talk even more to explain.',
    'withdraw': 'I close up until I calm down.',
    'repair': 'I apologize or suggest a way to fix it.',
    'avoid': 'I wait for it to cool down.',
    'other': '',
  };
  @override
  Map<String, String> get options6 => {
    'pursue': 'Finishing the conversation.',
    'withdraw': 'Some quiet time.',
    'repair': 'A small gesture of care.',
    'avoid': 'Carrying on with the day as if nothing happened.',
    'other': '',
  };
  @override
  String get continueAction => 'Continue';
  @override
  String get finishAction => 'See result';
  @override
  String get back => 'Back';
  @override
  String get privateNote => 'Only you see your answers. Nothing is sent to your partner.';
  @override
  String get resultTitle => 'How you usually react';
  @override
  String get resultHighlight => 'react';
  @override
  String get patternTag => 'Your pattern';
  @override
  Map<String, String> get descriptions => {
    'pursue': 'You tend to seek the conversation right away, even while things are still hot.',
    'withdraw': 'You tend to step back first and come back later.',
    'repair': 'You tend to look for a way to fix things soon after a fight.',
    'avoid': 'You tend to set the subject aside so it doesn\'t get worse in the moment.',
    'other': '',
  };
  @override
  Map<String, String> get practices => {
    'pursue': 'That helps you sort it out fast. Pausing before it gets worse and listening to the end is worth it.',
    'withdraw': 'That helps you pause before it gets worse. Pick a set way to come back.',
    'repair': 'That helps you return after a fight. A short apology often does it.',
    'avoid': 'That helps you pause before it gets worse. Choose a short moment to come back to it.',
    'other': '',
  };
  @override
  String partnerSignal({required Object name}) => 'Agree on a signal with ${name} to come back.';
  @override
  String get addToTools => 'Add to my repair tools';
  @override
  String get addedToTools => 'Already in your repair tools';
  @override
  String get keepMine => 'Keep it to myself';
  @override
  String get retake => 'Take it again';
  @override
  String get addedToast => 'Added to your repair tools.';
  @override
  String get loadErrorTitle => 'Couldn\'t load';
  @override
  String get loadErrorText => 'Couldn\'t open your result right now. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your answers are still here.',
  };
  @override
  Map<String, String> get addErrors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t add it right now. Try again.',
  };
  @override
  String get resultBarTitle => 'Result';
}

// Path: firstSlip
class _Translations$firstSlip$en extends Translations$firstSlip$pt {
  _Translations$firstSlip$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Start with one good thing';
  @override
  String get titleHighlight => 'one good thing';
  @override
  String get subtitle =>
      'What did your partner do lately that made you smile? 30 seconds is enough. No account yet.';
  @override
  String get hint => 'E.g. made coffee before I woke up';
  @override
  Map<String, String> get textErrors => {
    'empty': 'Write one good thing first.',
    'tooLong': 'Use at most 140 characters.',
  };
  @override
  String get localNote => 'Stays saved on this phone only.';
  @override
  String get save => 'Save';
  @override
  String get saveError => 'Could not keep it right now. Try again.';
}

// Path: games
class _Translations$games$en extends Translations$games$pt {
  _Translations$games$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$games$hub$en hub = _Translations$games$hub$en._(_root);
  @override
  late final _Translations$games$kinds$en kinds = _Translations$games$kinds$en._(_root);
  @override
  late final _Translations$games$start$en start = _Translations$games$start$en._(_root);
  @override
  late final _Translations$games$invitation$en invitation = _Translations$games$invitation$en._(
    _root,
  );
  @override
  late final _Translations$games$waiting$en waiting = _Translations$games$waiting$en._(_root);
  @override
  late final _Translations$games$active$en active = _Translations$games$active$en._(_root);
  @override
  late final _Translations$games$playing$en playing = _Translations$games$playing$en._(_root);
  @override
  late final _Translations$games$date$en date = _Translations$games$date$en._(_root);
  @override
  Map<String, String> get reflections => {
    'great': 'It was great',
    'ok': 'It was ok',
    'did_not_happen': 'It did not happen',
    'other': 'No answer',
  };
  @override
  late final _Translations$games$waitingPartner$en waitingPartner =
      _Translations$games$waitingPartner$en._(_root);
  @override
  late final _Translations$games$finished$en finished = _Translations$games$finished$en._(_root);
  @override
  late final _Translations$games$notFound$en notFound = _Translations$games$notFound$en._(_root);
  @override
  late final _Translations$games$cancel$en cancel = _Translations$games$cancel$en._(_root);
  @override
  late final _Translations$games$noPartner$en noPartner = _Translations$games$noPartner$en._(_root);
  @override
  String get loadErrorTitle => 'Could not open the game';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
  @override
  Map<String, String> get errors => {
    'NOT_PAIRED': 'Games need both of you connected.',
    'NOT_FOUND': 'That game no longer exists. We\'ll refresh.',
    'INVALID_GAME_ACTION': 'That game changed. We\'ll refresh.',
    'GAME_ALREADY_OPEN': 'A game is already open. Finish or cancel it before inviting again.',
    'GAME_NOT_COMPLETE': 'Your partner is still answering. Try again when they finish.',
    'INVALID_GAME_INDEX': 'That question changed. We\'ll refresh.',
    'ANSWER_LOCKED': 'This game\'s answers are closed. You can\'t edit them now.',
    'other': 'Could not do that right now. Try again.',
  };
  @override
  late final _Translations$games$common$en common = _Translations$games$common$en._(_root);
}

// Path: gentleRequest
class _Translations$gentleRequest$en extends Translations$gentleRequest$pt {
  _Translations$gentleRequest$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Gentle request';
  @override
  String get titleHighlight => 'Gentle';
  @override
  String get whenLabel => 'When…';
  @override
  String get feelLabel => 'I feel…';
  @override
  String get wishLabel => 'I would like to…';
  @override
  String get whenHint => 'I get home and the house is a mess';
  @override
  String get feelHint => 'alone with the chores';
  @override
  String get wishHint => 'share Saturday afternoon with you';
  @override
  String previewTitle({required Object name}) => 'What ${name} will read';
  @override
  String get previewTitleNoName => 'What your person will read';
  @override
  String get previewEmpty => 'Fill in the three sentences to see the request.';
  @override
  String sentence({required Object when, required Object feel, required Object wish}) =>
      'When ${when}, I feel ${feel}. I would like to ${wish}.';
  @override
  String get note =>
      'It does not go on the Sunday card. The request goes away 7 days after it is answered.';
  @override
  String get keep => 'Keep';
  @override
  String get sendNow => 'Send now';
  @override
  String get confirmTitle => 'Send this request?';
  @override
  String get confirmText =>
      'Your person will read the three sentences. The note it came from stops existing.';
  @override
  String get sent => 'Request sent';
  @override
  Map<String, String> get fieldErrors => {
    'empty': 'Fill in this sentence.',
    'tooLong': 'Use at most 140 characters.',
  };
  @override
  Map<String, String> get errors => {
    'NOT_PAIRED': 'A gentle request needs a connected person.',
    'NETWORK': 'No connection. Try again.',
    'other': 'We could not send it now. Try again.',
  };
}

// Path: gentleRequestDetail
class _Translations$gentleRequestDetail$en extends Translations$gentleRequestDetail$pt {
  _Translations$gentleRequestDetail$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get partnerFallback => 'your person';
  @override
  String fromYou({required Object name}) => 'You wrote to ${name}.';
  @override
  String toYou({required Object name}) => '${name} wrote to you.';
  @override
  String get answerTitle => 'How do you want to answer?';
  @override
  Map<String, String> get responses => {
    'willDo': 'I will take care of it',
    'later': 'Later',
    'notNow': 'Not now',
    'talk': 'I want to talk',
    'moreTime': 'I need more time',
    'other': '',
  };
  @override
  String answeredBy({required Object name, required Object answer}) =>
      '${name} answered: ${answer}';
  @override
  String youAnswered({required Object answer}) => 'You answered: ${answer}';
  @override
  String get waiting => 'No answer yet.';
  @override
  String get thankAction => 'Say thanks';
  @override
  String get thanked => 'You said thanks. It became a slip of yours.';
  @override
  String thankBody({required Object name, required Object wish}) =>
      '${name} took care of it: ${wish}';
  @override
  String get goneTitle => 'That request is gone';
  @override
  String get goneText => 'It was answered more than 7 days ago or no longer exists.';
  @override
  String get errorTitle => 'We could not open the request';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Something went wrong. Try again.',
  };
}

// Path: gifts
class _Translations$gifts$en extends Translations$gifts$pt {
  _Translations$gifts$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Gift page';
  @override
  String get subtitle => 'A page your partner can see in the app. You choose what to share.';
  @override
  String get myTitle => 'My wishes';
  @override
  String get partnerTitle => 'From your partner';
  @override
  String get emptyPageTitle => 'No wishes yet';
  @override
  String get emptyPageTextShared => 'Add a wish, or wait for your partner to share one.';
  @override
  String get emptyPageTextSolo =>
      'Add what you would love to receive. It stays private until you pair.';
  @override
  String get emptyMineTitle => 'No wishes yet';
  @override
  String get emptyMineText => 'Add what you would love to receive.';
  @override
  String get emptyPartnerTitle => 'Nothing shared yet';
  @override
  String get emptyPartnerText => 'When your partner shares a wish, it shows up here.';
  @override
  String get addTitle => 'New wish';
  @override
  String get editTitle => 'Edit wish';
  @override
  String get titleLabel => 'Gift';
  @override
  String get titleHint => 'E.g. a book of poems';
  @override
  Map<String, String> get titleErrors => {
    'empty': 'Give the wish a name.',
    'tooLong': 'Keep it to 120 characters or fewer.',
  };
  @override
  String get noteHint => 'Size, color, where to find it.';
  @override
  Map<String, String> get noteErrors => {'tooLong': 'Keep the note under 1000 characters.'};
  @override
  String get budgetLabel => 'Budget (optional)';
  @override
  Map<String, String> get budgets => {
    'free': 'Free',
    'low': 'Low',
    'medium': 'Medium',
    'high': 'High',
    'other': '',
  };
  @override
  String get noBudget => 'No budget';
  @override
  String get shared => 'Shared';
  @override
  String get private => 'Private';
  @override
  String get sharedHint => 'Your partner can see this wish.';
  @override
  String get privateHint => 'Only you can see this wish.';
  @override
  String get sharedNeedsPartner => 'Pair with your partner to share a wish.';
  @override
  String get save => 'Save';
  @override
  String get add => 'Add';
  @override
  String get delete => 'Delete';
  @override
  String get deleteTitle => 'Delete this wish?';
  @override
  String get deleteText => 'It disappears for you and your partner.';
  @override
  String get deleteConfirm => 'Delete';
  @override
  String get entryLabel => 'GIFTS';
  @override
  String get entryTitle => 'Gift page';
  @override
  String get entryText => 'Wishes you choose to share, or keep to yourself.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: globalErrors
class _Translations$globalErrors$en extends Translations$globalErrors$pt {
  _Translations$globalErrors$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get offline => 'No connection. Your notes stay saved and sync later.';
  @override
  String get errorTitle => 'Something went wrong';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  String get networkTitle => 'No connection';
  @override
  String get networkText => 'Check the connection and try again.';
  @override
  String get timeoutTitle => 'The connection took too long';
  @override
  String get timeoutText => 'Try again in a moment.';
  @override
  String get rateTitle => 'Easy there';
  @override
  String get rateText => 'Too many tries in a row. Wait a little and try again.';
  @override
  String get notFoundTitle => 'Not found';
  @override
  String get notFoundText => 'Maybe this is no longer available.';
  @override
  String get retry => 'Try again';
  @override
  String retryIn({required Object seconds}) => 'Try in ${seconds}s';
  @override
  String get updateTitle => 'Update the app';
  @override
  String get updateHighlight => 'app';
  @override
  String get updateText => 'There is a new version. Update to continue.';
  @override
  String get updateAction => 'Update';
  @override
  String get updateUnavailable => 'Could not open the store. Update there.';
}

// Path: griefSupport
class _Translations$griefSupport$en extends Translations$griefSupport$pt {
  _Translations$griefSupport$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'We\'re with you';
  @override
  String get highlight => 'you';
  @override
  String get text => 'Your memories stay here, at your pace.';
  @override
  String get seeSupport => 'See support';
  @override
  String get backHome => 'Back to the start';
}

// Path: guides
class _Translations$guides$en extends Translations$guides$pt {
  _Translations$guides$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$guides$hub$en hub = _Translations$guides$hub$en._(_root);
  @override
  late final _Translations$guides$viewer$en viewer = _Translations$guides$viewer$en._(_root);
  @override
  late final _Translations$guides$gate$en gate = _Translations$guides$gate$en._(_root);
  @override
  late final _Translations$guides$finish$en finish = _Translations$guides$finish$en._(_root);
}

// Path: hardConversation
class _Translations$hardConversation$en extends Translations$hardConversation$pt {
  _Translations$hardConversation$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Prepare a hard conversation';
  @override
  String stepOf({required Object current, required Object total}) => 'Step ${current} of ${total}';
  @override
  String get whatTitle => 'What happened?';
  @override
  String get whatHint => 'If you want, tell me in your own words';
  @override
  String get whatIgnored => 'She felt ignored';
  @override
  String get whatMoney => 'We fought about money';
  @override
  String get whatMisunderstanding => 'It was a misunderstanding';
  @override
  String get whatOther => 'Other: write it';
  @override
  String get needTitle => 'What do I need?';
  @override
  String get needHint => 'If you want, add something';
  @override
  String get needHeard => 'To be heard';
  @override
  String get needApology => 'To apologize';
  @override
  String get needAgree => 'To agree on something';
  @override
  String get sayTitle => 'How to say it';
  @override
  String get sayIntro => 'A starting point for you to edit before sending.';
  @override
  String get sayHint => 'Your opening sentence';
  @override
  Map<String, String> get messageErrors => {
    'empty': 'Write the sentence first',
    'tooLong': 'This sentence is too long',
  };
  @override
  String get generating => 'Writing a gentle opening…';
  @override
  String get gentler => 'More gentle';
  @override
  String get moreDirect => 'More direct';
  @override
  String get copy => 'Copy';
  @override
  String get copied => 'Copied';
  @override
  String get sendAsNote => 'Send as a note';
  @override
  String get sent => 'Note sent';
  @override
  String get exit => 'Leave';
  @override
  String get next => 'Next';
  @override
  String get back => 'Back';
  @override
  String get retry => 'Try again';
  @override
  String get generationFailed => 'Couldn\'t write a sentence right now.';
  @override
  String get privateNote =>
      'The mascot only sees what you write here. Your partner\'s data is never sent.';
  @override
  String get offline => 'You\'re offline. The opening sentence needs a connection.';
  @override
  String get emptyTitle => 'Couldn\'t load';
  @override
  String get emptyText => 'Try again in a moment.';
  @override
  String get plusTitle => 'Preparing a conversation is part of Plus';
  @override
  String get plusText => 'The three steps and the opening suggestion are in Plus.';
  @override
  String get plusCta => 'See plans';
  @override
  String get limitTitle => 'Today\'s messages are used up';
  @override
  String get limitText => 'Come back tomorrow, or see Plus to prepare more conversations.';
  @override
  Map<String, String> get errors => {
    'CHAT_LIMIT': 'Today\'s messages are used up.',
    'CHAT_DISABLED': 'The chat is off. Turn it on to use the mascot.',
    'CHAT_UNAVAILABLE': 'The chat is not available right now.',
    'UPSTREAM': 'Couldn\'t write a sentence right now. Try again.',
    'NOT_PAIRED': 'To send this, you need to be connected with your partner in the app.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: help
class _Translations$help$en extends Translations$help$pt {
  _Translations$help$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get badDayTitle => 'A hard day';
  @override
  String get badDayText => 'Three small things that may help right now. Nothing required.';
  @override
  String get starterTitle => 'Start a conversation';
  @override
  String get starterText => 'A question to open with, no rush.';
  @override
  String get another => 'Another';
  @override
  String get emptyTitle => 'Nothing here yet';
  @override
  String get emptyText => 'We\'re preparing more suggestions.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
}

// Path: helpSupport
class _Translations$helpSupport$en extends Translations$helpSupport$pt {
  _Translations$helpSupport$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Help';
  @override
  String get contactTitle => 'Talk to support';
  @override
  String get reportBug => 'Report a bug';
  @override
  String get faqTitle => 'Common questions';
  @override
  Map<String, String> get faqQuestions => {
    'replyTime': 'When will I get an answer?',
    'offline': 'What if I send without internet?',
    'privacy': 'Who reads what I send?',
    'reportBug': 'How do I report a bug?',
  };
  @override
  Map<String, String> get faqAnswers => {
    'replyTime': 'We reply within 2 business days.',
    'offline': 'Your message stays saved and goes out when you\'re online again.',
    'privacy': 'Only the support team. Nothing is shared with your partner.',
    'reportBug': 'Choose Bug in the form and tell us what happened.',
  };
  @override
  String get pendingNote => 'A message is saved and will be sent when you\'re online.';
  @override
  String get discardedNote =>
      'A saved message couldn\'t be sent and was removed. Write to us again if it still matters.';
  @override
  String get supportTitle => 'Support';
  @override
  String get supportHeading => 'How can we help?';
  @override
  String get supportHighlight => 'help';
  @override
  Map<String, String> get topics => {
    'account': 'Account',
    'billing': 'Billing',
    'bug': 'Bug',
    'other': 'Other',
  };
  @override
  String get messageLabel => 'Message';
  @override
  String get messageHint => 'Tell us what happened, with as much detail as you like.';
  @override
  Map<String, String> get messageErrors => {
    'empty': 'Write your message first',
    'tooLong': 'The message is too long',
  };
  @override
  String get replyEmailLabel => 'Reply email';
  @override
  String get replyEmailHint => 'you@email.com';
  @override
  Map<String, String> get replyEmailErrors => {
    'invalid': 'Check the email address.',
    'tooLong': 'This email is too long',
  };
  @override
  String get replyTime => 'We reply within 2 business days.';
  @override
  String get send => 'Send';
  @override
  String get sentTitle => 'Message sent';
  @override
  String get sentText => 'Thanks. We reply within 2 business days.';
  @override
  String get queuedTitle => 'Saved';
  @override
  String get queuedText =>
      'We\'ll send it when you\'re back online. It hasn\'t been delivered yet.';
  @override
  String get done => 'Done';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'You sent several messages today. Try again tomorrow.',
    'noData': 'Couldn\'t send right now. Your message is still here.',
    'other': 'Couldn\'t send right now. Your message is still here.',
  };
  @override
  String get discardTitle => 'Discard this message?';
  @override
  String get discardText => 'What you wrote won\'t be saved.';
}

// Path: history
class _Translations$history$en extends Translations$history$pt {
  _Translations$history$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Our history';
  @override
  String get addMilestoneTooltip => 'Add milestone';
  @override
  String togetherSinceLine({required Object date}) => 'together since ${date}';
  @override
  String get setStartDate => 'Set when our story started';
  @override
  String get beginningHeadline => 'Starting out';
  @override
  String reunionCountdown({required num days}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        days,
        one: '${days} day to go',
        other: '${days} days to go',
      );
  @override
  String durationFull({
    required Object years,
    required Object yearsUnit,
    required Object months,
    required Object monthsUnit,
    required Object days,
    required Object daysUnit,
  }) => '${years} ${yearsUnit}, ${months} ${monthsUnit}\nand ${days} ${daysUnit}';
  @override
  String durationFullInline({
    required Object years,
    required Object yearsUnit,
    required Object months,
    required Object monthsUnit,
    required Object days,
    required Object daysUnit,
  }) => '${years} ${yearsUnit}, ${months} ${monthsUnit} and ${days} ${daysUnit}';
  @override
  String durationMonthsDays({
    required Object months,
    required Object monthsUnit,
    required Object days,
    required Object daysUnit,
  }) => '${months} ${monthsUnit} and ${days} ${daysUnit}';
  @override
  String durationDaysOnly({required Object days, required Object daysUnit}) =>
      '${days} ${daysUnit}';
  @override
  String get yearOne => 'year';
  @override
  String get yearMany => 'years';
  @override
  String get monthOne => 'month';
  @override
  String get monthMany => 'months';
  @override
  String get dayOne => 'day';
  @override
  String get dayMany => 'days';
  @override
  String statDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'day',
        other: 'days',
      );
  @override
  String statWeekends({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'weekend',
        other: 'weekends',
      );
  @override
  String statChristmases({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'Christmas',
        other: 'Christmases',
      );
  @override
  String statPlaces({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'place',
        other: 'places',
      );
  @override
  String get storyDatesAction => 'Story dates';
  @override
  String get numbersAction => 'In numbers';
  @override
  String get variationsAction => 'How the counter looks';
  @override
  String get avatarAction => 'Your avatar';
  @override
  String get differentDatesBanner => 'You chose different start dates';
  @override
  String get differentDatesAction => 'See dates';
  @override
  String get timelineSection => 'MILESTONES AND MEMORIES';
  @override
  String get recentChip => 'Recent';
  @override
  String get unknownYearChip => 'No date';
  @override
  String get timelineRecentNote => 'Showing your most recent milestones.';
  @override
  String loadEarlierYear({required Object year}) => 'See ${year}';
  @override
  String get unknownDateLabel => 'Unknown date';
  @override
  String get addMilestoneRow => 'Add a milestone';
  @override
  String get emptyTitle => 'Start with your first milestone';
  @override
  String get emptyText => 'Save when you met or a special moment.';
  @override
  String get suggestedFirstTitle => 'We met';
  @override
  String get suggestedFirstSub => 'Suggested first milestone · tap to add';
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  List<String> get monthsLong => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String fullDate({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  String shortDayMonthYear({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  String shortMonthYear({required Object month, required Object year}) => '${month} ${year}';
  @override
  String shortDayMonth({required Object month, required Object day}) => '${month} ${day}';
  @override
  String get milestoneNewTitle => 'New milestone';
  @override
  String get milestoneDetailTitle => 'Milestone details';
  @override
  String get milestoneDefaultHighlight => 'together';
  @override
  String get milestoneTitleLabel => 'What happened';
  @override
  String get milestoneTitleHint => 'E.g. First trip together';
  @override
  Map<String, String> get milestoneTitleErrors => {
    'empty': 'Say what happened',
    'tooLong': 'The title is too long',
  };
  @override
  String get milestonePlaceLabel => 'Place (optional)';
  @override
  String get milestonePlaceHint => 'E.g. Paraty';
  @override
  Map<String, String> get milestonePlaceErrors => {'tooLong': 'The place is too long'};
  @override
  String get milestoneBodyHint => 'A note about this moment (optional)';
  @override
  Map<String, String> get milestoneBodyErrors => {'tooLong': 'The note is too long'};
  @override
  String get milestoneKindLabel => 'Milestone kind';
  @override
  String get kindFirst => 'First time';
  @override
  String get kindTrip => 'Trip';
  @override
  String get kindHome => 'Moved in together';
  @override
  String get kindCustom => 'Milestone';
  @override
  String get unknownDateToggle => 'Unknown date';
  @override
  String get precisionDay => 'Exact day';
  @override
  String get precisionMonth => 'Month and year';
  @override
  String get precisionYear => 'Year only';
  @override
  String get dateRowLabel => 'Date';
  @override
  String get addedByRowLabel => 'Added by';
  @override
  String get addedByYou => 'You';
  @override
  String get visibilityRowLabel => 'Who sees it';
  @override
  String get visibilityBoth => 'Both';
  @override
  String get visibilityOnlyYou => 'Only you';
  @override
  String get deleteMilestone => 'Delete';
  @override
  String get deleteMilestoneTitle => 'Delete this milestone?';
  @override
  String get deleteMilestoneTextShared => 'It will be removed from both of your stories.';
  @override
  String get deleteMilestoneTextPrivate => 'It will be removed from your story.';
  @override
  String get deleteMilestoneConfirm => 'Delete';
  @override
  String get saveMilestone => 'Save';
  @override
  String get storyDatesTitle => 'Dates of our story';
  @override
  String get storyMet => 'We met';
  @override
  String get storyDating => 'Started dating';
  @override
  String get storyEngaged => 'Got engaged';
  @override
  String get storyMarried => 'Got married';
  @override
  String get storyAdd => 'Add';
  @override
  String storyDateAddedBy({required Object name}) => 'Added by ${name}';
  @override
  String get storyDatesNote => 'Everything is optional. The start date feeds the counter.';
  @override
  String get variationsTitle => 'How the counter looks';
  @override
  String get variationDating => 'Dating';
  @override
  String get variationEngaged => 'Engaged';
  @override
  String get variationMarried => 'Married';
  @override
  String get variationBeginning => 'Starting out';
  @override
  String get variationLongDistance => 'Long distance';
  @override
  String get variationsPreviewNote =>
      'Style preview. The time shown is your real total; per-phase counts need their own dates.';
  @override
  String get avatarHeadline => 'How do you appear?';
  @override
  String get avatarHighlight => 'appear';
  @override
  String get avatarInitials => 'Initials';
  @override
  String get avatarInitialsNote => 'Your avatar uses your initials.';
  @override
  String get avatarNote => 'Each person chooses their own. The app never pulls the other\'s photo.';
  @override
  String get avatarContinue => 'Continue';
  @override
  String get numbersTitle => 'In numbers';
  @override
  String numbersHeroDays({required Object days}) => '${days} days';
  @override
  String get numbersHeroEmpty => 'In your own time';
  @override
  String get numbersHeroEmptySub => 'Set a start date whenever you want to track the days.';
  @override
  String numbersWeekends({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'weekend together',
        other: 'weekends together',
      );
  @override
  String numbersFullMoons({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'full moon',
        other: 'full moons',
      );
  @override
  String numbersChristmases({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'Christmas together',
        other: 'Christmases together',
      );
  @override
  String numbersNextAnniversary({required num years, required Object suffix}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        years,
        one: 'until ${years} year ${suffix}',
        other: 'until ${years} years ${suffix}',
      );
  @override
  String get numbersSuffixDating => 'dating';
  @override
  String get numbersSuffixEngaged => 'engaged';
  @override
  String get numbersSuffixMarried => 'married';
  @override
  String get numbersSuffixTogether => 'together';
  @override
  String numbersMonthsCount({required num months}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        months,
        one: '${months} month',
        other: '${months} months',
      );
  @override
  String numbersDaysCount({required num days}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        days,
        one: '${days} day',
        other: '${days} days',
      );
  @override
  String get numbersPlacesSection => 'PLACES THAT MATTERED';
  @override
  String numbersYearSection({required Object year}) => 'YOUR YEAR (${year})';
  @override
  String get numbersYearNote => 'Only your own records this year.';
  @override
  String numbersFirstsCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'first time',
        other: 'first times',
      );
  @override
  String get differentHeadline => 'The dates differ';
  @override
  String get differentHighlight => 'differ';
  @override
  String differentSubtitle({required Object partner}) =>
      'You and ${partner} chose different start dates.';
  @override
  String get differentYourDate => 'Your date';
  @override
  String differentPartnerDate({required Object partner}) => '${partner}\'s date';
  @override
  String get differentNote => 'Each sees their own. Nothing is changed without both.';
  @override
  String get differentNoDates => 'There are no start dates to compare yet.';
  @override
  String get differentContinue => 'Continue';
  @override
  String get partnerFallback => 'your partner';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your story is still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'NOT_OWNER': 'Only its author can edit or delete it.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
  @override
  String numbersMemoriesCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'saved memory',
        other: 'saved memories',
      );
  @override
  String numbersMemoriesRecent({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'recent memory',
        other: 'recent memories',
      );
  @override
  String numbersPlaces({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'place',
        other: 'places',
      );
  @override
  String get readOnlyMilestone =>
      'This milestone was added by someone else. Only its author can edit it.';
  @override
  String readOnlyMilestoneBy({required Object name}) =>
      'Added by ${name}. Only its author can edit it.';
}

// Path: ideaDetail
class _Translations$ideaDetail$en extends Translations$ideaDetail$pt {
  _Translations$ideaDetail$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Idea of the day';
  @override
  String get whyTitle => 'Why this idea';
  @override
  String get yourPhase => 'Your phase';
  @override
  String get yourGoal => 'Your goal';
  @override
  String get willDo => 'I will do it';
  @override
  String get done => 'Noted. Nice!';
  @override
  String get another => 'Another idea';
  @override
  String get later => 'Later';
  @override
  String get laterTitle => 'When should we remind you?';
  @override
  String get tonight => 'Tonight';
  @override
  String get tomorrow => 'Tomorrow morning';
  @override
  String get weekend => 'This weekend';
  @override
  String get reminderSet => 'Done. We will remind you with a gentle nudge.';
  @override
  String get reminderSetNotificationsOff =>
      'Reminder saved. Turn notifications on in settings to receive it.';
  @override
  String get reminderError => 'Could not save the reminder. Try again.';
  @override
  String get emptyTitle => 'No ideas right now';
  @override
  String get emptyText => 'Come back later. In the meantime, note a slip.';
  @override
  String get errorTitle => 'Could not load the idea';
  @override
  String get errorText => 'Try again in a moment.';
}

// Path: inbox
class _Translations$inbox$en extends Translations$inbox$pt {
  _Translations$inbox$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Notifications';
  @override
  String get bellUnread => 'Notifications, something new';
  @override
  String get todayTitle => 'Today';
  @override
  String get earlierTitle => 'This week';
  @override
  String get markAllRead => 'Mark all as read';
  @override
  String get settingsAction => 'Notification settings';
  @override
  String get footnote =>
      'At most 2 alerts a day arrive as a notification. The rest stay only here.';
  @override
  String get emptyTitle => 'Nothing new here';
  @override
  String get emptyText => 'When someone sends a card or replies, it shows up here.';
  @override
  String get errorTitle => 'We could not load your notifications';
  @override
  String get partnerFallback => 'Your partner';
  @override
  String get tapToSee => 'Tap to see';
  @override
  String get cardReadyTitle => 'Your weekly card is ready';
  @override
  String get cardReadyText => 'Open to see the draft';
  @override
  String cardReceivedTitle({required Object name}) => '${name} sent you a card';
  @override
  String cardReactionTitle({required Object name}) => '${name} reacted to your card';
  @override
  String partnerJoinedTitle({required Object name}) => '${name} joined';
  @override
  String get partnerJoinedText => 'You are connected now';
  @override
  String get unpairedTitle => 'The connection ended';
  @override
  String get unpairedText => 'Your data is still yours';
  @override
  String partnerMessageTitle({required Object name}) => '${name} sent a message';
  @override
  String gameInviteTitle({required Object name}) => '${name} invited you to play';
  @override
  String get gameInviteText => 'Pick a time when you like';
  @override
  String signalTitle({required Object name}) => '${name} sent a note';
  @override
  String get dateComingTitle => 'A date is coming up';
  @override
  String get dateComingText => 'See ideas for the two of you';
  @override
  String get ritualTitle => 'Time for one of your rituals';
  @override
  String get dailyIdeaTitle => 'Idea of the day';
  @override
  String get dailyIdeaText => 'A small idea for today';
  @override
  String get gentleReturnTitle => 'We miss you';
  @override
  String get gentleReturnText => 'Come back whenever you like';
  @override
  String get capsuleOpenedTitle => 'A time capsule opened';
  @override
  String get capsuleOpenedText => 'See what you kept';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Check the internet and try again.',
    'other': 'Something went wrong. Try again.',
  };
  @override
  String gentleRequestTitle({required Object name}) => '${name} wrote a gentle request';
  @override
  String gentleRequestAnsweredTitle({required Object name}) => '${name} answered your request';
  @override
  String get annoyanceCheckTitle => 'Does this still bother you?';
  @override
  String get annoyanceCheckText => 'One of your notes goes away soon';
  @override
  String quizSharedTitle({required Object name}) => '${name} showed a quiz';
  @override
  String get spiceInviteTitle => 'An invite from Tempero';
  @override
  String get spiceInviteText => 'It only shows up if you both turn it on';
  @override
  String get spiceOffTitle => 'Tempero was turned off';
  @override
  String get spiceOffText => 'Nothing from the mode was kept';
  @override
  String memoryProposedTitle({required Object name}) => '${name} wants to keep a memory with you';
  @override
  String memoryAcceptedTitle({required Object name}) => '${name} accepted the memory';
  @override
  String memoryDeclinedTitle({required Object name}) => '${name} preferred not to keep the memory';
  @override
  String get memoryDeclinedText => 'It is no longer shared';
  @override
  String get plusBillingIssueTitle => 'There is a problem with the Plus payment';
  @override
  String get plusBillingIssueText => 'See what to do to keep it';
  @override
  String get plusCoverageEndedTitle => 'Plus coverage ended';
  @override
  String get plusCoverageEndedText => 'You keep everything you created';
}

// Path: intro
class _Translations$intro$en extends Translations$intro$pt {
  _Translations$intro$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get skip => 'Skip';
  @override
  String get continueButton => 'Continue';
  @override
  late final _Translations$intro$phase$en phase = _Translations$intro$phase$en._(_root);
  @override
  late final _Translations$intro$goals$en goals = _Translations$intro$goals$en._(_root);
  @override
  late final _Translations$intro$theme$en theme = _Translations$intro$theme$en._(_root);
}

// Path: invite
class _Translations$invite$en extends Translations$invite$pt {
  _Translations$invite$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object name}) => 'Invite ${name}';
  @override
  String get titleNoName => 'Invite your person';
  @override
  String get messageIntro => 'This message will be sent:';
  @override
  String message({required Object code}) =>
      'I started something small for us. To connect in the app, use the code ${code}.';
  @override
  String expiryNote({required Object days}) =>
      'The invite is valid for ${days} days. Only the latest invite you create works.';
  @override
  String get share => 'Share invite';
  @override
  String get copy => 'Copy invite';
  @override
  String get sentTitle => 'Invite sent';
  @override
  String get sentHighlight => 'sent';
  @override
  String sentText({required Object name}) =>
      '${name} has not joined yet. In the meantime you can use the app on your own.';
  @override
  String get sentTextNoName =>
      'Your person has not joined yet. In the meantime you can use the app on your own.';
  @override
  String get resend => 'Send again';
  @override
  String get revoke => 'Revoke';
  @override
  String get errorTitle => 'Could not create the invite';
  @override
  Map<String, String> get errors => {
    'ALREADY_PAIRED': 'You are already connected with someone.',
    'RATE_LIMITED': 'You created too many invites today. Try again tomorrow.',
    'NETWORK': 'No connection. Check your internet and try again.',
    'other': 'Something went wrong. Try again.',
  };
  @override
  String get shareTitle => 'Share invite';
  @override
  String get waitingTitle => 'Waiting for your partner';
}

// Path: language
class _Translations$language$en extends Translations$language$pt {
  _Translations$language$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get language => 'Language';
  @override
  String get languagePortuguese => 'Portuguese (Brazil)';
  @override
  String get languageEnglish => 'English';
  @override
  String get comingSoon => 'Coming soon';
  @override
  String get languageNote => 'English is finished later.';
  @override
  String get saveError => 'Could not save. Try again.';
}

// Path: learned
class _Translations$learned$en extends Translations$learned$pt {
  _Translations$learned$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'What I learned';
  @override
  String get intro => 'Things you chose to keep from the conversation. Only you see them.';
  @override
  String get pendingTitle => 'To review';
  @override
  String get confirmedTitle => 'Confirmed';
  @override
  Map<String, String> get targets => {
    'partnerFact': 'About my partner',
    'date': 'A date',
    'memory': 'A memory',
    'commitment': 'A promise',
  };
  @override
  String get confirm => 'Confirm';
  @override
  String get edit => 'Edit';
  @override
  String get discard => 'Discard';
  @override
  String get confirmTitle => 'Confirm this learning?';
  @override
  String get confirmText => 'It will show in What I learned. Only you see it.';
  @override
  String get discardTitle => 'Discard this learning?';
  @override
  String get discardText => 'It will not be saved.';
  @override
  String get discardConfirm => 'Discard';
  @override
  String get editTitle => 'Edit learning';
  @override
  String get editHint => 'What you want to keep';
  @override
  Map<String, String> get textErrors => {
    'empty': 'Write what you want to keep',
    'tooLong': 'This is too long',
  };
  @override
  String get save => 'Save';
  @override
  String get partnerFactLabel => 'From the conversation';
  @override
  String get updated => 'Learning updated';
  @override
  String get emptyTitle => 'Nothing kept yet';
  @override
  String get emptyText => 'When you want, save a reply from the conversation to remember it later.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: lists
class _Translations$lists$en extends Translations$lists$pt {
  _Translations$lists$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Lists';
  @override
  String get subtitle => 'Trips, places and films, shared or just for you.';
  @override
  String get newList => 'New list';
  @override
  String get createTitle => 'New list';
  @override
  String get titleLabel => 'Name';
  @override
  String get titleHint => 'E.g. Trips of our dreams';
  @override
  Map<String, String> get titleErrors => {
    'empty': 'Give the list a name.',
    'tooLong': 'Use at most 80 characters.',
  };
  @override
  String get kindLabel => 'Type';
  @override
  String get visibilityLabel => 'Who can see it';
  @override
  String get sharedHint => 'You both can see and change this list.';
  @override
  String get privateHint => 'Only you can see this list.';
  @override
  Map<String, String> get kinds => {
    'travel': 'Travel',
    'restaurants': 'Restaurants',
    'movies': 'Movies',
    'custom': 'Other',
    'other': '',
  };
  @override
  String get shared => 'Shared';
  @override
  String get private => 'Private';
  @override
  String get emptyTitle => 'No lists yet';
  @override
  String get emptyTextShared => 'Start a list of things you want to do together.';
  @override
  String get emptyTextPrivate => 'Start a list of things you want to keep for yourself.';
  @override
  String get create => 'Create list';
  @override
  String get rename => 'Rename';
  @override
  String get delete => 'Delete';
  @override
  String get renameTitle => 'Rename list';
  @override
  String get save => 'Save';
  @override
  String get deleteTitle => 'Delete list?';
  @override
  String get deleteTextShared => 'The list and everything in it will be gone for both of you.';
  @override
  String get deleteTextPrivate => 'The list and everything in it will be gone for good.';
  @override
  String get deleteConfirm => 'Delete';
  @override
  String get itemDeleteTitle => 'Delete item?';
  @override
  String get itemDeleteTextShared => 'This item will be gone for both of you.';
  @override
  String get itemDeleteTextPrivate => 'This item will be gone for good.';
  @override
  String get itemDeleteConfirm => 'Delete item';
  @override
  String get makePrivate => 'Make private';
  @override
  String get shareWithPartner => 'Share with your partner';
  @override
  String get addItem => 'Add item';
  @override
  String get itemHint => 'E.g. Lisbon';
  @override
  Map<String, String> get itemTitleErrors => {
    'empty': 'Type the item name.',
    'tooLong': 'Use at most 160 characters.',
  };
  @override
  String get add => 'Add';
  @override
  String get itemEmptyTitle => 'Nothing here yet';
  @override
  String get itemEmptyTextShared => 'Add the first thing you want to do together.';
  @override
  String get itemEmptyTextPrivate => 'Add the first thing to this list.';
  @override
  Map<String, String> get statuses => {
    'dream': 'Dream',
    'planned': 'Planned',
    'done': 'Done',
    'other': '',
  };
  @override
  String get markDream => 'Mark as a dream';
  @override
  String get markPlanned => 'Mark as planned';
  @override
  String get markDone => 'Mark as done';
  @override
  String get moveUp => 'Move up';
  @override
  String get moveDown => 'Move down';
  @override
  String get itemOptions => 'Item options';
  @override
  String get listOptions => 'List options';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: logistics
class _Translations$logistics$en extends Translations$logistics$pt {
  _Translations$logistics$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Logistics';
  @override
  String get subtitle => 'The practical things, with nobody carrying them alone.';
  @override
  String get hint => 'E.g. call the plumber';
  @override
  String get add => 'Add';
  @override
  String get me => 'Me';
  @override
  String get partner => 'My partner';
  @override
  String get both => 'Both of us';
  @override
  String get assignMe => 'I\'ll take it';
  @override
  String get delete => 'Delete';
  @override
  String get doneTitle => 'Done';
  @override
  String get emptyTitle => 'Nothing here';
  @override
  String get emptyText => 'Add something practical you need to sort out.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'The list is still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
  @override
  String get confirm => 'Confirm';
  @override
  String get waitingYou => 'Waiting for you';
  @override
  String get waitingPartner => 'Waiting for the other person';
}

// Path: loveStyle
class _Translations$loveStyle$en extends Translations$loveStyle$pt {
  _Translations$loveStyle$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String questionOf({required Object current, required Object total}) =>
      'Question ${current} of ${total}';
  @override
  List<String> get questions => [
    'What makes you feel loved the most?',
    'On a hard day, what comforts you the most?',
    'What do you notice first when your partner shows care?',
    'Which of these gestures warms your heart?',
    'What makes you feel important to someone?',
    'If you could choose one gesture for today, what would it be?',
  ];
  @override
  List<String> get questionHighlights => [
    'loved',
    'comforts',
    'care',
    'heart',
    'important',
    'gesture',
  ];
  @override
  Map<String, String> get options1 => {
    'time': 'Spending unhurried time together.',
    'words': 'Hearing that I matter.',
    'acts': 'Seeing the person help me with something.',
    'gifts': 'Getting a small gift for no reason.',
    'touch': 'A long hug.',
    'other': '',
  };
  @override
  Map<String, String> get options2 => {
    'time': 'Having someone nearby, with no rush to fix it.',
    'words': 'A message saying I\'m on their mind.',
    'acts': 'Someone taking a task off my hands.',
    'gifts': 'A small care that arrived by surprise.',
    'touch': 'A tight hug.',
    'other': '',
  };
  @override
  Map<String, String> get options3 => {
    'time': 'When the person puts the phone down to be with me.',
    'words': 'When the person praises something I did.',
    'acts': 'When the person notices what I need and does it.',
    'gifts': 'When the person remembers something I like.',
    'touch': 'When the person touches me lightly as they pass.',
    'other': '',
  };
  @override
  Map<String, String> get options4 => {
    'time': 'A quiet date, just the two of us.',
    'words': 'A conversation where I feel heard.',
    'acts': 'A small help with a task.',
    'gifts': 'A simple gift that has to do with me.',
    'touch': 'A caress on my hair or hand.',
    'other': '',
  };
  @override
  Map<String, String> get options5 => {
    'time': 'When someone chooses to spend time with me.',
    'words': 'When someone acknowledges what I do.',
    'acts': 'When someone makes my day easier.',
    'gifts': 'When someone remembers me with a detail.',
    'touch': 'When someone hugs me without needing to speak.',
    'other': '',
  };
  @override
  Map<String, String> get options6 => {
    'time': 'Saving a free evening for us.',
    'words': 'Writing a loving note.',
    'acts': 'Tackling a boring task together.',
    'gifts': 'Picking a small gift.',
    'touch': 'Holding hands.',
    'other': '',
  };
  @override
  String get continueAction => 'Next';
  @override
  String get finishAction => 'See result';
  @override
  String get back => 'Back';
  @override
  String get privateNote => 'Only you see your answers. You choose whether to show the result.';
  @override
  String get resultTitle => 'What makes you feel loved';
  @override
  String get resultHighlight => 'loved';
  @override
  String get resultSubtitle => 'A reading of what fits you best.';
  @override
  Map<String, String> get labels => {
    'time': 'Time just for us',
    'words': 'Words of care',
    'acts': 'Help with tasks',
    'gifts': 'Small gifts',
    'touch': 'Touch and hugs',
    'other': '',
  };
  @override
  Map<String, String> get commonLabels => {
    'time': 'time just for us',
    'words': 'words of care',
    'acts': 'help with tasks',
    'gifts': 'small gifts',
    'touch': 'touch and hugs',
    'other': '',
  };
  @override
  Map<String, String> get descriptions => {
    'time': 'You feel loved when you have real time with someone you care about: unhurried, no screens, just presence.',
    'words': 'You feel loved when you hear, honestly, what the other person feels for you.',
    'acts': 'You feel loved when someone notices what you need and helps without being asked.',
    'gifts': 'You feel loved when someone remembers you in a small detail, chosen with care.',
    'touch': 'You feel loved when a hug, a held hand or a caress says what words cannot.',
    'other': '',
  };
  @override
  String get resultPrivacyNote =>
      'Saved only for you until you show it. You can undo it whenever you want.';
  @override
  String get saveManualAction => 'Save to My manual';
  @override
  String get savedManualAction => 'Saved to My manual';
  @override
  String get manualToast => 'Saved to My manual.';
  @override
  String shareAction({required Object name}) => 'Show ${name}';
  @override
  String revokeAction({required Object name}) => 'Stop showing ${name}';
  @override
  String shareConfirmTitle({required Object name}) => 'Show ${name}?';
  @override
  String shareConfirmText({required Object name}) =>
      'Only the result appears, never your answers. ${name} gets a notice and may choose not to respond.';
  @override
  String get shareConfirm => 'Show';
  @override
  String get shareCancel => 'Not now';
  @override
  String shareToast({required Object name}) => 'Done. ${name} can see the result now.';
  @override
  String revokeToast({required Object name}) => '${name} can no longer see it.';
  @override
  String get shareSoloNote =>
      'It stays with you. When someone joins, you decide whether to show it.';
  @override
  String get inviteAction => 'Invite my person';
  @override
  String get compareAction => 'Compare the two';
  @override
  String get compareTitle => 'The two of you';
  @override
  String get compareHeadline => 'What makes you both feel loved';
  @override
  String get compareHighlight => 'both';
  @override
  String get compareYou => 'You';
  @override
  String get compareMost => 'Most important';
  @override
  String get compareNext => 'Then';
  @override
  String get compareCommon => 'In common';
  @override
  String compareCommonText({required Object label}) => 'You both value ${label}.';
  @override
  String get comparePlan => 'Plan time just for us';
  @override
  String get compareMissingTitle => 'The comparison is not ready yet';
  @override
  String get compareMissingText => 'It appears when both of you have shown your result.';
  @override
  String get partnerFallback => 'your partner';
  @override
  String get pairingErrorNote => 'Couldn\'t check your partner right now.';
  @override
  String get retryPairing => 'Try again';
  @override
  String get retake => 'Take the quiz again';
  @override
  String get loadErrorTitle => 'Couldn\'t load';
  @override
  String get loadErrorText => 'Couldn\'t open your result right now. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your answers are still here.',
  };
  @override
  Map<String, String> get manualErrors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save to My manual right now. Try again.',
  };
  @override
  Map<String, String> get shareErrors => {
    'NOT_PAIRED': 'You don\'t have a connected partner yet.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t show it right now. Try again.',
  };
  @override
  Map<String, String> get revokeErrors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t stop showing it right now. Try again.',
  };
}

// Path: memories
class _Translations$memories$en extends Translations$memories$pt {
  _Translations$memories$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Memories';
  @override
  String get historyLabel => 'OUR HISTORY';
  @override
  String get historyTitle => 'Our history';
  @override
  String get historyText => 'Milestones, dates, places and our story in numbers.';
  @override
  String get placesLabel => 'PLACES';
  @override
  String get placesText => 'Only the name of the place, never the location.';
  @override
  String get placeLabel => 'Place (optional)';
  @override
  String get placeHint => 'E.g. Lisbon';
  @override
  String get placeAddressNote => 'Prefer just the name of the place, with no address or number.';
  @override
  String get segmentTimeline => 'Timeline';
  @override
  String get segmentJar => 'Jar';
  @override
  String get jarEmpty => 'When a slip feels good, keep it in the jar from its details.';
  @override
  String get jarAnother => 'Another';
  @override
  String get jarClose => 'Close';
  @override
  String get titleLabel => 'A memory';
  @override
  String get titleHint => 'E.g. our first dinner';
  @override
  Map<String, String> get titleErrors => {
    'empty': 'Give this memory a title',
    'tooLong': 'The title is too long',
  };
  @override
  Map<String, String> get placeErrors => {'tooLong': 'The place is too long'};
  @override
  Map<String, String> get bodyErrors => {'tooLong': 'The note is too long'};
  @override
  String get bodyHint => 'Tell how it went (optional)';
  @override
  String get add => 'Add a memory';
  @override
  String get save => 'Save memory';
  @override
  String get delete => 'Delete';
  @override
  String get deleteTitle => 'Delete this memory?';
  @override
  String get deleteText => 'It disappears from the timeline for both of you.';
  @override
  String get deleteConfirm => 'Delete';
  @override
  String get detailPlace => 'Place';
  @override
  String get detailBody => 'How it went';
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String dateLine({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  String get emptyTitle => 'No memories yet';
  @override
  String get emptyText => 'Keep moments you want to look back on.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your memories are still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Your text is still here.',
  };
  @override
  String get jarEmptyTitle => 'The jar is empty';
  @override
  String get jarEmptyAction => 'See my slips';
  @override
  late final _Translations$memories$menu$en menu = _Translations$memories$menu$en._(_root);
  @override
  late final _Translations$memories$onThisDay$en onThisDay = _Translations$memories$onThisDay$en._(
    _root,
  );
}

// Path: mood
class _Translations$mood$en extends Translations$mood$pt {
  _Translations$mood$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'How are you today?';
  @override
  String get titleHighlight => 'today';
  @override
  String get subtitle => 'One tap. The “I need…” tag is optional.';
  @override
  String get privateCue => 'Only you see this';
  @override
  String sharedCue({required Object name}) => 'shared with ${name}';
  @override
  String get sharedCueNoName => 'shared with your partner';
  @override
  Map<String, String> get moods => {
    'happy': 'Happy',
    'tired': 'Tired',
    'sad': 'Sad',
    'stressed': 'Stressed',
    'loving': 'Loving',
    'playful': 'Playful',
  };
  @override
  String get needTitle => 'I need…';
  @override
  Map<String, String> get needs => {
    'listen': 'To be heard',
    'opinion': 'An opinion',
    'hug': 'A hug',
    'space': 'Some space',
    'chocolate': 'Chocolate',
    'cuteMessage': 'A cute message',
    'foreheadKiss': 'A kiss on the forehead',
    'company': 'Some company',
    'rest': 'To rest',
  };
  @override
  String get needMenuAction => 'I need…';
  @override
  String needMenuActionSelected({required Object need}) => 'I need: ${need}';
  @override
  String get needSheetSubtitle =>
      'One thing a day. Your partner sees it only if you share your mood.';
  @override
  String get needSaved => 'Saved';
  @override
  String get shareSubtitle => 'You decide. Nothing is shared by default.';
  @override
  String get shareNeedFirst => 'Pick an “I need…” first.';
  @override
  Map<String, String> get share => {
    'none': 'Keep private',
    'mood': 'Only my mood',
    'moodNeed': 'Mood and what I need',
  };
  @override
  Map<String, String> get shareSupport => {
    'none': 'Nothing is shared.',
    'mood': 'Your partner sees the mood only.',
    'moodNeed': 'Your partner sees the mood and the need.',
  };
  @override
  String get privacyNote =>
      'Nothing is shared by default. Your partner never sees a chart or a score.';
  @override
  String get save => 'Save';
  @override
  String get saved => 'Mood saved';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'Couldn\'t save your mood. Check your connection and try again.',
    'TIMEOUT': 'Couldn\'t save your mood in time. Try again.',
    'other': 'Couldn\'t save your mood. Try again.',
  };
  @override
  String get entryCategory => 'Mood of the day';
  @override
  String get entryTitle => 'How are you today?';
  @override
  String get entryText => 'One tap. Only you see it until you share.';
  @override
  String get partnerLabel => 'Your partner\'s mood';
  @override
  String get partnerFallback => 'Your partner';
  @override
  String partnerHappy({required Object name}) => '${name} is happy today';
  @override
  String partnerTired({required Object name}) => '${name} is out of energy today';
  @override
  String partnerSad({required Object name}) => '${name} is feeling low today';
  @override
  String partnerStressed({required Object name}) => '${name} has a lot on their mind today';
  @override
  String partnerLoving({required Object name}) => '${name} is feeling tender today';
  @override
  String partnerPlayful({required Object name}) => '${name} is in a playful mood today';
  @override
  String get partnerNeedListen => 'What helps: just listening.';
  @override
  String get partnerNeedOpinion => 'What helps: an opinion.';
  @override
  String get partnerNeedHug => 'What helps: a hug.';
  @override
  String get partnerNeedSpace => 'What helps: some space.';
  @override
  String get partnerNeedChocolate => 'What helps: some chocolate.';
  @override
  String get partnerNeedCuteMessage => 'What helps: a cute message.';
  @override
  String get partnerNeedForeheadKiss => 'What helps: a kiss on the forehead.';
  @override
  String get partnerNeedCompany => 'What helps: some company.';
  @override
  String get partnerNeedRest => 'What helps: rest.';
  @override
  String partnerSharedChoice({required Object name}) => '${name} chose to share this with you.';
  @override
  String get homeTitle => 'How are you?';
  @override
  String get homePrivacy => 'Only you see it';
  @override
  String homePrivacyShared({required Object name}) => '${name} sees it';
  @override
  String get homePrivacySharedNoName => 'Your partner sees it';
  @override
  String get homeLoadFailed => 'Couldn\'t load it. Tap to open.';
  @override
  String get homeDetailsLink => 'What your partner sees';
  @override
  Map<String, String> get homeMoods => {
    'happy': 'Good',
    'loving': 'Loving',
    'tired': 'Tired',
    'stressed': 'Tense',
    'sad': 'Sad',
  };
  @override
  String get next => 'Next';
  @override
  String get shareAction => 'Share';
  @override
  String shareHeadline({required Object name}) => 'Share with ${name}?';
  @override
  String get shareHeadlineNoName => 'Share with your person?';
  @override
  String get shareHeadlineNoNameHighlight => 'your person';
  @override
  String get calendarTitle => 'My moods';
  @override
  String calendarMonth({required Object month, required Object year}) => '${month} ${year}';
  @override
  String get calendarEmpty => 'No mood recorded this month yet.';
  @override
  String get calendarPrivacyNote =>
      'Only you see this. It never shows up for your partner unless it was shared for the day.';
  @override
  String get calendarAction => 'Record my mood';
  @override
  String get calendarErrorTitle => 'Couldn\'t open your moods';
  @override
  String get calendarErrorText => 'Nothing was lost. Try again.';
  @override
  List<String> get monthNames => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}

// Path: moodHelp
class _Translations$moodHelp$en extends Translations$moodHelp$pt {
  _Translations$moodHelp$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get listenTitle => 'Listen first';
  @override
  String get listenSubtitle => 'No rush, no pressure to answer.';
  @override
  String get talkLabel => 'Talk';
  @override
  String get askToTalk => 'Ask if they want to talk';
  @override
  String get askToTalkSupport => 'An open question, with no rush for an answer.';
  @override
  String get careLabel => 'Care';
  @override
  String get sendLove => 'Send a little love';
  @override
  String get sendLoveSupport => 'A hug arrives as a signal in the app.';
  @override
  String get helpLabel => 'Help';
  @override
  String get seeHowToHelp => 'See how to help';
  @override
  String get seeHowToHelpSupport => 'Small things for today.';
  @override
  String get helpTitle => 'How to help today';
  @override
  String get helpSubtitle => 'Small things, at today\'s pace.';
  @override
  String get suggestionLabel => 'Suggestion';
  @override
  String get takeChore => 'Take on a chore';
  @override
  String get takeChoreSupport => 'Pick one thing at home and handle it without asking.';
  @override
  String get askListenOrSpace => 'Ask: do you want to talk or have space?';
  @override
  String get askListenOrSpaceSupport => 'Let the answer choose the next step.';
  @override
  String get sendSweetMessage => 'Send a short, sweet message';
  @override
  String sweetMessagePreview({required Object body}) => 'It reads: “${body}”';
  @override
  String get sweetMessageBody => 'No rush. I\'m here.';
  @override
  String get makeCoffeeOrDinner => 'Make coffee or dinner';
  @override
  String get makeCoffeeOrDinnerSupport => 'Without turning it into a shared task.';
  @override
  String get noDiagnosisNote => 'App suggestions, not a diagnosis. No rush.';
  @override
  String get reactionLabel => 'Send a heart';
  @override
  String get sent => 'Heart sent';
  @override
  String get askSent => 'Question sent';
  @override
  String get messageSent => 'Message sent';
  @override
  String partnerNeedTitle({required Object name}) => 'What ${name} needs';
  @override
  String get partnerNeedTitleGeneric => 'What your partner needs';
  @override
  String get partnerNeedSubtitle => 'Today\'s ask. No pressure.';
  @override
  String get partnerNeedNote => 'This comes from the mood your partner shared today.';
  @override
  Map<String, String> get partnerNeedActions => {
    'listen': 'Just listen',
    'opinion': 'Give an opinion',
    'hug': 'Send a hug',
    'space': 'Give some space',
    'chocolate': 'Bring some chocolate',
    'cuteMessage': 'Open the chat',
    'foreheadKiss': 'A kiss on the forehead',
    'company': 'Stay close',
    'rest': 'Let them rest',
    'other': '',
  };
  @override
  Map<String, String> get partnerNeedSupports => {
    'listen': 'No advice, no fixing.',
    'opinion': 'An honest opinion, without judging.',
    'hug': 'It arrives as a signal in the app.',
    'space': 'Some time without asking for an answer.',
    'chocolate': 'A small chocolate, no reason needed.',
    'cuteMessage': 'One kind line is enough.',
    'foreheadKiss': 'Small and unhurried.',
    'company': 'Sit nearby, no words needed.',
    'rest': 'Take what you can off their plate.',
    'other': '',
  };
  @override
  Map<String, String> get errors => {
    'NOT_PAIRED': 'You are not connected yet.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'NETWORK': 'Couldn\'t send it now. Check your connection and try again.',
    'TIMEOUT': 'Couldn\'t send it in time. Try again.',
    'other': 'Couldn\'t send it now. Try again.',
  };
}

// Path: need
class _Translations$need$en extends Translations$need$pt {
  _Translations$need$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'I need…';
  @override
  String get titleHighlight => 'need';
  @override
  String get subtitle => 'Pick one thing. Your partner gets a gentle note, no pressure.';
  @override
  Map<String, String> get options => {
    'hug': 'A hug',
    'talk': 'To talk',
    'help_home': 'Help at home',
    'quiet': 'Some quiet time',
    'time_together': 'Time together',
    'rest': 'To rest',
    'other': '',
  };
  @override
  String get note => 'It\'s not a demand. It\'s just a simple way to ask.';
  @override
  String get send => 'Send';
  @override
  late final _Translations$need$sent$en sent = _Translations$need$sent$en._(_root);
  @override
  Map<String, String> get errors => {
    'NOT_PAIRED': 'To send this, you need to be connected with your partner in the app.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t send right now. Try again.',
  };
}

// Path: notFound
class _Translations$notFound$en extends Translations$notFound$pt {
  _Translations$notFound$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '404';
  @override
  String get description => 'Page not found';
  @override
  String get buttonBack => 'Go back home';
}

// Path: notes
class _Translations$notes$en extends Translations$notes$pt {
  _Translations$notes$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'A note or a drawing';
  @override
  String get intro => 'A short note for your partner, or a drawing that stays in your sent list.';
  @override
  List<String> get kinds => ['Note', 'Drawing'];
  @override
  String get noteHint => 'E.g. good luck at today\'s meeting';
  @override
  Map<String, String> get textErrors => {
    'empty': 'Write the note first',
    'tooLong': 'This note is too long',
  };
  @override
  String get canvasLabel => 'Drawing area';
  @override
  List<String> get pens => ['Black', 'Orange', 'Purple', 'Green'];
  @override
  String get eraser => 'Eraser';
  @override
  String get undo => 'Undo';
  @override
  String get clear => 'Clear';
  @override
  String get emptyDrawing => 'Draw something to be able to send it.';
  @override
  String get startDrawing => 'Draw';
  @override
  String get continueDrawing => 'Keep drawing';
  @override
  String get done => 'Done';
  @override
  String get widgetLabel => 'Send to the widget';
  @override
  String get widgetText => 'It appears on their widget if they allow notes.';
  @override
  String get drawingHint => 'Drawings stay in your sent list. Widget notes are text-only for now.';
  @override
  String get unpairedTitle => 'Connect with your partner';
  @override
  String get unpairedText =>
      'You need to be connected with your partner to send a note or drawing.';
  @override
  String get send => 'Send';
  @override
  String get sent => 'Sent';
  @override
  String get sentTitle => 'Sent by you';
  @override
  String get justNow => 'Just now';
  @override
  String minutesAgo({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 min ago',
        other: '${count} min ago',
      );
  @override
  String hoursAgo({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 h ago',
        other: '${count} h ago',
      );
  @override
  String daysAgo({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 day ago',
        other: '${count} days ago',
      );
  @override
  String get drawingAlt => 'Drawing';
  @override
  String get delete => 'Delete';
  @override
  String get deleteConfirmTitle => 'Delete this?';
  @override
  String get deleteConfirmText =>
      'It leaves your sent list. Notes also leave your partner\'s widget.';
  @override
  String get deleteConfirm => 'Delete now';
  @override
  String get deleted => 'Deleted';
  @override
  String get deleteError => 'Couldn\'t delete right now. Try again.';
  @override
  String get emptyTitle => 'Nothing sent yet';
  @override
  String get emptyText => 'When you send a note or a drawing, it shows up here.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'NOT_PAIRED': 'To send this, you need to be connected with your partner in the app.',
    'other': 'Couldn\'t send right now. What you wrote is still here.',
  };
}

// Path: notificationPermission
class _Translations$notificationPermission$en extends Translations$notificationPermission$pt {
  _Translations$notificationPermission$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Reminders';
  @override
  String get title => 'Gentle reminders?';
  @override
  String get titleHighlight => 'Gentle';
  @override
  String get pointLimit => 'At most 1 or 2 a day.';
  @override
  String get pointPrivate => 'They never show names on the lock screen.';
  @override
  String get pointChoice => 'You choose what arrives and when.';
  @override
  String get changeLater => 'You can change this whenever you like.';
  @override
  String get notNow => 'Not now';
  @override
  String get allow => 'Allow';
  @override
  String get registrationFailed =>
      'The system allowed reminders, but we couldn\'t connect this phone.';
  @override
  String get retryRegistration => 'Try again';
  @override
  String get continueWithoutReminders => 'Continue without reminders';
  @override
  String get offBanner => 'Reminders are off. Turn them on in settings.';
  @override
  String get openSettings => 'Open settings';
  @override
  String get close => 'Close';
  @override
  Map<String, String> get errors => {
    'registerDevice': 'Could not turn notifications on for this phone. Try again later.',
    'other': 'Could not turn notifications on. Try again.',
  };
}

// Path: notificationPreferences
class _Translations$notificationPreferences$en extends Translations$notificationPreferences$pt {
  _Translations$notificationPreferences$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Reminders';
  @override
  String get systemOff =>
      'Notifications are off on this phone. Your choices apply when you turn them on.';
  @override
  String get openSystem => 'Open settings';
  @override
  String get perDayTitle => 'Per day';
  @override
  String get perDaySupport => 'At most';
  @override
  String perDayValue({required Object count}) => 'Up to ${count}';
  @override
  String get perDaySheetTitle => 'How many reminders a day?';
  @override
  String get typesTitle => 'Types';
  @override
  late final _Translations$notificationPreferences$types$en types =
      _Translations$notificationPreferences$types$en._(_root);
  @override
  List<String> get days => [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  @override
  String hourFormat({required Object hour}) => '${hour}:00';
  @override
  String get note => 'A hard limit of 1 to 2 messages a day. Each type can be switched off.';
  @override
  String get loadErrorTitle => 'Could not open your reminders';
  @override
  String get loadErrorText => 'They are still saved. Try again.';
  @override
  late final _Translations$notificationPreferences$errors$en errors =
      _Translations$notificationPreferences$errors$en._(_root);
}

// Path: partnerProfile
class _Translations$partnerProfile$en extends Translations$partnerProfile$pt {
  _Translations$partnerProfile$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'About your partner';
  @override
  String get privateNote =>
      'Only you see these notes. They never show in notifications, widgets or to your partner.';
  @override
  Map<String, String> get categories => {
    'likes': 'Likes',
    'dislikes': 'Dislikes',
    'sizes': 'Sizes',
    'health': 'Health',
    'comfort': 'Comfort',
    'people': 'People',
    'other': 'Other',
  };
  @override
  String get labelLabel => 'Topic';
  @override
  String get labelHint => 'E.g. coffee';
  @override
  Map<String, String> get labelErrors => {
    'empty': 'Give the note a topic.',
    'tooLong': 'Use at most 80 characters.',
  };
  @override
  String get valueHint => 'E.g. no sugar, very hot';
  @override
  Map<String, String> get valueErrors => {
    'empty': 'Write what you want to remember.',
    'tooLong': 'Use at most 500 characters.',
  };
  @override
  String get save => 'Save note';
  @override
  String get delete => 'Delete';
  @override
  String get emptyTitle => 'No notes yet';
  @override
  String get emptyText => 'Small details help you pick a gift or a gesture.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your notes are still saved. Try again.';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Your text is still here.',
  };
}

// Path: partnerStep
class _Translations$partnerStep$en extends Translations$partnerStep$pt {
  _Translations$partnerStep$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Want to bring your partner?';
  @override
  String get titleHighlight => 'partner';
  @override
  String get subtitle => 'The app works on your own. Invite whenever you want.';
  @override
  String get inviteTitle => 'Send an invite';
  @override
  String get inviteSupport => 'Your person joins with a code';
  @override
  String get aloneTitle => 'Start on my own for now';
  @override
  String get aloneSupport => 'Your slips stay with you only';
  @override
  String get haveCode => 'I have an invite code';
  @override
  String get continueButton => 'Continue';
  @override
  String get soloOnlyTitle => 'Just for me';
  @override
  String get soloOnlySupport => 'Without inviting anyone';
  @override
  String get whyInvite => 'Why invite?';
  @override
  late final _Translations$partnerStep$why$en why = _Translations$partnerStep$why$en._(_root);
}

// Path: plus
class _Translations$plus$en extends Translations$plus$pt {
  _Translations$plus$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Mingo Plus';
  @override
  String get subtitle => 'Compare calmly. The free plan stays whole for the essentials.';
  @override
  String get activeTitle => 'You have Plus';
  @override
  String get activeText => 'Thank you. Everything is unlocked for you and your partner.';
  @override
  String get paidByPartner => 'Your partner has Plus and it covers you both.';
  @override
  String freeLeft({required Object games, required Object rituals, required Object lists}) =>
      'On the free plan you have ${games}, ${rituals} and ${lists} left.';
  @override
  String gameCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 game this week',
        other: '${count} games this week',
      );
  @override
  String ritualCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 ritual',
        other: '${count} rituals',
      );
  @override
  String listCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 list',
        other: '${count} lists',
      );
  @override
  String get freeName => 'Free';
  @override
  String get freeFeatures =>
      'Unlimited slips and cards, repair, 3 games a week, 3 rituals, 3 lists and everything you already saved.';
  @override
  String get plusName => 'Plus';
  @override
  String get plusFeatures =>
      'Unlimited games, rituals and lists, more chats with the mascot and more for both of you, covering you and your partner.';
  @override
  String get monthly => 'Monthly';
  @override
  String get yearly => 'Yearly';
  @override
  String get storeTitle => 'Couldn\'t load the prices';
  @override
  String get storeText => 'The store didn\'t answer. Nothing was charged. Try again.';
  @override
  String get subscribe => 'Subscribe';
  @override
  String get started => 'Plus is on. Thank you.';
  @override
  String get pending => 'Purchase received. We\'re confirming, Plus will show up shortly.';
  @override
  String get purchaseError => 'Couldn\'t complete the purchase. Nothing was charged.';
  @override
  String get billingTitle => 'Payment problem';
  @override
  String get billingText =>
      'The last payment didn\'t go through. Plus stays on for now. Open your subscriptions in the store and update the payment method.';
  @override
  String get alwaysFree => 'Unpairing is never locked.';
  @override
  String get lockLabel => 'PLUS';
  @override
  String get lockText => 'Available with Plus. Tap to see the plans.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  String get manageTitle => 'Manage Plus';
  @override
  String get planRow => 'Plan';
  @override
  String get statusRow => 'Status';
  @override
  String get coversRow => 'Covers';
  @override
  String get coversBoth => 'You and your partner';
  @override
  String get coveredByPartner => 'Your partner';
  @override
  String get plusActive => 'Plus active';
  @override
  String get statusActive => 'Active';
  @override
  String get statusTrialing => 'Trial';
  @override
  String get statusGrace => 'Payment pending';
  @override
  String get statusBillingIssue => 'Payment problem';
  @override
  String get manageInStore => 'Manage in store';
  @override
  String get seePlus => 'See Plus';
  @override
  String get managePlan => 'Manage plan';
  @override
  String get restorePurchases => 'Restore purchases';
  @override
  String get partnerPays => 'Your partner looks after this subscription.';
  @override
  String get partnerCancel => 'If either partner cancels, Plus ends for both, with a clear notice.';
  @override
  String get storeIssueTitle => 'The store didn\'t open';
  @override
  String get restoreLoadingTitle => 'Restoring purchases';
  @override
  String get restoreLoadingText => 'This takes a few seconds.';
  @override
  String get restoredTitle => 'Purchases restored';
  @override
  String get restoredHighlight => 'restored';
  @override
  String get restoredText => 'We found your Plus in the store.';
  @override
  String get pendingRestoreTitle => 'We found a purchase';
  @override
  String get pendingRestoreHighlight => 'purchase';
  @override
  String get pendingRestoreText =>
      'It can take a moment, or sign in with the account that bought it.';
  @override
  String get nothingTitle => 'Nothing to restore';
  @override
  String get nothingHighlight => 'restore';
  @override
  String get nothingText =>
      'We found no active purchases in this store. If you subscribed with another account, sign in with it and try again.';
  @override
  String get restoreFailedTitle => 'Couldn\'t restore';
  @override
  String get restoreFailedHighlight => 'restore';
  @override
  String get tryAgain => 'Try again';
  @override
  String get done => 'Done';
  @override
  Map<String, String> get errors => {
    'storeUnavailable': 'The store isn\'t available on this device right now.',
    'manageUnavailable': 'There\'s no store page for this subscription here.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
}

// Path: privacy
class _Translations$privacy$en extends Translations$privacy$pt {
  _Translations$privacy$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Privacy and security';
  @override
  String get partnerTitle => 'What your partner sees';
  @override
  String get partnerSlips => 'Sent slips';
  @override
  String get partnerSlipsText => 'Only what you send';
  @override
  String get partnerPrivateSlips => 'Private slips';
  @override
  String get partnerTemperature => 'Temperature';
  @override
  String get partnerJournal => 'Journal';
  @override
  String get never => 'Never';
  @override
  String get partnerNote => 'Whoever makes the data decides who sees it.';
  @override
  String get ourTitle => 'What we can see';
  @override
  String get ourEncrypted => 'Your content is encrypted in transit.';
  @override
  String get ourPrivate => 'The team cannot read your private notes.';
  @override
  String get ourAnalytics => 'Analytics: counts only.';
  @override
  String get ourPlain => 'This page in plain language.';
  @override
  String get consents => 'Consents';
  @override
  String get analytics => 'Analytics';
  @override
  String get marketing => 'Marketing';
  @override
  String get ai => 'AI (when available)';
  @override
  String get terms => 'Terms';
  @override
  String get required => 'Required';
  @override
  String get requiredNote => 'Accepting the Terms is required to use the app.';
  @override
  String get consentsNote => 'Changes apply now.';
  @override
  String get saveError => 'Could not save now. Try again.';
  @override
  String get errorTitle => 'Could not load the consents';
  @override
  String get errorText => 'Try again in a moment.';
}

// Path: profileDetails
class _Translations$profileDetails$en extends Translations$profileDetails$pt {
  _Translations$profileDetails$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Profile';
  @override
  String get nameLabel => 'Your name';
  @override
  String get nameHint => 'Your first name';
  @override
  Map<String, String> get nameErrors => {
    'empty': 'Your name cannot be empty.',
    'tooLong': 'Use at most 30 characters.',
  };
  @override
  String get pronounsLabel => 'Pronouns';
  @override
  String get timeZoneLabel => 'Time zone';
  @override
  String get timeZonePlaceholder => 'Pick a time zone';
  @override
  String get loginLabel => 'Login';
  @override
  String get loginAccount => 'Account';
  @override
  String get loginEmail => 'Email';
  @override
  String get loginApple => 'Apple';
  @override
  String get loginGoogle => 'Google';
  @override
  String get photoNote => 'Photo upload is not available yet.';
  @override
  String get saved => 'Saved';
  @override
  String get loadErrorTitle => 'Could not load your profile';
  @override
  String get loadErrorText => 'Check your connection and try again.';
  @override
  Map<String, String> get timeZones => {
    'America/Sao_Paulo': 'São Paulo',
    'America/Argentina/Buenos_Aires': 'Buenos Aires',
    'America/Bogota': 'Bogotá',
    'America/Mexico_City': 'Mexico City',
    'America/New_York': 'New York',
    'America/Los_Angeles': 'Los Angeles',
    'Europe/Lisbon': 'Lisbon',
    'Europe/London': 'London',
    'Europe/Madrid': 'Madrid',
    'Europe/Paris': 'Paris',
    'Europe/Berlin': 'Berlin',
    'Africa/Luanda': 'Luanda',
    'Asia/Tokyo': 'Tokyo',
    'Australia/Sydney': 'Sydney',
    'UTC': 'UTC',
  };
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Could not save right now. Try again.',
  };
}

// Path: profileSetup
class _Translations$profileSetup$en extends Translations$profileSetup$pt {
  _Translations$profileSetup$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'The basics';
  @override
  String get titleHighlight => 'basics';
  @override
  String get subtitle => 'Used for the words in the app and for the first date of your story.';
  @override
  String get nameLabel => 'Your name';
  @override
  String get nameHint => 'Your first name';
  @override
  Map<String, String> get nameErrors => {
    'empty': 'Your name cannot be empty.',
    'tooLong': 'Use at most 30 characters.',
  };
  @override
  String get partnerNameLabel => 'Partner\'s name';
  @override
  String get partnerNameHint => 'Their first name';
  @override
  Map<String, String> get partnerNameErrors => {'tooLong': 'Use at most 30 characters.'};
  @override
  String get dateLabel => 'When did you start?';
  @override
  String get dateHint => 'Pick a date';
  @override
  Map<String, String> get dateErrors => {'empty': 'Pick the date you started.'};
  @override
  String dateFormat({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String get continueButton => 'Continue';
  @override
  Map<String, String> get errors => {
    'INVALID_DATE': 'That date does not look right. Pick one between 1950 and today.',
    'NETWORK': 'No connection. Your answers are still here, try again.',
    'other': 'Could not save right now. Try again.',
  };
  @override
  String get themeLabel => 'Your app colour';
  @override
  String get themeRose => 'Rose';
  @override
  String get themeBlue => 'Blue';
  @override
  String get themeNeutral => 'Neutral';
}

// Path: programs
class _Translations$programs$en extends Translations$programs$pt {
  _Translations$programs$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'PROGRAMS';
  @override
  String get title => 'Programs';
  @override
  String get entryText => 'Short guided programs, at your own pace.';
  @override
  String get hubSubtitle => 'One idea a day. No rush, no pressure.';
  @override
  String get free => 'FREE';
  @override
  String get plus => 'PLUS';
  @override
  String lessonCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 lesson',
        other: '${count} lessons',
      );
  @override
  String get noLessons => 'Lessons coming';
  @override
  String get emptyTitle => 'No programs here yet';
  @override
  String get emptyText => 'New programs are on the way. Come back whenever you like.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'The programs are still here. Try again.';
  @override
  String get diaryLabel => 'JUST ME';
  @override
  String get diaryTitle => 'Diary';
  @override
  String get diaryText => 'A private place to write how you are.';
  @override
  String get start => 'Start';
  @override
  String get kContinue => 'Continue';
  @override
  String get restart => 'Start over';
  @override
  String get restartConfirmTitle => 'Start over?';
  @override
  String get restartConfirmText => 'This clears your lesson marks and returns to the first lesson.';
  @override
  String get restartConfirm => 'Start over';
  @override
  String get completed => 'Completed';
  @override
  String get lessonsTitle => 'Lessons';
  @override
  String get lessonsComingTitle => 'Lessons coming';
  @override
  String get lessonsComingText => 'This program is still being prepared. Come back soon.';
  @override
  String get lessonGoneTitle => 'Lesson not here';
  @override
  String get lessonGoneText => 'This day is no longer part of the program. Choose another lesson.';
  @override
  String get dayOneHint => 'The first lesson is always open in this program.';
  @override
  String dayLabel({required Object day}) => 'Day ${day}';
  @override
  String get shortRead => 'A short idea for today.';
  @override
  String get ready => 'Done';
  @override
  String get saveForLater => 'Save for later';
  @override
  String get saved => 'Saved for later.';
  @override
  String get savedTag => 'Saved';
  @override
  String get lockedTitle => 'Plus lesson';
  @override
  String get lockedLessonText => 'This lesson is part of Plus.';
  @override
  String get lockedProgramText => 'This program is part of Plus.';
  @override
  String get completeTitle => 'Well done';
  @override
  String completeText({required Object title}) => 'You completed ${title}.';
  @override
  String get completeHint => 'Choose another whenever you want.';
  @override
  String get seePrograms => 'See programs';
  @override
  String get diaryPrivacy => 'Just me. Never shared.';
  @override
  String get diaryPrompt => 'Today I felt...';
  @override
  String get diaryHint => 'Write without hurry. Only you can see this.';
  @override
  Map<String, String> get diaryBodyErrors => {
    'empty': 'Write a little before saving',
    'tooLong': 'The entry is too long',
  };
  @override
  String get diarySave => 'Save';
  @override
  String get diaryNew => 'New entry';
  @override
  String get diaryEdit => 'Edit';
  @override
  String get diaryDelete => 'Delete';
  @override
  String get diaryDeleteTitle => 'Delete this entry?';
  @override
  String get diaryDeleteText => 'This can\'t be undone.';
  @override
  String get diaryDeleteConfirm => 'Delete';
  @override
  String get diaryCapHint => 'Showing your last 100 entries.';
  @override
  String get diaryEmptyTitle => 'Nothing written yet';
  @override
  String get diaryEmptyText => 'When you want, write how you are. Only you can see it.';
  @override
  String get diaryErrorTitle => 'Couldn\'t load';
  @override
  String get diaryErrorText => 'Your entries are still saved. Try again.';
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String dateLine({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  Map<String, String> get moods => {
    'calm': 'At peace',
    'tender': 'Held',
    'tired': 'Tired',
    'heavy': 'Heavy',
    'other': 'How I am',
  };
  @override
  Map<String, String> get lessonErrors => {'other': 'Couldn\'t do that right now. Try again.'};
  @override
  Map<String, String> get diaryErrors => {
    'other': 'Couldn\'t save right now. Your text is still here.',
  };
  @override
  String get freeNote => 'Free shows only the first lesson.';
}

// Path: pronouns
class _Translations$pronouns$en extends Translations$pronouns$pt {
  _Translations$pronouns$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  Map<String, String> get options => {
    'she': 'She',
    'he': 'He',
    'nameOnly': 'Name only',
    'other': 'Name only',
  };
}

// Path: questions
class _Translations$questions$en extends Translations$questions$pt {
  _Translations$questions$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get tag => 'Couple question';
  @override
  String get answerCta => 'Answer';
  @override
  String get introNote => 'One question a day or a week.';
  @override
  String get answerHint => 'Write as much as you like.';
  @override
  Map<String, String> get answerErrors => {
    'empty': 'Write an answer',
    'tooLong': 'The answer is too long',
  };
  @override
  String get partnerAnsweredNote => 'Your partner already answered. Send yours to see both.';
  @override
  String partnerSeesAfter({required Object name}) =>
      'Only after you send yours and ${name} answers too.';
  @override
  String get partnerSeesAfterFallback => 'Only after you send yours and your partner answers too.';
  @override
  String get soloNote => 'Your answer stays private. Your partner sees it after you connect.';
  @override
  String get save => 'Send';
  @override
  String get cancel => 'Cancel';
  @override
  String get skip => 'Skip';
  @override
  String get waitingTitle => 'Your answer is saved';
  @override
  String get waitingText => 'It appears here when your partner answers too.';
  @override
  String get waitingSoloText => 'When your partner joins, they see your answer and you see theirs.';
  @override
  String get checkAgain => 'Check again';
  @override
  String get revealTitle => 'The two memories';
  @override
  String get revealHighlight => 'memories';
  @override
  String get keepPrompt => 'Do you want to keep this in your story?';
  @override
  String get saveMilestone => 'Save as milestone';
  @override
  String get notNow => 'Not now';
  @override
  String get you => 'You';
  @override
  String get partnerFallback => 'Your partner';
  @override
  String get discardTitle => 'Discard this answer?';
  @override
  String get discardText => 'The text you wrote was not saved.';
  @override
  String get discard => 'Discard';
  @override
  String get keepWriting => 'Keep writing';
  @override
  String get loadErrorTitle => 'Could not open the question';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
  @override
  String get close => 'Close';
  @override
  Map<String, String> get errors => {'other': 'Could not save right now. Try again.'};
  @override
  String get editCta => 'Edit my answer';
}

// Path: questionsEntry
class _Translations$questionsEntry$en extends Translations$questionsEntry$pt {
  _Translations$questionsEntry$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'QUESTION OF THE DAY';
  @override
  String get title => 'Question of the day';
  @override
  String get text => 'One question for both of you to answer.';
}

// Path: quickSlip
class _Translations$quickSlip$en extends Translations$quickSlip$pt {
  _Translations$quickSlip$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String dateLine({required Object weekday, required Object month, required Object day}) =>
      '${weekday}, ${month} ${day}';
  @override
  List<String> get weekdays => [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String get title => 'What made you happy?';
  @override
  String get titleHighlight => 'happy';
  @override
  String get subtitle => 'One line is enough. 30 seconds.';
  @override
  String get polarityLabel => 'Liked or bothered me';
  @override
  String get polarityLiked => 'Liked';
  @override
  String get polarityBothered => 'Bothered me';
  @override
  String get hint => 'E.g. made coffee before I woke up';
  @override
  Map<String, String> get textErrors => {
    'empty': 'Write the slip first',
    'tooLong': 'This slip is too long',
  };
  @override
  Map<String, String> get categories => {
    'said': 'Said something',
    'did': 'Did something',
    'noticed': 'Noticed me',
    'helped': 'Helped me',
    'other': '',
  };
  @override
  String get privacyNote => 'It stays private. On Sunday you choose what goes on the card.';
  @override
  String get cardNote => 'It goes on your weekly card. You can take it out anytime.';
  @override
  String get save => 'Save';
  @override
  String get discardTitle => 'Discard this slip?';
  @override
  late final _Translations$quickSlip$saved$en saved = _Translations$quickSlip$saved$en._(_root);
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'Could not save right now. Your text is still here, try again.',
  };
  @override
  String get annoyanceTitle => 'What bothered you?';
  @override
  String get annoyanceTitleHighlight => 'bothered';
  @override
  String get annoyanceSubtitle => 'One line is enough. Only you see it.';
  @override
  String get annoyanceHint => 'E.g. I was left with the dishes again';
  @override
  String get annoyanceNote =>
      'It stays with you and goes away on its own in 14 days. It never goes on the card. It only continues if you turn it into a gentle request.';
  @override
  String get gentleRequest => 'Gentle request';
  @override
  String get keep => 'Keep';
  @override
  String get addDetails => 'Add details';
}

// Path: quizzes
class _Translations$quizzes$en extends Translations$quizzes$pt {
  _Translations$quizzes$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Quizzes';
  @override
  String get headline => 'Getting to know';
  @override
  String get headlineHighlight => 'each other';
  @override
  String get intro =>
      'Two short quizzes, six questions each. You see the result first and decide whether to show it.';
  @override
  String get entryTitle => 'Quizzes';
  @override
  String get entryText => 'Get to know each other';
  @override
  String get lovedTitle => 'How I feel loved';
  @override
  String get fightTitle => 'How I react in a fight';
  @override
  String questionCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 question',
        other: '${count} questions',
      );
  @override
  String minutes({required Object minutes}) => '${minutes} min';
  @override
  String meta({required Object questions, required Object minutes}) => '${questions} · ${minutes}';
  @override
  String get start => 'Start';
  @override
  String lastDone({required Object date}) => 'Done on ${date}';
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String get note => 'Only you see the result, until you tap Show. It is not a psychological test.';
  @override
  String get loadErrorTitle => 'Could not open the quizzes';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
}

// Path: received
class _Translations$received$en extends Translations$received$pt {
  _Translations$received$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  Map<String, String> get kinds => {
    'repair': 'Repair card',
    'need': 'I need…',
    'missUs': 'Missing you',
    'hug': 'A hug',
    'distance': 'A little distance',
    'goodNews': 'Good news',
    'other': '',
  };
  @override
  Map<String, String> get bodies => {
    'missUs': 'Your partner is missing you both.',
    'hug': 'Your partner would like a hug.',
    'distance': 'Your partner needs a little distance.',
    'goodNews': 'Your partner has good news.',
    'other': '',
  };
  @override
  String get fromPartner => 'From your partner';
  @override
  String get privateFirst => 'Your answer is private first. There is no right or wrong.';
  @override
  Map<String, String> get responses => {
    'here': 'I\'m here',
    'talk': 'Let\'s talk',
    'moreTime': 'I need a bit more time',
    'willDo': 'I\'ll do it',
    'notNow': 'Not now',
    'plan': 'Plan something',
    'later': 'I\'ll answer later',
    'heart': 'Send a heart',
    'other': '',
  };
  @override
  String get seen => 'Got it';
  @override
  String answered({required Object response}) => 'You answered: ${response}';
  @override
  String get next => 'Next message';
  @override
  String get doneTitle => 'All good';
  @override
  String get doneText => 'Thanks for reading it calmly.';
  @override
  String get emptyTitle => 'Nothing new';
  @override
  String get emptyText => 'When your partner sends something, it shows up here.';
  @override
  String get close => 'Close';
  @override
  String get errorTitle => 'Couldn\'t open this';
  @override
  String get errorText => 'Nothing was lost. Try again.';
  @override
  Map<String, String> get errors => {
    'NOT_FOUND': 'That message isn\'t here anymore.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t answer right now. Try again.',
  };
}

// Path: relationshipChanged
class _Translations$relationshipChanged$en extends Translations$relationshipChanged$pt {
  _Translations$relationshipChanged$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Something changed?';
  @override
  String get highlight => 'changed';
  @override
  String get subtitle => 'Take your time. This only changes what the app shows.';
  @override
  String get optionEnded => 'We broke up';
  @override
  String get optionBereaved => 'I lost them';
  @override
  String get optionTogether => 'Everything is fine';
  @override
  String get continueLabel => 'Continue';
  @override
  String get saved => 'Saved';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Could not save right now. Try again.',
  };
}

// Path: relationshipSettings
class _Translations$relationshipSettings$en extends Translations$relationshipSettings$pt {
  _Translations$relationshipSettings$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Relationship';
  @override
  String get phaseLabel => 'Phase';
  @override
  String get phasePlaceholder => 'Pick a phase';
  @override
  Map<String, String> get phases => {
    'beginning': 'Just starting',
    'dating': 'Dating',
    'livingTogether': 'Living together',
    'engaged': 'Engaged',
    'married': 'Married',
    'longDistance': 'Long distance',
    'restarting': 'Starting over',
  };
  @override
  String get dateLabel => 'Together since';
  @override
  String get dateHint => 'Pick a date';
  @override
  String dateFormat({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String get futureDateNote => 'A future date is fine; the countdown just starts later.';
  @override
  String get partnerLabel => 'Partner';
  @override
  String get invitePartner => 'Invite your partner';
  @override
  String get partnerError => 'Could not load your partner.';
  @override
  String get partnerRetry => 'Try again';
  @override
  String get phaseNote => 'The phase only changes the words.';
  @override
  String get saved => 'Saved';
  @override
  String get loadErrorTitle => 'Could not load the relationship';
  @override
  String get loadErrorText => 'Check your connection and try again.';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Could not save right now. Try again.',
  };
  @override
  String get changedPrompt => 'Something changed between you two?';
  @override
  String get changedSubtitle => 'Update what the app shows';
}

// Path: reminders
class _Translations$reminders$en extends Translations$reminders$pt {
  _Translations$reminders$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Mingo';
  @override
  String get dailyIdea => 'A small idea for today.';
  @override
  String get dates => 'A date is coming up.';
  @override
  String get weeklyCard => 'Your card is ready.';
  @override
  String get generic => 'Open the app to see.';
}

// Path: repair
class _Translations$repair$en extends Translations$repair$pt {
  _Translations$repair$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$repair$calm$en calm = _Translations$repair$calm$en._(_root);
  @override
  late final _Translations$repair$softStart$en softStart = _Translations$repair$softStart$en._(
    _root,
  );
  @override
  late final _Translations$repair$quick$en quick = _Translations$repair$quick$en._(_root);
  @override
  late final _Translations$repair$guided$en guided = _Translations$repair$guided$en._(_root);
  @override
  late final _Translations$repair$learning$en learning = _Translations$repair$learning$en._(_root);
  @override
  late final _Translations$repair$next$en next = _Translations$repair$next$en._(_root);
  @override
  late final _Translations$repair$sos$en sos = _Translations$repair$sos$en._(_root);
}

// Path: rituals
class _Translations$rituals$en extends Translations$rituals$pt {
  _Translations$rituals$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Rituals';
  @override
  String get subtitle => 'Small habits you want to protect. No streaks, no pressure.';
  @override
  String get emptyTitle => 'No rituals yet';
  @override
  String get emptyText => 'A Friday dinner, a Sunday walk. What do you want to protect?';
  @override
  String get create => 'Create a ritual';
  @override
  String get didIt => 'We did it';
  @override
  String get warm => 'That\'s lovely. A moment for the two of you.';
  @override
  Map<String, String> get cadences => {
    'daily': 'Every day',
    'weekly': 'Every week',
    'biweekly': 'Every two weeks',
    'monthly': 'Every month',
    'other': '',
  };
  @override
  String cadenceOn({required Object cadence, required Object weekday}) => '${cadence}, ${weekday}';
  @override
  List<String> get weekdays => [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  @override
  String get createTitle => 'New ritual';
  @override
  String get editTitle => 'Your ritual';
  @override
  String get nameLabel => 'Name';
  @override
  String get nameHint => 'E.g. Friday dinner';
  @override
  String get cadenceLabel => 'How often';
  @override
  String get weekdayLabel => 'On which day';
  @override
  String get hourLabel => 'What time';
  @override
  String hourFormat({required Object hour}) => '${hour}:00';
  @override
  String get reminderTitle => 'Reminder';
  @override
  String get reminderText => 'A short notice on this phone, with no details.';
  @override
  String get save => 'Save';
  @override
  String get archive => 'Archive';
  @override
  String get archiveTitle => 'Archive this ritual?';
  @override
  String get archiveText => 'It leaves the list. The history stays saved.';
  @override
  String get errorTitle => 'Couldn\'t open this';
  @override
  String get errorText => 'Nothing was lost. Try again.';
  @override
  Map<String, String> get errors => {
    'NOT_FOUND': 'That ritual isn\'t here anymore.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
    'INVALID_PLANNER': 'The planner has to be one of the two people.',
  };
  @override
  String get plannerLabel => 'Who plans it';
  @override
  String get plannerNobody => 'Nobody in particular';
  @override
  String get plannerMe => 'Me';
  @override
  String get plannerPartner => 'The other person';
}

// Path: sessionExpired
class _Translations$sessionExpired$en extends Translations$sessionExpired$pt {
  _Translations$sessionExpired$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Your session ended';
  @override
  String get highlight => 'ended';
  @override
  String get text => 'Sign in again to continue. Your data is safe.';
  @override
  String get action => 'Sign in';
}

// Path: settingsHome
class _Translations$settingsHome$en extends Translations$settingsHome$pt {
  _Translations$settingsHome$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Settings';
  @override
  String get profile => 'Profile';
  @override
  String get relationship => 'Relationship';
  @override
  String get connected => 'You are connected';
  @override
  String get invitePartner => 'Invite your partner';
  @override
  String get notifications => 'Notifications';
  @override
  String get devices => 'Devices';
  @override
  String get on => 'On in the app';
  @override
  String get off => 'Off in the app';
  @override
  String get plan => 'Plan';
  @override
  String get planFree => 'Free';
  @override
  String get planPlus => 'Plus';
  @override
  String get spice => 'Tempero';
  @override
  String get privacy => 'Privacy and security';
  @override
  String get privacyStatus => 'Who sees what';
  @override
  String get signOut => 'Sign out';
  @override
  String get deleteAccount => 'Delete account';
  @override
  String pendingBanner({required Object date}) => 'Your account will be deleted on ${date}.';
  @override
  String get pendingAction => 'See';
  @override
  String get pendingBannerSimple => 'Your account will be deleted soon.';
  @override
  String get help => 'Help and support';
  @override
  String get helpStatus => 'FAQ and contact';
  @override
  String get appPreferences => 'App preferences';
  @override
  String get appPreferencesStatus => 'Appearance, text and language';
  @override
  String get theme => 'App colour';
  @override
  String get themeTitle => 'Which colour suits you?';
  @override
  String get themeHighlight => 'colour';
  @override
  String get themeSubtitle => 'Applies to the app and to the widgets. The features are the same.';
  @override
  String get weeklyCard => 'Weekly card';
  @override
  String get language => 'Language';
  @override
  String get accountSection => 'Account';
  @override
  String get preferencesSection => 'Preferences';
  @override
  String get privacySection => 'Privacy and help';
  @override
  String connectedWith({required Object name}) => 'Connected with ${name}';
}

// Path: share
class _Translations$share$en extends Translations$share$pt {
  _Translations$share$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get entryTitle => 'Share image';
  @override
  String get entrySubtitleToday => 'Your time together and the moon from the day it began.';
  @override
  String get entrySubtitleMemories => 'A timeline of the moments you kept.';
  @override
  String get entrySubtitleCard => 'A line from the card that reached you.';
  @override
  String get sheetTitle => 'Share image';
  @override
  String get sheetSubtitle => 'The image is made on your device and only leaves when you share it.';
  @override
  String get shareAction => 'Share';
  @override
  Map<String, String> get cardLabels => {
    'counter': 'Our time',
    'moon': 'The moon of our day',
    'timeline': 'Our timeline',
    'quote': 'From a card',
    'other': '',
  };
  @override
  String get counterEyebrow => 'OUR TIME';
  @override
  String counterDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'day together',
        other: 'days together',
      );
  @override
  String counterSince({required Object date}) => 'Since ${date}';
  @override
  String get moonEyebrow => 'THE MOON OF OUR DAY';
  @override
  String get moonSupport => 'This is how the sky looked when it all began.';
  @override
  String get timelineEyebrow => 'OUR TIMELINE';
  @override
  String get timelineTitle => 'Moments we kept';
  @override
  String get quoteEyebrow => 'FROM A CARD';
  @override
  String quoteText({required Object quote}) => '“${quote}”';
  @override
  String quoteFromName({required Object name}) => '— ${name}';
  @override
  String quoteDate({required Object date}) => 'Card from ${date}';
  @override
  String dateLine({required Object month, required Object day, required Object year}) =>
      '${month} ${day}, ${year}';
  @override
  String dateShort({required Object month, required Object day}) => '${month} ${day}';
  @override
  List<String> get monthsLong => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  Map<String, String> get phases => {
    'newMoon': 'New moon',
    'waxingCrescent': 'Waxing crescent',
    'firstQuarter': 'First quarter',
    'waxingGibbous': 'Waxing gibbous',
    'fullMoon': 'Full moon',
    'waningGibbous': 'Waning gibbous',
    'lastQuarter': 'Last quarter',
    'waningCrescent': 'Waning crescent',
    'other': '',
  };
  @override
  String get productMark => 'Mingo';
  @override
  Map<String, String> get errors => {'other': 'Couldn\'t share right now. Try again.'};
}

// Path: slipDetail
class _Translations$slipDetail$en extends Translations$slipDetail$pt {
  _Translations$slipDetail$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String dateLine({required Object weekday, required Object month, required Object day}) =>
      '${weekday}, ${month} ${day}';
  @override
  List<String> get weekdays => [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  Map<String, String> get kinds => {
    'quick': 'Quick',
    'specific': 'Specific',
    'ifThen': 'If… then',
    'invisible': 'Invisible',
    'other': '',
  };
  @override
  String get feeling => 'How you felt';
  @override
  String get plan => 'Then I…';
  @override
  String get jarTitle => 'Keep in the jar';
  @override
  String get jarText => 'To open on a bad day. Only you see it.';
  @override
  String get sentNote =>
      'This slip already went in a card. The sent card keeps the earlier copy, even if you edit or delete it here.';
  @override
  Map<String, String> get draftBodyErrors => {
    'empty': 'Write the slip first',
    'tooLong': 'This slip is too long',
  };
  @override
  String get edit => 'Edit';
  @override
  String get editSave => 'Save';
  @override
  String get editCancel => 'Cancel';
  @override
  String get delete => 'Delete';
  @override
  String get deleteTitle => 'Delete this slip?';
  @override
  String get deleteText => 'It will be removed from your week and your timeline.';
  @override
  String get deleteConfirm => 'Delete';
  @override
  String get saved => 'Saved';
  @override
  String get deleted => 'Slip deleted';
  @override
  String get notFoundTitle => 'This slip no longer exists';
  @override
  String get notFoundText => 'It may have been deleted.';
  @override
  Map<String, String> get errors => {
    'SLIP_NOT_FOUND': 'This slip no longer exists.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t do that right now. Try again.',
  };
  @override
  String get discardTitle => 'Discard this slip?';
  @override
  List<String> get weekdaysShort => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  @override
  String factDate({required Object weekday, required Object month, required Object day}) =>
      '${weekday} ${month} ${day}';
  @override
  String get factDateLabel => 'Date';
  @override
  String get factType => 'Type';
  @override
  String get factVisibility => 'Visibility';
  @override
  String get factInCard => 'Included in a card';
  @override
  String get visibilityPrivate => 'Private';
  @override
  String get visibilityCard => 'In the weekly card';
  @override
  String get visibilitySent => 'Sent';
  @override
  String get yes => 'Yes';
  @override
  String get no => 'No';
  @override
  Map<String, String> get categories => {
    'said': 'Said something',
    'did': 'Did something',
    'noticed': 'Noticed me',
    'helped': 'Helped me',
    'other': '',
  };
  @override
  late final _Translations$slipDetail$visibility$en visibility =
      _Translations$slipDetail$visibility$en._(_root);
}

// Path: slipKind
class _Translations$slipKind$en extends Translations$slipKind$pt {
  _Translations$slipKind$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get switcherTitle => 'Other ways to write it down';
  @override
  String get quickEntry => 'Quick';
  @override
  String get needEntry => 'I need…';
  @override
  Map<String, String> get kinds => {
    'specific': 'Specific',
    'ifThen': 'If… then',
    'invisible': 'Invisible',
    'other': '',
  };
  @override
  late final _Translations$slipKind$specific$en specific = _Translations$slipKind$specific$en._(
    _root,
  );
  @override
  late final _Translations$slipKind$ifThen$en ifThen = _Translations$slipKind$ifThen$en._(_root);
  @override
  late final _Translations$slipKind$invisible$en invisible = _Translations$slipKind$invisible$en._(
    _root,
  );
  @override
  Map<String, String> get workAreas => {
    'planning': 'Planning',
    'dates': 'Remembering dates',
    'kitchen': 'Kitchen',
    'cleaning': 'Cleaning',
    'kids': 'Kids\' logistics',
    'emotional': 'Emotional support',
    'finances': 'Household finances',
    'other': 'Other',
  };
  @override
  Map<String, String> get textErrors => {
    'empty': 'Write the slip first',
    'tooLong': 'This slip is too long',
  };
  @override
  Map<String, String> get feelingErrors => {'tooLong': 'This is too long'};
  @override
  Map<String, String> get planErrors => {
    'empty': 'Say what you will do',
    'tooLong': 'This is too long',
  };
  @override
  String get save => 'Save';
  @override
  String get discardTitle => 'Discard this slip?';
  @override
  late final _Translations$slipKind$saved$en saved = _Translations$slipKind$saved$en._(_root);
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your text is still here, try again.',
  };
}

// Path: slipsList
class _Translations$slipsList$en extends Translations$slipsList$pt {
  _Translations$slipsList$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Slips';
  @override
  String get scopeWeek => 'This week';
  @override
  String get scopeAll => 'All';
  @override
  String get search => 'Search';
  @override
  String get searchHint => 'Search your slips';
  @override
  String get searchEmptyTitle => 'Nothing found';
  @override
  String get searchEmptyText => 'Try another word.';
  @override
  String get thisWeek => 'This week';
  @override
  String get lastWeek => 'Last week';
  @override
  String weekRange({required Object start, required Object end}) => '${start} – ${end}';
  @override
  String dateShort({required Object month, required Object day}) => '${month} ${day}';
  @override
  String dayLine({required Object weekday, required Object category}) => '${weekday} · ${category}';
  @override
  List<String> get weekdaysShort => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  @override
  List<String> get monthsShort => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  Map<String, String> get categories => {
    'said': 'Said something',
    'did': 'Did something',
    'noticed': 'Noticed me',
    'helped': 'Helped',
    'other': '',
  };
  @override
  Map<String, String> get kinds => {
    'quick': 'Quick',
    'specific': 'Specific',
    'ifThen': 'If… then',
    'invisible': 'Invisible',
    'other': '',
  };
  @override
  String get emptyTitle => 'Nothing yet';
  @override
  String get emptyText => 'A slip is one good thing, in one line.';
  @override
  String get emptyAction => 'Add a slip';
  @override
  String get privateEmptyTitle => 'Nothing private here';
  @override
  String get privateEmptyText => 'Slips you keep off the card show up here.';
  @override
  String get privateMarker => 'Private slip';
  @override
  String get scopePrivate => 'Private';
  @override
  String get freeNote => 'Slips are always free.';
  @override
  String get filterThisMonth => 'This month';
  @override
  String get filterInCard => 'In a card';
  @override
  String get filterInvisible => 'Invisible work';
  @override
  String get searchFiltersEmptyText => 'Adjust the search or the filters.';
}

// Path: spice
class _Translations$spice$en extends Translations$spice$pt {
  _Translations$spice$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Tempero';
  @override
  String get introTitle => 'Tempero, just for the two of you';
  @override
  String get introHighlight => 'the two of you';
  @override
  String get introText =>
      'An optional space for adults, with cards and desires for the couple. 18+ only.';
  @override
  String get partnerWantsText =>
      'The other person wanted to turn it on. It only starts when you turn it on too.';
  @override
  List<String> get promises => [
    'It only counts when you both turn it on.',
    'Either of you can turn it off any time, and everything disappears for both.',
    'Your answers are only yours. Only what you both want shows.',
    'A "not today" is never explained or announced.',
  ];
  @override
  String get adultLabel => 'I am 18 or older';
  @override
  String get adultError => 'Confirm to continue.';
  @override
  String get turnOn => 'Turn on';
  @override
  String get notNow => 'Not now';
  @override
  String get turnOff => 'Turn off';
  @override
  String get waitingTitle => 'Waiting for the other person';
  @override
  String get waitingText =>
      'Nothing was announced. When they turn it on too, Tempero opens for both of you.';
  @override
  String get soloTitle => 'Tempero is for two';
  @override
  String get soloText =>
      'It needs two connected people. When the other person joins, it becomes available.';
  @override
  String get soloAction => 'Back';
  @override
  late final _Translations$spice$home$en home = _Translations$spice$home$en._(_root);
  @override
  late final _Translations$spice$cards$en cards = _Translations$spice$cards$en._(_root);
  @override
  late final _Translations$spice$desires$en desires = _Translations$spice$desires$en._(_root);
  @override
  late final _Translations$spice$challenge$en challenge = _Translations$spice$challenge$en._(_root);
  @override
  late final _Translations$spice$settingsPage$en settingsPage =
      _Translations$spice$settingsPage$en._(_root);
  @override
  Map<String, String> get errors => {
    'FREE_LIMIT_REACHED': 'You used this week\'s free cards. Plus unlocks more.',
    'PLUS_REQUIRED': 'This is part of Plus.',
    'ADULT_REQUIRED': 'Confirm you are 18 or older.',
    'SPICE_NOT_ON': 'Tempero is not on for both of you.',
    'SWAP_LIMIT': 'You already swapped the challenge three times this week.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not finish that now. Try again.',
  };
}

// Path: story
class _Translations$story$en extends Translations$story$pt {
  _Translations$story$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Image to share';
  @override
  String get privacyNote =>
      'The image is made on your device and carries no names or text unless you choose.';
  @override
  String get days => 'days';
  @override
  String get together => 'together';
  @override
  String get namesLabel => 'Include the names';
  @override
  String get namesText => 'Off by default.';
  @override
  String get phraseLabel => 'A line (optional)';
  @override
  String get phraseHint => 'E.g. so much still ahead';
  @override
  String get share => 'Share image';
  @override
  String get emptyTitle => 'Your date is missing';
  @override
  String get emptyText => 'Set since when you are together in Our history to create the image.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Try again in a moment.';
  @override
  Map<String, String> get errors => {'other': 'Couldn\'t share right now. Try again.'};
}

// Path: sundayCard
class _Translations$sundayCard$en extends Translations$sundayCard$pt {
  _Translations$sundayCard$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Your card';
  @override
  String get edit => 'Edit';
  @override
  String get save => 'Save';
  @override
  String get cancel => 'Cancel';
  @override
  String get noteLabel => 'Closing note';
  @override
  String get noteHint => 'Thank you for this week.';
  @override
  String get emptyTitle => 'A week without slips';
  @override
  String get emptyText => 'Note one good thing and it goes on the Sunday card.';
  @override
  String get emptyAction => 'Note a slip';
  @override
  String get errorTitle => 'Could not load the card';
  @override
  String get errorText => 'Your slips are still saved. Try again.';
  @override
  String get saveError => 'Could not save the card. Try again.';
  @override
  String get openFromToday => 'See the draft';
  @override
  String get deliverError => 'Could not send right now. The card is still here, try again.';
  @override
  late final _Translations$sundayCard$send$en send = _Translations$sundayCard$send$en._(_root);
  @override
  late final _Translations$sundayCard$hold$en hold = _Translations$sundayCard$hold$en._(_root);
  @override
  late final _Translations$sundayCard$held$en held = _Translations$sundayCard$held$en._(_root);
  @override
  late final _Translations$sundayCard$sent$en sent = _Translations$sundayCard$sent$en._(_root);
  @override
  late final _Translations$sundayCard$heldByRule$en heldByRule =
      _Translations$sundayCard$heldByRule$en._(_root);
  @override
  String get dayTitle => 'Day';
  @override
  String get dayError => 'Could not change the day. The earlier one was kept.';
  @override
  String get dayNote => 'Applies to the next card.';
  @override
  String get editTitle => 'Edit this week';
  @override
  String get editSubtitle => 'Choose what goes in';
  @override
  String get included => 'Included';
  @override
  String get notIncluded => 'Not included';
  @override
  String get preview => 'Preview';
}

// Path: tabs
class _Translations$tabs$en extends Translations$tabs$pt {
  _Translations$tabs$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get today => 'Today';
  @override
  String get slips => 'Slips';
  @override
  String get together => 'Together';
  @override
  String get memories => 'Memories';
  @override
  String get capture => 'New slip';
  @override
  String get soonTitle => 'Under construction';
  @override
  String get soonText => 'This part of the app is still being prepared.';
  @override
  String get segmentTogether => 'Us';
  @override
  String get forMeFooter => 'Private tools. Never shared.';
  @override
  String get segmentForMe => 'For me';
  @override
  String get checkinLabel => 'CHECK-IN';
  @override
  String get checkinTitle => 'Weekly check-in';
  @override
  String get checkinText => 'A short conversation, private first.';
  @override
  String get logisticsLabel => 'PRACTICAL';
  @override
  String get logisticsTitle => 'Logistics meeting';
  @override
  String get logisticsText => 'The practical things, with nobody carrying them alone.';
  @override
  String get listsLabel => 'LISTS';
  @override
  String get listsTitle => 'Lists';
  @override
  String get listsEmpty => 'No lists yet. Start one together.';
  @override
  String get listsEmptyPrivate => 'No lists yet. Start one of your own.';
  @override
  String listsSharedCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 list, shared',
        other: '${count} lists, shared',
      );
  @override
  String listsPrivateCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 list, private',
        other: '${count} lists, private',
      );
  @override
  String get soloNote => 'When your partner joins, shared things show up here.';
  @override
  String get ritualsLabel => 'ROUTINE';
  @override
  String get ritualsTitle => 'Rituals';
  @override
  String get ritualsText => 'Small habits you want to protect.';
  @override
  String get dateNightLabel => 'DATE';
  @override
  String get dateNightTitle => 'Date night';
  @override
  String get dateNightText => 'Ideas for the two of you, picked together.';
  @override
  String get partnerLabel => 'JUST FOR YOU';
  @override
  String get partnerTitle => 'About your partner';
  @override
  String get partnerText => 'Private notes to remember what they like.';
  @override
  String get chatLabel => 'TALK';
  @override
  String get chatTitle => 'Mascot';
  @override
  String get chatText => 'A calm conversation that is not kept.';
  @override
  String get hardTalkLabel => 'HARD CONVERSATION';
  @override
  String get hardTalkTitle => 'Prepare a hard conversation';
  @override
  String get hardTalkText => 'The mascot helps you sort out what to say.';
  @override
  String get notesLabel => 'FOR YOUR PARTNER';
  @override
  String get notesTitle => 'A note or a drawing';
  @override
  String get notesText => 'Send something short and kind, whenever you like.';
  @override
  String get usLabel => 'US';
  @override
  String get usTitle => 'I miss us';
  @override
  String get usText => 'A light tap for your partner, no pressure.';
  @override
  String get touchLabel => 'TOUCH';
  @override
  String get touchTitle => 'Touch cards';
  @override
  String get touchText => 'Neutral, to do or skip.';
  @override
  String get distanceLabel => 'DISTANCE';
  @override
  String get distanceTitle => 'Our two clocks';
  @override
  String get distanceText => 'Time zones and the countdown to seeing each other.';
  @override
  String get parentsLabel => 'WITH PARENTS';
  @override
  String get parentsText => 'A short moment just for the two of you, even in a full house.';
  @override
  String get capsulesLabel => 'TIME CAPSULE';
  @override
  String get capsulesTitle => 'A message to the future';
  @override
  String get capsulesText => 'Stays closed until the day you choose.';
  @override
  String get datesLabel => 'DATES';
  @override
  String get datesTitle => 'Important dates';
  @override
  String get datesText => 'Birthdays, gifts and holidays, with a heads-up.';
  @override
  String get badDayLabel => 'HELP';
  @override
  String get badDayTitle => 'A hard day';
  @override
  String get badDayText => 'Three small things to do right now.';
  @override
  String get starterLabel => 'TALK';
  @override
  String get starterTitle => 'Start a conversation';
  @override
  String get starterText => 'A question to open with, no rush.';
  @override
  String get dayLabel => 'DAY';
  @override
  String get dayTitle => 'Day by day';
  @override
  String get dayText => 'What matters on each day.';
  @override
  String get plusLabel => 'PLAN';
  @override
  String get plusTitle => 'Free and Plus';
  @override
  String get plusText => 'What each plan includes, no pressure.';
  @override
  String get temperatureLabel => 'BETWEEN YOU';
  @override
  String get temperatureTitle => 'How is it between you?';
  @override
  String get temperatureText => 'A private check-in, never a score.';
  @override
  String get learningLabel => 'JUST FOR YOU';
  @override
  String get learningTitle => 'What you learned';
  @override
  String get learningText => 'Private notes you can delete.';
  @override
  String get fightStyleLabel => 'JUST FOR YOU';
  @override
  String get guidesLabel => 'CONVERSATIONS';
  @override
  String get guidesTitle => 'Difficult conversations';
  @override
  String get guidesText => 'One step at a time, just for you.';
  @override
  String get gamesLabel => 'GAMES';
  @override
  String get gamesTitle => 'Play together';
  @override
  String get gamesText => 'Short games, no scores and no winner.';
  @override
  String get gamesLock => 'Needs both of you';
  @override
  String get sectionForYou => 'For you two';
  @override
  String get sectionTools => 'Tools';
  @override
  String get sectionMore => 'More';
  @override
  String get sectionPrivate => 'Only yours';
  @override
  String get logisticsMeta => '15 min · weekly';
  @override
  String get ritualsMeta => 'Small habits';
  @override
  String get dateNightMeta => 'For you two';
  @override
  String get programsMeta => 'Micro-lessons';
  @override
  String get checkinMeta => 'Once a week';
  @override
  String get questionMeta => 'One for both';
  @override
  String get gamesMeta => 'No score';
  @override
  String get datesMeta => 'With a heads-up';
  @override
  String get giftsMeta => 'Only for you';
  @override
  String giftsMetaShared({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 shared wish',
        other: '${count} shared wishes',
      );
  @override
  String get guidesMeta => 'One step at a time';
  @override
  String get starterMeta => 'One question';
  @override
  String get dayMeta => 'One day at a time';
  @override
  String get capsulesMeta => 'For the future';
  @override
  String get temperatureMeta => 'Private, no score';
  @override
  String get widgetsMeta => 'On the home screen';
  @override
  String get usMeta => 'One touch';
  @override
  String get touchMeta => 'Neutral cards';
  @override
  String get badDayMeta => 'Three small things';
  @override
  String get distanceMeta => 'Time zones and reunion';
  @override
  String get diaryMeta => 'Only yours';
  @override
  String get moodCalendarTitle => 'My moods';
  @override
  String get moodCalendarMeta => 'Your month, only you';
  @override
  String get hardTalkMeta => 'Notes before you talk';
  @override
  String get notesMeta => 'When you want';
  @override
  String get learningMeta => 'Private notes';
  @override
  String get partnerMeta => 'Only for you';
  @override
  String get chatMeta => 'A calm conversation';
  @override
  String get listsNone => 'None yet';
  @override
  String get needsBoth => 'Needs both of you · Invite';
  @override
  String durationYearsMonths({
    required Object years,
    required Object yearsUnit,
    required Object months,
    required Object monthsUnit,
  }) => '${years} ${yearsUnit} and ${months} ${monthsUnit}';
  @override
  String durationYears({required Object years, required Object yearsUnit}) =>
      '${years} ${yearsUnit}';
  @override
  String durationMonths({required Object months, required Object monthsUnit}) =>
      '${months} ${monthsUnit}';
  @override
  String durationDays({required Object days, required Object daysUnit}) => '${days} ${daysUnit}';
  @override
  String unitYear({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'year',
        other: 'years',
      );
  @override
  String unitMonth({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'month',
        other: 'months',
      );
  @override
  String unitDay({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'day',
        other: 'days',
      );
  @override
  String get chat => 'Chat';
  @override
  String get couple => 'Us';
  @override
  String get storyChip => 'Our story';
}

// Path: temperature
class _Translations$temperature$en extends Translations$temperature$pt {
  _Translations$temperature$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get levelTitle => 'How is it between you?';
  @override
  String get levelHighlight => 'between you';
  @override
  String get levelNote => 'Private. Never becomes a score.';
  @override
  Map<String, String> get levels => {
    'good': 'Good',
    'soSo': 'So-so',
    'turbulent': 'Turbulent',
    'fight': 'An argument',
    'other': '',
  };
  @override
  String get continueAction => 'Continue';
  @override
  String get back => 'Back';
  @override
  String get skip => 'Not now';
  @override
  String get intensityTitle => 'How strong is it?';
  @override
  String get intensityHighlight => 'strong';
  @override
  String get intensityHint => 'Under 7 you can talk. Over 7, take a pause first.';
  @override
  String get intensityHigh => 'High value: how about a pause first?';
  @override
  String get intensityLow => 'Mild';
  @override
  String get intensityTop => 'Very strong';
  @override
  String get intensityLabel => 'Intensity';
  @override
  late final _Translations$temperature$result$en result = _Translations$temperature$result$en._(
    _root,
  );
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your answers are still here.',
  };
  @override
  late final _Translations$temperature$history$en history = _Translations$temperature$history$en._(
    _root,
  );
}

// Path: timeInApp
class _Translations$timeInApp$en extends Translations$timeInApp$pt {
  _Translations$timeInApp$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Time in the app';
  @override
  String get titleHighlight => 'app';
  @override
  String get text => 'We hide cards and reminders until you come back.';
  @override
  String get cancel => 'Cancel';
}

// Path: today
class _Translations$today$en extends Translations$today$pt {
  _Translations$today$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String greetingMorning({required Object name}) => 'Good morning, ${name}';
  @override
  String greetingAfternoon({required Object name}) => 'Good afternoon, ${name}';
  @override
  String greetingEvening({required Object name}) => 'Good evening, ${name}';
  @override
  String get greetingNoName => 'Hello';
  @override
  String dateLine({required Object weekday, required Object month, required Object day}) =>
      '${weekday}, ${month} ${day}';
  @override
  List<String> get weekdays => [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String get invitePerson => 'Invite your person';
  @override
  String get pendingInviteTitle => 'Invite sent';
  @override
  String get pendingInviteText => 'They have not joined yet. Send again or revoke.';
  @override
  String get answer => 'Answer';
  @override
  String slipsThisWeek({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        zero: 'No slips yet',
        one: '1 slip this week',
        other: '${count} slips this week',
      );
  @override
  String get weekHintEmpty => 'no rush';
  @override
  String get weekHint => 'card for the week';
  @override
  String get forToday => 'For today';
  @override
  String get ideaLabel => 'Idea of the day';
  @override
  String get sundayCardLabel => 'Sunday card';
  @override
  String get sundayCardTitle => 'Your card for this week';
  @override
  String get inviteCardLabel => 'Invite';
  @override
  String inviteCardTitle({required Object name}) => 'Invite ${name}';
  @override
  String get inviteCardTitleNoName => 'Invite your person';
  @override
  String get inviteCardText => 'Shared cards and tools need both of you.';
  @override
  String get privateTag => 'Only yours';
  @override
  String get privateQuestion => 'How was your day, really?';
  @override
  String get privateHighlight => 'day';
  @override
  String get privateAction => 'Note a slip';
  @override
  String get emptyWeekTag => 'No rush';
  @override
  String get emptyWeekQuestion => 'What was one good thing today?';
  @override
  String get emptyWeekHighlight => 'good';
  @override
  String get emptyWeekAction => 'Note a slip';
  @override
  String get nothingReceived => 'No new cards. No rush.';
  @override
  String get cardReceived => 'You received a card';
  @override
  String firstDayGreeting({required Object name}) => 'Hi, ${name}';
  @override
  String get firstDaySubtitle => 'so glad you are here';
  @override
  String get firstDayTag => 'Good start';
  @override
  String firstDayTitle({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'You have 1 slip.',
        other: 'You have ${count} slips.',
      );
  @override
  String firstDayHighlight({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 slip',
        other: '${count} slips',
      );
  @override
  String get firstDayText => 'A slip is one good thing, in one line. On Sunday they become a card.';
  @override
  String get firstDayAction => 'Note one more';
  @override
  String get errorTitle => 'Could not load Today';
  @override
  String get errorText => 'Your slips are safe. Try again.';
  @override
  String cardReceivedNamed({required Object name}) => '${name} sent you a card';
  @override
  String get inviteCardSupport =>
      'Your space already works. The other person joins whenever they want.';
  @override
  String get inviteCardAction => 'Invite';
  @override
  String get carouselCardTag => 'Card';
  @override
  String get carouselCardSupport => 'Open to see the good things from this week.';
  @override
  String get carouselCardAction => 'Open';
  @override
  String get weekTag => 'Your week';
  @override
  String get weekReadyTitle => 'Your week is ready';
  @override
  String get weekReadySupport => 'A summary of what you two did.';
  @override
  String get weekReadySupportPrivate => 'A summary just for you.';
  @override
  String get weekReadyAction => 'See';
  @override
  String get haveCode => 'I already have a code';
  @override
  String get partnerProfile => 'Partner profile';
  @override
  String get privateWeekTitle => 'Your private slips';
  @override
  String privateWeekCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        zero: 'no rush',
        one: '1 this week',
        other: '${count} this week',
      );
  @override
  late final _Translations$today$conflict$en conflict = _Translations$today$conflict$en._(_root);
  @override
  String get questionTag => 'Today';
  @override
  String get partnerMomentTag => 'For this moment';
  @override
  String get partnerMomentSupport => 'A small idea can help.';
  @override
  String get partnerMomentAction => 'See ideas';
  @override
  String get offlineBand => 'No connection. Showing what was already on your phone.';
}

// Path: unpair
class _Translations$unpair$en extends Translations$unpair$pt {
  _Translations$unpair$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get appBarTitle => 'Unpair';
  @override
  String title({required Object name}) => 'Unpair from ${name}?';
  @override
  String get text => 'Shared cards and lists stop. Your notes stay with you.';
  @override
  String get confirm => 'Unpair';
  @override
  String get cancel => 'Cancel';
  @override
  String get unnamedPartner => 'your person';
  @override
  late final _Translations$unpair$done$en done = _Translations$unpair$done$en._(_root);
  @override
  late final _Translations$unpair$relationship$en relationship =
      _Translations$unpair$relationship$en._(_root);
  @override
  late final _Translations$unpair$breakup$en breakup = _Translations$unpair$breakup$en._(_root);
  @override
  late final _Translations$unpair$partnerNotice$en partnerNotice =
      _Translations$unpair$partnerNotice$en._(_root);
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Check your internet and try again.',
    'STILL_PAIRED': 'The relationship is still active. Try again.',
    'other': 'Could not unpair right now. Try again.',
  };
}

// Path: weeklyReview
class _Translations$weeklyReview$en extends Translations$weeklyReview$pt {
  _Translations$weeklyReview$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Your week';
  @override
  String get titleHighlight => 'week';
  @override
  String range({required Object month, required Object start, required Object end}) =>
      '${month} ${start} to ${end}';
  @override
  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  @override
  String slips({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'slip',
        other: 'slips',
      );
  @override
  String moodDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        zero: 'mood days',
        one: 'mood day',
        other: 'mood days',
      );
  @override
  String rituals({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        zero: 'rituals done',
        one: 'ritual done',
        other: 'rituals done',
      );
  @override
  String get note => 'Counted by the app, no AI. Only you see it.';
  @override
  String get talk => 'Talk about it';
  @override
  String get close => 'Close';
  @override
  String get quietTitle => 'A quiet week';
  @override
  String get quietHighlight => 'quiet';
  @override
  String get quietCardTitle => 'No rush';
  @override
  String get quietCardText => 'Writing a good thing takes 30 seconds. Start whenever you like.';
  @override
  String get quietNote => 'Never compared with other weeks.';
  @override
  String get writeSlip => 'Write a slip';
  @override
  String get errorTitle => 'We could not open your week';
  @override
  Map<String, String> get errors => {
    'NETWORK': 'No connection. Try again.',
    'other': 'Something went wrong. Try again.',
  };
}

// Path: welcome
class _Translations$welcome$en extends Translations$welcome$pt {
  _Translations$welcome$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get headline => 'Small good things, said out loud.';
  @override
  String get headlineHighlight => 'said out loud';
  @override
  String get subtitle => 'A light way to notice what the other does well, every week.';
  @override
  String get start => 'Get started';
  @override
  String get haveAccount => 'I already have an account';
  @override
  String get debugSignIn => 'Sign in (debug)';
}

// Path: widgets
class _Translations$widgets$en extends Translations$widgets$pt {
  _Translations$widgets$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get settingsTitle => 'Widgets';
  @override
  String get settingsSubtitle => 'Home screen';
  @override
  String get togetherCategory => 'HOME SCREEN';
  @override
  String get togetherTitle => 'Mingo widgets';
  @override
  String get togetherSubtitle => 'Calm reminders for you or for the two of you.';
  @override
  String get galleryTitle => 'Widgets';
  @override
  String get segmentOwn => 'Just mine';
  @override
  String get segmentCouple => 'Couple';
  @override
  String get ownSlipLabel => 'LOG SLIP';
  @override
  String get ownSlipTitle => '+ Slip';
  @override
  String get ownSlipSubtitle => 'Tap to log';
  @override
  String get ownIdeaLabel => 'DAILY IDEA';
  @override
  String get ownIdeaDefault => 'Leave a small note today';
  @override
  String get ownIdeaHint => 'One idea for today.';
  @override
  String get ownJarLabel => 'BAD DAY JAR';
  @override
  String get ownJarTitle => 'Open a saved slip';
  @override
  String get ownJarPrivacy => 'Private: only on your device';
  @override
  String get lockScreenLabel => 'LOCK SCREEN';
  @override
  String get lockScreenDefault => 'Calm reminder · No names';
  @override
  String get coupleCounterLabel => 'COUNTER';
  @override
  String get coupleCounterUnset => 'Set your relationship date to see days together';
  @override
  String coupleCounterDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '${count} day together',
        other: '${count} days together',
      );
  @override
  String get couplePhotosLabel => 'COUPLE PHOTOS · PLUS';
  @override
  String get couplePhotosPrompt => 'Choose a photo of you two';
  @override
  String get couplePhotosPlusHint => 'Available with Plus';
  @override
  String get cardEncounterLabel => 'CARD & DATE';
  @override
  String get cardStateReady => 'A card arrived · Tap to open';
  @override
  String get cardStateSent => 'Card sent · Waiting for Sunday';
  @override
  String get cardStateNone => 'Sunday card in preparation';
  @override
  String get unpairedBanner => 'No partner connected: couple widgets show a neutral state.';
  @override
  String get offlineBanner => 'Showing the last saved data. Updates when back online.';
  @override
  String get loadErrorTitle => 'Could not load widgets';
  @override
  String get loadErrorBody => 'Check your connection and try again.';
  @override
  String get retryAction => 'Try again';
  @override
  String get themeLight => 'Light';
  @override
  String get themeDark => 'Dark';
  @override
  String get signedOutLabel => 'Mingo';
  @override
  String get signedOutBody => 'Tap to sign in';
  @override
  String get ownSmallPageTitle => 'Widget · Mine (small)';
  @override
  String get ownSmallSlipAction => 'Log';
  @override
  String get ownSmallDateDefaultTitle => 'Next date';
  @override
  String ownSmallDateDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '${count} day',
        other: '${count} days',
      );
  @override
  String get ownSmallMoodLabel => 'MOOD';
  @override
  String get ownSmallMoodPrompt => 'How are you?';
  @override
  String get ownSmallMoodOptions => 'Happy · Tired · Sad';
  @override
  String get ownSmallRitualLabel => 'RITUAL';
  @override
  String get ownSmallRitualDefaultTitle => 'Sunday walk';
  @override
  String get ownSmallRitualDefaultTime => 'Sun · 10:00';
  @override
  String get ownMediumPageTitle => 'Widget · Mine (medium)';
  @override
  String get ownMediumIdeaAction => 'Tap to view';
  @override
  String get ownMediumJarTitle => 'Tap to open a saved slip';
  @override
  String get ownMediumJarPrivacy => 'Private: only appears on your device';
  @override
  String get lockScreenPageTitle => 'Lock screen';
  @override
  String get lockScreenClockTime => '19:38';
  @override
  String get lockScreenClockDate => 'Friday, April 10';
  @override
  String get lockScreenReadyAction => 'I am ready';
  @override
  String get lockScreenGenericPhrase => 'Calm moment';
  @override
  String get lockScreenPrivacyRule => 'Never shows names or messages on the lock screen.';
  @override
  String get lockScreenDisabledNote => 'The lock-screen widget is turned off in widget settings.';
  @override
  String get lockScreenFamiliesTitle => 'iOS formats (Circular, Rectangular and Inline)';
  @override
  String get counterPageTitle => 'Widget · Counter';
  @override
  String counterYearsMonthsTitle({required Object years, required Object months}) =>
      '${years} years · ${months} months';
  @override
  String counterMonthsDaysSubtitle({required Object months, required Object days}) =>
      '${months} months · ${days} days';
  @override
  String get counterStatusDating => 'Dating';
  @override
  String get counterStatusLivingTogether => 'Living together';
  @override
  String get counterStatusMarried => 'Married';
  @override
  String get counterStatusTogether => 'Together';
  @override
  String get counterMidnightNote => 'The counter updates automatically at local midnight.';
  @override
  String get counterSetDateAction => 'Set relationship date';
  @override
  String get photosPageTitle => 'Widget · Couple photos';
  @override
  String get photosPlusBadge => 'PLUS';
  @override
  String get photosNeutralFallbackNote =>
      'When no photo is saved on this device, the widget shows only the neutral card with the time together.';
  @override
  String get photosUnlockPlusAction => 'Explore Plus';
  @override
  String get photosChooseAction => 'Choose photo';
  @override
  String get photosRemoveAction => 'Remove photo';
  @override
  String get photosSavedToast => 'Photo saved to the widget.';
  @override
  String get photosRemovedToast => 'Photo removed from the widget.';
  @override
  String get cardEncounterPageTitle => 'Card & next date';
  @override
  String get cardWeeklyLabel => 'Weekly card';
  @override
  String get cardReadyTitle => 'A card arrived';
  @override
  String get cardReadySubtitle => 'Tap to open';
  @override
  String get cardSentTitle => 'Card sent';
  @override
  String get cardSentSubtitle => 'Waiting for Sunday';
  @override
  String get cardNoneTitle => 'Sunday card';
  @override
  String get cardNoneSubtitle => 'In preparation';
  @override
  String get nextEncounterLabel => 'Next date';
  @override
  String get nextEncounterEmptyTitle => 'No upcoming date';
  @override
  String get nextEncounterEmptySubtitle => 'Tap to schedule';
  @override
  String get cardEncounterPrivacyNote =>
      'This widget only shows card status and the next date — never names or card text.';
  @override
  String get statesUnpairedTitle => 'Invite to see here';
  @override
  String get statesUnpairedAction => 'Invite';
  @override
  Map<String, String> get errors => {
    'WIDGET_PREFERENCES_SAVE_FAILED': 'Could not save widget preferences right now.',
    'COUPLE_PHOTO_LOAD_FAILED': 'Could not load the couple photo right now.',
    'COUPLE_PHOTO_UPLOAD_FAILED': 'Could not save the couple photo right now.',
    'COUPLE_PHOTO_REMOVE_FAILED': 'Could not remove the couple photo right now.',
    'COUPLE_PHOTO_INVALID': 'Choose a JPG, PNG, WebP or HEIC image up to 8 MB.',
    'COUPLE_PHOTO_READ_FAILED': 'Could not read the selected file.',
    'COUPLE_PHOTO_PICK_FAILED': 'Could not open the photo picker.',
    'COUPLE_PHOTO_SIGNED_OUT': 'Sign in to choose a couple photo.',
    'COUPLE_PHOTO_NOT_PAIRED': 'Connect with your partner to choose a couple photo.',
    'other': 'Could not save widget preferences right now.',
  };
  @override
  String get howToAddAndroidLockNote =>
      'On modern Android the widgets live on the home screen. The lock screen only uses neutral notification icons.';
  @override
  String get howToAddIosLockNote =>
      'On iOS 16 or newer, you can also add the widget to the lock screen.';
  @override
  String get coupleLabel => 'COUPLE';
  @override
  String get gallerySubtitle => 'Small pieces of the app on your home screen.';
  @override
  String get favoritesGroup => 'Most loved';
  @override
  String get mediumGroup => 'Medium';
  @override
  String get ownSmallGroup => 'Log and remember';
  @override
  String get ownGroupHint => 'Work without a partner and only show what is yours.';
  @override
  String get ownSmallEntryTitle => 'Small';
  @override
  String get ownSmallEntryHint => 'Log, remember and the Sunday card.';
  @override
  String get ownMediumEntryTitle => 'Medium';
  @override
  String get ownMediumEntryHint => 'Your week, an idea and the next date.';
  @override
  String get ownSmallTitle => 'Just mine: small';
  @override
  String get ownMediumTitle => 'Just mine: medium';
  @override
  String get counterEyebrow => 'TOGETHER';
  @override
  String get counterNeedDate => 'Set your relationship date';
  @override
  String counterDaysUnit({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '${count} day',
        other: '${count} days',
      );
  @override
  String counterBreakdown({required Object years, required Object months, required Object days}) =>
      '${years} years, ${months} months and ${days} days';
  @override
  String get counterToday => 'Today';
  @override
  String counterSince({required Object date}) => 'Since ${date}';
  @override
  String get partnerMoodLabel => 'PARTNER MOOD';
  @override
  String partnerMoodNow({required Object name}) => '${name} now';
  @override
  String get partnerMoodNowAnonymous => 'Now';
  @override
  String get partnerMoodHidden => 'Mood appears when your partner shares it.';
  @override
  String get longingLabel => 'MISSING US';
  @override
  String get longingAction => 'Send some missing';
  @override
  String get longingReceived => 'Your partner misses you';
  @override
  String get longingHint => 'One tap and they feel it.';
  @override
  String get ritualLabel => 'RITUAL';
  @override
  String get ritualEmptyTitle => 'Create a ritual';
  @override
  String get ritualEmptyHint => 'A moment that is yours.';
  @override
  String noteFromPartner({required Object time}) => 'from your partner · ${time}';
  @override
  String noteFromName({required Object name, required Object time}) => 'from ${name} · ${time}';
  @override
  String get noteEmpty => 'No note here yet';
  @override
  String get noteEmptyHint => 'A note appears when your partner chooses to send one.';
  @override
  String get noteDisabled => 'Notes are off';
  @override
  String get noteDisabledHint => 'Turn on “Notes on the widget” to see them.';
  @override
  String nextEncounterInDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'in ${count} day',
        other: 'in ${count} days',
      );
  @override
  String get cardSundayTitle => 'Sunday card';
  @override
  String cardSendAt({required Object day, required Object time}) => 'out ${day}, ${time}';
  @override
  String get cardReadyShort => 'A card arrived';
  @override
  String get cardSentShort => 'Card sent';
  @override
  String get cardNoneShort => 'Sunday card';
  @override
  String get distanceLabel => 'LONG DISTANCE';
  @override
  String get distanceHidden => 'Your partner\'s timezone is not set';
  @override
  String get distanceHint => 'Each in their own timezone.';
  @override
  String distanceUntil({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '${count} day until you meet',
        other: '${count} days until you meet',
      );
  @override
  String get distanceNoReunion => 'Next meeting without a date';
  @override
  String distanceYou({required Object city}) => '${city} · you';
  @override
  String get ownNextDateLabel => 'NEXT DATE';
  @override
  String get ownNextDateHint => 'Tap to see the dates';
  @override
  String ownDateCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '${count} day',
        other: '${count} days',
      );
  @override
  String get ownWeekTitle => 'My week';
  @override
  String ownWeekCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '${count} slip',
        other: '${count} slips',
      );
  @override
  List<String> get weekdays => ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  @override
  Map<String, String> get familyLabels => {
    'counter': 'Counter',
    'counterMedium': 'Counter',
    'partnerMood': 'Partner mood',
    'longing': 'Missing us',
    'ritual': 'Ritual',
    'partnerNote': 'Partner note',
    'cardEncounter': 'Card & date',
    'distance': 'Long distance',
    'ownSlip': 'Log slip',
    'ownNextDate': 'Next date',
    'ownRitual': 'Ritual',
    'ownSundayCard': 'Sunday card',
    'ownWeek': 'My week',
    'ownIdea': 'Idea of the day',
    'ownMediumDate': 'Next date',
    'other': 'Widget',
  };
  @override
  String get moodJustNow => 'just now';
  @override
  String moodMinutesAgo({required Object minutes}) => '${minutes} min ago';
  @override
  String moodHoursAgo({required Object hours}) => '${hours} h ago';
  @override
  String moodDaysAgo({required Object days}) => '${days} d ago';
  @override
  String get ownSlipQuestion => 'How was your day?';
  @override
  String get ownSlipAction => 'Log a slip';
  @override
  String get howToAddAction => 'How to add';
  @override
  String get howToAddTitle => 'How to add';
  @override
  String get howToAddSubtitle => 'Straight from the home screen, with no extra Mingo permission.';
  @override
  String get howToAddIosStep1 => 'Touch and hold an empty spot on the home screen.';
  @override
  String get howToAddIosStep2 => 'Tap + in the top corner.';
  @override
  String get howToAddIosStep3 => 'Choose Mingo and the widget size.';
  @override
  String get howToAddAndroidStep1 => 'Touch and hold an empty spot on the home screen.';
  @override
  String get howToAddAndroidStep2 => 'Tap Widgets.';
  @override
  String get howToAddAndroidStep3 => 'Choose Mingo and drag it to the screen.';
  @override
  String get howToAddLockIosStep1 => 'Touch and hold the lock screen.';
  @override
  String get howToAddLockIosStep2 => 'Tap Customize.';
  @override
  String get howToAddLockIosStep3 => 'Add the Mingo widget below the clock.';
  @override
  String get howToAddNote => 'You can remove the widget whenever you want; nothing is deleted.';
  @override
  String get widgetPrivacyTitle => 'What appears on widgets';
  @override
  String get showNamesTitle => 'Names and initials';
  @override
  String get showNamesHint => 'When off, widgets show only the content.';
  @override
  String get allowNotesTitle => 'Notes on the widget';
  @override
  String get allowNotesHint => 'Only notes your partner marked for the widget.';
  @override
  String get privacySectionHint =>
      'Follows your privacy choices. What is hidden in the app stays hidden here.';
  @override
  String get settingsSaved => 'Preferences updated.';
  @override
  String get lockScreenCircular => 'Circular';
  @override
  String get lockScreenRectangular => 'Rectangular';
  @override
  String get lockScreenInline => 'Inline';
  @override
  String get lockScreenNeutralLabel => 'NEUTRAL TEXT';
  @override
  String get lockScreenNeutralPhrase => 'No names on the lock screen';
  @override
  String get lockScreenAndroidUnavailable =>
      'The Android lock screen does not accept widgets. Use the home-screen widgets.';
  @override
  String get ownNextDateDefault => 'Next date';
  @override
  String get ownSundayCardLabel => 'SUNDAY CARD';
  @override
  String get ownGroupTitle => 'Just mine';
  @override
  String get soloBanner => 'Couple widgets appear once you connect.';
  @override
  String get previewSmall => 'Small';
  @override
  String get previewMedium => 'Medium';
  @override
  String get counterSmallLabel => 'Small';
  @override
  String get counterMediumLabel => 'Medium, with timeline';
  @override
  String get partnerNotePageTitle => 'Partner note';
  @override
  String get partnerNotePrivacy => 'Only what your partner chose to send to the widget appears.';
  @override
  String get moodLongingPageTitle => 'Mood and missing';
  @override
  String get partnerMoodPrivacy => 'Mood only appears if your partner shared it.';
  @override
  String get longingPrivacy => 'Missing appears when your partner sends it.';
  @override
  String get moodUpdateAction => 'Update my mood';
  @override
  String get openDatesAction => 'See dates';
  @override
  String get lockReminderShortLabel => 'Reminder';
}

// Path: acceptInvite.connected
class _Translations$acceptInvite$connected$en extends Translations$acceptInvite$connected$pt {
  _Translations$acceptInvite$connected$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'You are connected';
  @override
  String get titleHighlight => 'connected';
  @override
  String get text => 'Shared cards and tools are on. Everything private stays private.';
  @override
  String get goToToday => 'Go to Today';
}

// Path: acceptInvite.unusable
class _Translations$acceptInvite$unusable$en extends Translations$acceptInvite$unusable$pt {
  _Translations$acceptInvite$unusable$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'That invite is old';
  @override
  String get titleHighlight => 'old';
  @override
  String get text => 'Check the code or ask for a new invite from whoever invited you.';
  @override
  String get tryAgain => 'Type again';
  @override
  String get close => 'Close';
}

// Path: account.export
class _Translations$account$export$en extends Translations$account$export$pt {
  _Translations$account$export$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get appBarTitle => 'Export my data';
  @override
  String get title => 'Take your data with you';
  @override
  String get titleHighlight => 'your data';
  @override
  String get text =>
      'We build a file with only what is yours: slips, notes and answers. Nothing from the other person goes in it.';
  @override
  String get note => 'The link lasts a few minutes. You can build one file a day.';
  @override
  String get action => 'Build the file';
  @override
  String get again => 'Build again';
  @override
  String get beforeDelete => 'Export before deleting';
  @override
  String get openFailed => 'We could not open the file. Try building it again.';
  @override
  Map<String, String> get errors => {
    'EXPORT_LIMIT': 'You already built a file today. Try again tomorrow.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not build the file now. Try again.',
  };
}

// Path: chat.action
class _Translations$chat$action$en extends Translations$chat$action$pt {
  _Translations$chat$action$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get privateHint => 'Stays only with you.';
  @override
  String get partnerHint => 'Nothing goes until you tap.';
  @override
  String moodText({required Object mood}) => 'Today: ${mood}';
  @override
  Map<String, String> get moods => {
    'happy': 'happy',
    'tired': 'tired',
    'sad': 'sad',
    'stressed': 'stressed',
    'loving': 'loving',
    'playful': 'playful',
  };
  @override
  String get dismiss => 'Not now';
  @override
  String get running => 'One moment…';
  @override
  String get done => 'Done';
  @override
  String get dismissed => 'Set aside';
  @override
  String get failed => 'It did not work';
  @override
  String get retry => 'Try again';
  @override
  Map<String, String> get runLabels => {
    'create_private_slip': 'Save',
    'send_slip_to_partner': 'Send',
    'log_mood': 'Log',
    'share_mood': 'Share',
    'save_learning': 'Keep',
    'open_purchase': 'See Plus',
    'other': 'Do it',
  };
  @override
  Map<String, String> get tags => {
    'create_private_slip': 'Suggestion · Write a slip',
    'send_slip_to_partner': 'Suggestion · Send a slip',
    'log_mood': 'Suggestion · Log mood',
    'share_mood': 'Suggestion · Share mood',
    'save_learning': 'Suggestion · Remember this',
    'suggest_couple_question': 'A question to talk about',
    'draft_note': 'Draft note',
    'open_purchase': 'Plus',
    'other': 'Suggestion',
  };
}

// Path: games.hub
class _Translations$games$hub$en extends Translations$games$hub$pt {
  _Translations$games$hub$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Play';
  @override
  String get subtitle => 'Short games for the two of you. No scores and no winner.';
  @override
  String get guessLabel => 'Guesses';
  @override
  String get talkLabel => 'Conversation';
  @override
  String get challengeLabel => 'Challenge';
  @override
  String minutes({required Object minutes}) => '${minutes} min';
  @override
  String invitedTitle({required Object name}) => '${name} invited you';
  @override
  String get invitedFallbackTitle => 'Your partner invited you';
  @override
  String get join => 'Join';
  @override
  String stateWaiting({required Object name}) => 'Waiting for ${name}';
  @override
  String get stateWaitingFallback => 'Waiting for your partner';
  @override
  String get stateInvited => 'Invited you';
  @override
  String get stateActive => 'In progress';
  @override
  String get stateFinished => 'Finished';
  @override
  String get stateCancelled => 'Invitation cancelled';
  @override
  String get stateExpired => 'Invitation expired';
  @override
  String get lockChip => 'Needs both of you';
  @override
  String get noPartnerNote => 'Games need both of you. When your partner joins, you can play.';
  @override
  String get refreshNote => 'To see if anything changed, come back to the app or pull to refresh.';
  @override
  String get loadErrorTitle => 'Could not open the games';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
  @override
  String questionCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 question',
        other: '${count} questions',
      );
  @override
  String guessCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 guess',
        other: '${count} guesses',
      );
}

// Path: games.kinds
class _Translations$games$kinds$en extends Translations$games$kinds$pt {
  _Translations$games$kinds$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$games$kinds$meOrYou$en meOrYou = _Translations$games$kinds$meOrYou$en._(
    _root,
  );
  @override
  late final _Translations$games$kinds$howWell$en howWell = _Translations$games$kinds$howWell$en._(
    _root,
  );
  @override
  late final _Translations$games$kinds$twentyQuestions$en twentyQuestions =
      _Translations$games$kinds$twentyQuestions$en._(_root);
  @override
  late final _Translations$games$kinds$neverHaveWe$en neverHaveWe =
      _Translations$games$kinds$neverHaveWe$en._(_root);
  @override
  late final _Translations$games$kinds$mission$en mission = _Translations$games$kinds$mission$en._(
    _root,
  );
}

// Path: games.start
class _Translations$games$start$en extends Translations$games$start$pt {
  _Translations$games$start$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get noWinnerNote => 'No winner, no points.';
  @override
  String cta({required Object name}) => 'Invite ${name}';
  @override
  String get ctaFallback => 'Invite your partner';
  @override
  String get cancelledNote =>
      'The last invitation was cancelled. You can start again whenever you like.';
  @override
  String get expiredNote => 'The previous invitation expired. Invite again whenever you like.';
  @override
  String get noContentTitle => 'This game has no questions yet';
  @override
  String get noContentText => 'There is no content to play yet. Come back soon.';
}

// Path: games.invitation
class _Translations$games$invitation$en extends Translations$games$invitation$pt {
  _Translations$games$invitation$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object name}) => '${name} invited you';
  @override
  String get titleFallback => 'Your partner invited you';
  @override
  String get join => 'Play now';
  @override
  String get later => 'Later';
}

// Path: games.waiting
class _Translations$games$waiting$en extends Translations$games$waiting$pt {
  _Translations$games$waiting$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String text({required Object name}) => 'Invitation sent to ${name}. It starts when they join.';
  @override
  String get textFallback => 'Invitation sent. It starts when your partner joins.';
  @override
  String get status => 'Waiting…';
  @override
  String get window => 'The invitation waits for up to 48 hours.';
  @override
  String get checkAgain => 'Check if they joined';
  @override
  String get stillWaiting => 'Not in yet. The invite is still here.';
  @override
  String get cancel => 'Cancel';
}

// Path: games.active
class _Translations$games$active$en extends Translations$games$active$pt {
  _Translations$games$active$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get cancel => 'End the game';
}

// Path: games.playing
class _Translations$games$playing$en extends Translations$games$playing$pt {
  _Translations$games$playing$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String progress({required Object current, required Object total}) =>
      'Question ${current} of ${total}';
  @override
  String guessProgress({required Object current, required Object total}) =>
      'Guess ${current} of ${total}';
  @override
  String get me => 'Me';
  @override
  String get both => 'Both';
  @override
  String get partnerFallback => 'Your partner';
  @override
  String get skip => 'Skip';
  @override
  String get guessAboutYou => 'About you';
  @override
  String guessAboutPartner({required Object name}) => 'About ${name}';
  @override
  String get guessAboutPartnerFallback => 'About your partner';
  @override
  String guessPrompt({required Object name}) => 'What did ${name} answer?';
  @override
  String get guessPromptFallback => 'What did your partner answer?';
  @override
  String get answerHint => 'Answer as you would.';
  @override
  String get guessHint => 'Guess what they answered.';
  @override
  String get talkHint => 'Write your answer. Only you can read it until you both finish.';
  @override
  String get talkSubtitle => 'Answer in private, reveal together.';
  @override
  String get talkNote => 'Your partner only sees this after both of you answer.';
  @override
  String get privacyNote => 'Each of you answers in private. Skipping is always allowed.';
  @override
  String changeNote({required Object name}) =>
      'You can change your answer until ${name} answers this question.';
  @override
  String get changeNoteFallback =>
      'You can change your answer until your partner answers this question.';
  @override
  String get lockedNote => 'This game is closed. This answer can no longer be edited.';
  @override
  String get introCta => 'Start';
  @override
  String get next => 'Next';
  @override
  String get nextGuess => 'Next';
}

// Path: games.date
class _Translations$games$date$en extends Translations$games$date$pt {
  _Translations$games$date$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get missionTag => 'Mission';
  @override
  String get start => 'Accept';
  @override
  String get startNote => 'Do the mission together, then come back and tell how it was.';
  @override
  String get reflectionTitle => 'How was it?';
  @override
  String get reflectionText =>
      'Pick what happened. Your partner sees it only after you both answer.';
  @override
  String get save => 'Save';
}

// Path: games.waitingPartner
class _Translations$games$waitingPartner$en extends Translations$games$waitingPartner$pt {
  _Translations$games$waitingPartner$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'I\'m done';
  @override
  String text({required Object name}) =>
      'Now it is ${name}\'s turn. You see the result when both of you finish.';
  @override
  String get textFallback =>
      'Now it is your partner\'s turn. You see the result when both of you finish.';
  @override
  String get checkAgain => 'Check if they finished';
  @override
  String get close => 'Close';
  @override
  String get cancel => 'End the game';
  @override
  String get note => 'Nothing you answered appears before both of you finish.';
  @override
  String get stillWaiting => 'Not done yet. The result appears when both of you finish.';
}

// Path: games.finished
class _Translations$games$finished$en extends Translations$games$finished$pt {
  _Translations$games$finished$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String pickTitle({required Object agreed, required Object total}) =>
      'You agreed on ${agreed} of ${total}';
  @override
  String pickHighlight({required Object agreed, required Object total}) => '${agreed} of ${total}';
  @override
  String get pickNote => 'The differences become conversation, not a score.';
  @override
  String get discoveriesTitle => 'Discoveries';
  @override
  String get discoveriesText => 'Things you still did not know about each other.';
  @override
  String get youDidNotKnow => 'You did not know';
  @override
  String partnerDidNotKnow({required Object name}) => '${name} did not know';
  @override
  String partnerAnswered({required Object name, required Object value}) =>
      '${name} answered: ${value}';
  @override
  String youAnswered({required Object value}) => 'You answered: ${value}';
  @override
  String get noDiscoveries =>
      'No discoveries this time: you already knew what the other would answer.';
  @override
  String get doneTitle => 'Done';
  @override
  String doneText({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'You answered 1 question. No winner, no score.',
        other: 'You answered ${count} questions. No winner, no score.',
      );
  @override
  String get dateText => 'No winner, no score. Just your date.';
  @override
  String get you => 'You';
  @override
  String get noAnswer => 'No answer';
  @override
  String get both => 'Both of you';
  @override
  String bothSaid({required Object value}) => 'You both said: ${value}';
  @override
  String eachSaid({required Object you, required Object name, required Object partner}) =>
      'You said ${you} · ${name} said ${partner}';
  @override
  String get matchedLabel => 'Same';
  @override
  String get differentLabel => 'Different';
  @override
  String get replayTag => 'New round';
  @override
  String replayQuestions({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 question you have not seen yet',
        other: '${count} questions you have not seen yet',
      );
  @override
  String replayGuesses({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 guess you have not seen yet',
        other: '${count} guesses you have not seen yet',
      );
  @override
  String get replayMission => 'A new mission for you';
  @override
  String get replayText =>
      'Each round brings new content. When it runs out, the app tells you and mixes in what you already saw.';
  @override
  String get playAgain => 'Play again';
  @override
  String get chooseAnother => 'Choose another game';
  @override
  String get missingTitle => 'This round is no longer available';
  @override
  String get missingText => 'The content changed since you played. You can start another one.';
}

// Path: games.notFound
class _Translations$games$notFound$en extends Translations$games$notFound$pt {
  _Translations$games$notFound$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'This game does not exist';
  @override
  String get text => 'It may have changed or never existed. Go back and pick another one.';
  @override
  String get action => 'Go back';
}

// Path: games.cancel
class _Translations$games$cancel$en extends Translations$games$cancel$pt {
  _Translations$games$cancel$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'End the game?';
  @override
  String get text => 'The game ends for both of you. You can start another later.';
  @override
  String get confirm => 'End game';
  @override
  String get keep => 'Keep playing';
}

// Path: games.noPartner
class _Translations$games$noPartner$en extends Translations$games$noPartner$pt {
  _Translations$games$noPartner$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Games are for two';
  @override
  String get text => 'When your partner joins, you can play together.';
}

// Path: games.common
class _Translations$games$common$en extends Translations$games$common$pt {
  _Translations$games$common$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get back => 'Back';
}

// Path: guides.hub
class _Translations$guides$hub$en extends Translations$guides$hub$pt {
  _Translations$guides$hub$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Difficult conversations';
  @override
  String get titleHighlight => 'Difficult';
  @override
  String get subtitle => 'One step at a time, in private.';
  @override
  String get privateNote => 'Your notes stay with you. Nothing is sent to your partner.';
  @override
  String stepCount({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 step',
        other: '${count} steps',
      );
  @override
  String get loadErrorTitle => 'Could not open the topics';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
}

// Path: guides.viewer
class _Translations$guides$viewer$en extends Translations$guides$viewer$pt {
  _Translations$guides$viewer$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String stepOf({required Object current, required Object total}) => 'Step ${current} of ${total}';
  @override
  String get answerHint => 'Write whatever makes sense. It can stay blank.';
  @override
  String get stepNote => 'Saved as you go. Only you can see it.';
  @override
  String get next => 'Next';
  @override
  String get finish => 'Finish';
  @override
  String get back => 'Back';
  @override
  String get loadErrorTitle => 'Could not open this conversation';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
  @override
  Map<String, String> get errors => {
    'other': 'Could not save right now. Your answers are still here.',
  };
}

// Path: guides.gate
class _Translations$guides$gate$en extends Translations$guides$gate$pt {
  _Translations$guides$gate$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'A sensitive topic';
  @override
  String get text =>
      'This topic is about intimacy and is meant for adults. You can go slowly or choose another topic whenever you like.';
  @override
  String get cycleText =>
      'This topic is about your body and mood through the month and is meant for adults. You can go slowly or choose another topic whenever you like.';
  @override
  String get continueAction => 'Continue';
  @override
  String get otherAction => 'See other topics';
}

// Path: guides.finish
class _Translations$guides$finish$en extends Translations$guides$finish$pt {
  _Translations$guides$finish$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Your conversation is ready';
  @override
  String get titleHighlight => 'ready';
  @override
  String get text => 'Your notes are saved to your account, privately.';
  @override
  String get finishSaved => 'Saved only for you.';
  @override
  String get start => 'Start a conversation';
  @override
  String get other => 'Back to topics';
}

// Path: intro.phase
class _Translations$intro$phase$en extends Translations$intro$phase$pt {
  _Translations$intro$phase$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Where are you two right now?';
  @override
  String get titleHighlight => 'right now';
  @override
  String get subtitle => 'Pick the closest one. You can change it later.';
  @override
  Map<String, String> get options => {
    'dating': 'Dating',
    'livingTogether': 'Living together',
    'engaged': 'Engaged',
    'married': 'Married',
    'longDistance': 'Long distance',
    'restarting': 'Starting over',
    'other': '',
  };
}

// Path: intro.goals
class _Translations$intro$goals$en extends Translations$intro$goals$pt {
  _Translations$intro$goals$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'What do you want from the app?';
  @override
  String get titleHighlight => 'app';
  @override
  String get subtitle => 'Pick as many as you like.';
  @override
  Map<String, String> get options => {
    'reconnect': 'Reconnect',
    'fightLess': 'Fight less',
    'keepRomance': 'Keep the romance',
    'rememberDates': 'Remember dates',
    'organizeRoutine': 'Organise the routine',
    'justRecord': 'Just note the good things',
    'other': '',
  };
}

// Path: intro.theme
class _Translations$intro$theme$en extends Translations$intro$theme$pt {
  _Translations$intro$theme$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Which colour suits you?';
  @override
  String get titleHighlight => 'colour';
  @override
  String get subtitle => 'You pick the colour, not the gender. The features are the same.';
  @override
  String get rose => 'Soft rose';
  @override
  String get roseSupport => 'Delicate and warm';
  @override
  String get blue => 'Soft blue';
  @override
  String get blueSupport => 'Calm and light';
  @override
  String get neutral => 'Neutral';
  @override
  String get neutralSupport => 'Paper and green';
  @override
  String get footnote => 'You can change it later in Settings, Appearance.';
}

// Path: memories.menu
class _Translations$memories$menu$en extends Translations$memories$menu$pt {
  _Translations$memories$menu$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get timeline => 'Timeline';
  @override
  String get timelineText => 'Memories you kept';
  @override
  String get jar => 'Jar';
  @override
  String get jarText => 'A good slip for a bad day';
  @override
  String get storyText => 'Milestones, places and numbers';
  @override
  String get dates => 'Dates and numbers';
  @override
  String get datesText => 'Anniversaries, holidays and counts';
  @override
  String get diary => 'Diary';
  @override
  String get diaryText => 'Only yours, never goes to the other person';
  @override
  String get gifts => 'Gift ideas';
  @override
  String get giftsText => 'Each one\'s wishes and ideas for the other';
}

// Path: memories.onThisDay
class _Translations$memories$onThisDay$en extends Translations$memories$onThisDay$pt {
  _Translations$memories$onThisDay$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'ON THIS DAY';
  @override
  String yearsAgo({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 year ago',
        other: '${count} years ago',
      );
}

// Path: need.sent
class _Translations$need$sent$en extends Translations$need$sent$pt {
  _Translations$need$sent$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sent';
  @override
  String get text => 'Your partner will see it when they open the app.';
  @override
  String get done => 'Done';
}

// Path: notificationPreferences.types
class _Translations$notificationPreferences$types$en
    extends Translations$notificationPreferences$types$pt {
  _Translations$notificationPreferences$types$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get dailyIdea => 'Idea of the day';
  @override
  String get dateComing => 'Dates and holidays';
  @override
  String get cardReady => 'Weekly card';
  @override
  String get other => '';
}

// Path: notificationPreferences.errors
class _Translations$notificationPreferences$errors$en
    extends Translations$notificationPreferences$errors$pt {
  _Translations$notificationPreferences$errors$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get rateLimited => 'Too many tries in a row. Wait a moment.';
  @override
  String get other => 'Could not save now. Your previous choice was kept.';
}

// Path: partnerStep.why
class _Translations$partnerStep$why$en extends Translations$partnerStep$why$pt {
  _Translations$partnerStep$why$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Why invite?';
  @override
  String get shared => 'Shared cards and tools need both of you.';
  @override
  String get privacy => 'Your slips and private notes stay yours until you share them.';
}

// Path: quickSlip.saved
class _Translations$quickSlip$saved$en extends Translations$quickSlip$saved$pt {
  _Translations$quickSlip$saved$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Saved';
  @override
  String get added => 'Slip added to this week.';
  @override
  String get queued => 'Saved on this phone. We send it when the connection is back.';
  @override
  String get undoHint => 'Undo for 30 seconds.';
  @override
  String get undo => 'Undo';
  @override
  String get done => 'Done';
  @override
  String get annoyanceTitle => 'Kept';
  @override
  String get annoyanceAdded => 'It stays with you and goes away on its own in 14 days.';
}

// Path: repair.calm
class _Translations$repair$calm$en extends Translations$repair$calm$pt {
  _Translations$repair$calm$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'A moment to breathe';
  @override
  String get titleHighlight => 'breathe';
  @override
  String get cadence =>
      'Breathe in slowly for 4. Breathe out slowly for 6. Repeat at your own pace.';
  @override
  String get text => 'There\'s no rush and no timer. Leave whenever you like.';
  @override
  String get ready => 'I feel calmer';
  @override
  String get leave => 'Leave';
}

// Path: repair.softStart
class _Translations$repair$softStart$en extends Translations$repair$softStart$pt {
  _Translations$repair$softStart$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Start softly';
  @override
  String get titleHighlight => 'softly';
  @override
  String get subtitle => 'A blame-free template to open the conversation.';
  @override
  String get feeling => 'I feel…';
  @override
  String get feelingHint => 'E.g. tired';
  @override
  Map<String, String> get feelingErrors => {'empty': 'Say how you feel'};
  @override
  String get situation => 'When…';
  @override
  String get situationHint => 'E.g. the dishes wait until later';
  @override
  Map<String, String> get situationErrors => {'empty': 'Say when it happens'};
  @override
  String get need => 'I need…';
  @override
  String get needHint => 'E.g. a little help';
  @override
  Map<String, String> get needErrors => {'empty': 'Say what you need'};
  @override
  String template({required Object feeling, required Object situation, required Object need}) =>
      'I feel ${feeling} when ${situation}. I need ${need}.';
  @override
  String get use => 'Use this template';
}

// Path: repair.quick
class _Translations$repair$quick$en extends Translations$repair$quick$pt {
  _Translations$repair$quick$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'A small repair';
  @override
  String get titleHighlight => 'repair';
  @override
  String get subtitle => 'One tap sends. You can change the text first.';
  @override
  Map<String, String> get presets => {
    'tone': 'Sorry for my tone.',
    'restart': 'Can we start over?',
    'five_minutes': 'I need five minutes.',
    'love': 'I love you, even now.',
    'other': '',
  };
  @override
  String get hint => 'Write my own';
  @override
  Map<String, String> get textErrors => {
    'empty': 'Write a message',
    'tooLong': 'The message is too long',
  };
  @override
  String get send => 'Send';
  @override
  String get sentTitle => 'Sent';
  @override
  String get sentText => 'Your partner will see it when they open the app.';
  @override
  String get done => 'Done';
  @override
  Map<String, String> get errors => {
    'NOT_PAIRED': 'To send this, you need to be connected with your partner in the app.',
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t send right now. Your message is still here.',
  };
}

// Path: repair.guided
class _Translations$repair$guided$en extends Translations$repair$guided$pt {
  _Translations$repair$guided$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String stepOf({required Object current, required Object total}) => 'Step ${current} of ${total}';
  @override
  List<String> get stepTitles => ['What happened?', 'What do you need?', 'What can you offer?'];
  @override
  List<String> get stepHighlights => ['happened', 'need', 'offer'];
  @override
  List<String> get stepHints => [
    'In your own words, without blaming anyone.',
    'One thing that would help right now.',
    'Something small and sincere.',
  ];
  @override
  String get private => 'Only you see this. Nothing is sent to your partner.';
  @override
  String get next => 'Continue';
  @override
  String get back => 'Back';
  @override
  String get later => 'Save for later';
  @override
  String get savedLater => 'Saved. You\'ll pick up where you left off.';
  @override
  String get finalTitle => 'How are you now?';
  @override
  String get finalHighlight => 'now';
  @override
  Map<String, String> get feelings => {
    'calmer': 'Calmer',
    'stillTense': 'Still tense',
    'needMoreTime': 'I need more time',
    'other': '',
  };
  @override
  String get followUpTitle => 'Want a reminder to check in on how you are?';
  @override
  Map<String, String> get followUps => {
    'none': 'No need',
    'tomorrow': 'Tomorrow',
    'inThreeDays': 'In 3 days',
    'other': '',
  };
  @override
  String get followUpNote => 'The reminder is short and says nothing about what happened.';
  @override
  String get finish => 'Finish';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your answers are still here.',
  };
  @override
  String get loadErrorTitle => 'Couldn\'t open this';
  @override
  String get loadErrorText => 'Nothing was lost. Try again.';
  @override
  late final _Translations$repair$guided$done$en done = _Translations$repair$guided$done$en._(
    _root,
  );
}

// Path: repair.learning
class _Translations$repair$learning$en extends Translations$repair$learning$pt {
  _Translations$repair$learning$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'What did you learn?';
  @override
  String get titleHighlight => 'learn';
  @override
  String get subtitle => 'It stays with you and can be deleted whenever you like.';
  @override
  Map<String, String> get kinds => {
    'trigger': 'What bothers me',
    'need': 'What I need',
    'goodFix': 'What helped',
    'other': '',
  };
  @override
  String get hint => 'Write one or two sentences';
  @override
  Map<String, String> get noteErrors => {
    'empty': 'Write what you learned',
    'tooLong': 'The note is too long',
  };
  @override
  String get save => 'Save';
  @override
  String get listTitle => 'Your learnings';
  @override
  String get delete => 'Delete';
  @override
  String get emptyTitle => 'Nothing yet';
  @override
  String get emptyText => 'When you write a learning, it shows up here.';
  @override
  String get errorTitle => 'Couldn\'t load';
  @override
  String get errorText => 'Your learnings are still saved. Try again.';
  @override
  String get done => 'Done';
  @override
  Map<String, String> get errors => {
    'RATE_LIMITED': 'Too many attempts in a row. Wait a moment.',
    'other': 'Couldn\'t save right now. Your text is still here.',
  };
}

// Path: repair.next
class _Translations$repair$next$en extends Translations$repair$next$pt {
  _Translations$repair$next$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get pause => 'Breathe a little';
  @override
  String get guided => 'Start the guided repair';
  @override
  String get quick => 'Send a repair';
}

// Path: repair.sos
class _Translations$repair$sos$en extends Translations$repair$sos$pt {
  _Translations$repair$sos$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'We are fighting';
  @override
  String get titleHighlight => 'fighting';
  @override
  String get subtitle => 'Pick where to start. Nothing is sent until you confirm.';
  @override
  String get softStartTitle => 'Soft start';
  @override
  String get softStartText => 'A model to open the talk without blame';
  @override
  String get repairTitle => 'Repair';
  @override
  String get repairText => 'See how it is and choose a step';
  @override
  String get talkTitle => 'Prepare what to say';
  @override
  String get talkText => 'Sort your thoughts before you talk';
  @override
  String get note => 'Works offline and stays only with you.';
  @override
  String get action => 'We are fighting';
}

// Path: slipDetail.visibility
class _Translations$slipDetail$visibility$en extends Translations$slipDetail$visibility$pt {
  _Translations$slipDetail$visibility$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Who sees this slip?';
  @override
  String get subtitle => 'Private is the default.';
  @override
  String get onlyMe => 'Only me';
  @override
  String get onlyMeText => 'Stays in your week';
  @override
  String get weeklyCard => 'Put it in my weekly card';
  @override
  String get sendNow => 'Send now';
  @override
  String get done => 'Done';
  @override
  String get sentToast => 'Slip sent';
  @override
  String get heldToast =>
      'The wording sounds harsh, so the card was held. Rewrite it and try again.';
  @override
  String get notSentToast => 'It was not sent. Check that you two are connected.';
}

// Path: slipKind.specific
class _Translations$slipKind$specific$en extends Translations$slipKind$specific$pt {
  _Translations$slipKind$specific$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'What exactly did they do?';
  @override
  String get titleHighlight => 'exactly';
  @override
  String get subtitle => 'Details help you remember why it mattered.';
  @override
  String get hint => 'E.g. took out the trash without being asked';
  @override
  String get feelingLabel => 'How did you feel?';
  @override
  String get feelingHint => 'Optional';
}

// Path: slipKind.ifThen
class _Translations$slipKind$ifThen$en extends Translations$slipKind$ifThen$pt {
  _Translations$slipKind$ifThen$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Want to tell them?';
  @override
  String get titleHighlight => 'tell';
  @override
  String get subtitle => 'A small plan: when this happens, you do that.';
  @override
  String get ifLabel => 'If…';
  @override
  String get ifHint => 'E.g. I feel overwhelmed';
  @override
  String get thenLabel => 'Then…';
  @override
  String get thenHint => 'E.g. I ask for 10 minutes alone';
}

// Path: slipKind.invisible
class _Translations$slipKind$invisible$en extends Translations$slipKind$invisible$pt {
  _Translations$slipKind$invisible$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Things nobody notices';
  @override
  String get titleHighlight => 'nobody notices';
  @override
  String get subtitle => 'Name the work nobody sees.';
  @override
  String get hint => 'E.g. remembered the kids\' appointment';
  @override
  String get areaLabel => 'What kind of work?';
  @override
  String get private => 'Stays with you and never enters a card.';
}

// Path: slipKind.saved
class _Translations$slipKind$saved$en extends Translations$slipKind$saved$pt {
  _Translations$slipKind$saved$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Saved';
  @override
  String get added => 'Written down.';
  @override
  String get queued => 'Saved on this phone. We\'ll send it when the connection is back.';
  @override
  String get done => 'Done';
}

// Path: spice.home
class _Translations$spice$home$en extends Translations$spice$home$pt {
  _Translations$spice$home$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get subtitle => 'Everything here is optional and stays between you.';
  @override
  String get cards => 'Evening cards';
  @override
  String get cardsText => 'One card at a time';
  @override
  String get desires => 'Desires';
  @override
  String get desiresText => 'Answer in secret and see what you both want';
  @override
  String get challenge => 'Challenge of the week';
  @override
  String get challengeText => 'An invitation, with no points or deadline';
  @override
  String get settings => 'Settings';
  @override
  String get settingsText => 'Your limit and the alerts';
}

// Path: spice.cards
class _Translations$spice$cards$en extends Translations$spice$cards$pt {
  _Translations$spice$cards$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Evening cards';
  @override
  Map<String, String> get errors => {
    'FREE_LIMIT_REACHED': 'You used this week\'s free cards. Plus unlocks more.',
    'PLUS_REQUIRED': 'This is part of Plus.',
    'ADULT_REQUIRED': 'Confirm you are 18 or older.',
    'SPICE_NOT_ON': 'Tempero is not on for both of you.',
    'SWAP_LIMIT': 'You already swapped the challenge three times this week.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not finish that now. Try again.',
  };
  @override
  String get answeredTitle => 'Agreed';
  @override
  String get answeredText => 'Whenever you like, there is another card.';
  @override
  String get next => 'Another card';
  @override
  String get emptyTitle => 'No more cards';
  @override
  String get emptyText => 'There are no more cards at this level for now.';
  @override
  String get mineHint => 'You proposed this card. The other person answers when they like.';
  @override
  String get theirsHint => 'The other person proposed this card. You choose.';
  @override
  String get refresh => 'Check if they answered';
  @override
  String get accept => 'I want to';
  @override
  String get notToday => 'Not today';
}

// Path: spice.desires
class _Translations$spice$desires$en extends Translations$spice$desires$pt {
  _Translations$spice$desires$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Desires';
  @override
  Map<String, String> get errors => {
    'FREE_LIMIT_REACHED': 'You used this week\'s free cards. Plus unlocks more.',
    'PLUS_REQUIRED': 'This is part of Plus.',
    'ADULT_REQUIRED': 'Confirm you are 18 or older.',
    'SPICE_NOT_ON': 'Tempero is not on for both of you.',
    'SWAP_LIMIT': 'You already swapped the challenge three times this week.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not finish that now. Try again.',
  };
  @override
  String get subtitle =>
      'Only you see what you answer. If you both want it, it shows in "You both want".';
  @override
  String get emptyTitle => 'Nothing here yet';
  @override
  String get emptyText => 'When there are desires at this level, they show up here.';
  @override
  String get matchesTitle => 'You both want';
  @override
  String get matchesEmpty => 'Nothing in common yet. No rush.';
  @override
  Map<String, String> get answers => {
    'want': 'I want',
    'maybe': 'Maybe',
    'notToday': 'Not today',
    'other': '',
  };
}

// Path: spice.challenge
class _Translations$spice$challenge$en extends Translations$spice$challenge$pt {
  _Translations$spice$challenge$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Challenge of the week';
  @override
  Map<String, String> get errors => {
    'FREE_LIMIT_REACHED': 'You used this week\'s free cards. Plus unlocks more.',
    'PLUS_REQUIRED': 'This is part of Plus.',
    'ADULT_REQUIRED': 'Confirm you are 18 or older.',
    'SPICE_NOT_ON': 'Tempero is not on for both of you.',
    'SWAP_LIMIT': 'You already swapped the challenge three times this week.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not finish that now. Try again.',
  };
  @override
  String get emptyTitle => 'No challenge now';
  @override
  String get emptyText => 'Come back next week.';
  @override
  String get subtitle => 'An invitation for you two. No points and no deadline.';
  @override
  String get statusDone => 'You did it. Thank you for caring for this.';
  @override
  String get statusBothAccepted => 'You both said yes.';
  @override
  String get statusWaitingPartner => 'You said yes. Waiting for the other person.';
  @override
  String get statusPartnerAccepted => 'The other person said yes.';
  @override
  String get statusNew => 'Nobody answered yet.';
  @override
  String get accept => 'I am in';
  @override
  String get done => 'We did it';
  @override
  String get swap => 'Swap the challenge';
}

// Path: spice.settingsPage
class _Translations$spice$settingsPage$en extends Translations$spice$settingsPage$pt {
  _Translations$spice$settingsPage$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Tempero settings';
  @override
  Map<String, String> get errors => {
    'FREE_LIMIT_REACHED': 'You used this week\'s free cards. Plus unlocks more.',
    'PLUS_REQUIRED': 'This is part of Plus.',
    'ADULT_REQUIRED': 'Confirm you are 18 or older.',
    'SPICE_NOT_ON': 'Tempero is not on for both of you.',
    'SWAP_LIMIT': 'You already swapped the challenge three times this week.',
    'RATE_LIMITED': 'Too many tries in a row. Wait a moment.',
    'other': 'We could not finish that now. Try again.',
  };
  @override
  String get levelTitle => 'How far to go';
  @override
  Map<String, String> get levels => {'soft': 'Soft', 'warm': 'Warm', 'hot': 'Spicy', 'other': ''};
  @override
  String get levelNote =>
      'The gentler of the two limits applies. The other person does not see yours.';
  @override
  String get notifications => 'Tempero alerts';
  @override
  String get notificationsText => 'A short alert that says nothing about the content.';
  @override
  String get turnOff => 'Turn off Tempero';
  @override
  String get turnOffTitle => 'Turn off Tempero?';
  @override
  String get turnOffText =>
      'It turns off for both of you and erases answers, cards and challenges. This cannot be undone.';
  @override
  String get turnOffConfirm => 'Turn off';
}

// Path: sundayCard.send
class _Translations$sundayCard$send$en extends Translations$sundayCard$send$pt {
  _Translations$sundayCard$send$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get action => 'Send';
  @override
  String get invite => 'Invite to send';
  @override
  String get needsPartner => 'To send the card in the app, your person has to be connected.';
  @override
  String get title => 'Send the card?';
  @override
  String text({required Object name}) =>
      '${name} receives it now. Once sent, the card does not change.';
  @override
  String get textNoName => 'Your person receives it now. Once sent, the card does not change.';
  @override
  String get confirm => 'Send';
}

// Path: sundayCard.hold
class _Translations$sundayCard$hold$en extends Translations$sundayCard$hold$pt {
  _Translations$sundayCard$hold$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get action => 'Hold this week';
  @override
  String get title => 'Hold this week?';
  @override
  String get text => 'The card is kept and nothing is lost. You can send it whenever you like.';
  @override
  String get confirm => 'Hold';
}

// Path: sundayCard.held
class _Translations$sundayCard$held$en extends Translations$sundayCard$held$pt {
  _Translations$sundayCard$held$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Held this week';
  @override
  String get titleHighlight => 'Held';
  @override
  String get text => 'Your card waits. Send it when you are ready. Nothing is lost.';
  @override
  String get keepHolding => 'Keep holding';
  @override
  String get sendAnyway => 'Send anyway';
}

// Path: sundayCard.sent
class _Translations$sundayCard$sent$en extends Translations$sundayCard$sent$pt {
  _Translations$sundayCard$sent$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sent';
  @override
  String text({required Object name}) => 'The card went to ${name}.';
  @override
  String get textNoName => 'The card went to your person.';
  @override
  String get done => 'Done';
}

// Path: sundayCard.heldByRule
class _Translations$sundayCard$heldByRule$en extends Translations$sundayCard$heldByRule$pt {
  _Translations$sundayCard$heldByRule$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Worth rereading before you send';
  @override
  String get titleHighlight => 'rereading';
  @override
  Map<String, String> get reasons => {
    'absolute': 'Words like “always” and “never” can sound like an accusation.',
    'insult': 'A word on the card may hurt.',
    'blame': 'The text sounds like blame instead of thanks.',
    'contempt': 'The text may sound like contempt.',
    'other': 'The text may sound harsher than you mean.',
  };
  @override
  String get reassurance => 'Nothing was sent and nothing is lost.';
  @override
  String get rewrite => 'Rewrite';
  @override
  String get sendAnyway => 'Send anyway';
}

// Path: temperature.result
class _Translations$temperature$result$en extends Translations$temperature$result$pt {
  _Translations$temperature$result$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$temperature$result$good$en good =
      _Translations$temperature$result$good$en._(_root);
  @override
  late final _Translations$temperature$result$pause$en pause =
      _Translations$temperature$result$pause$en._(_root);
  @override
  late final _Translations$temperature$result$guided$en guided =
      _Translations$temperature$result$guided$en._(_root);
  @override
  late final _Translations$temperature$result$quick$en quick =
      _Translations$temperature$result$quick$en._(_root);
  @override
  String get done => 'Done';
}

// Path: temperature.history
class _Translations$temperature$history$en extends Translations$temperature$history$pt {
  _Translations$temperature$history$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get action => 'See the last weeks';
  @override
  String get title => 'Last 8 weeks';
  @override
  String get titleHighlight => '8 weeks';
  @override
  String get subtitle => 'One point per week, with the last answer given in it.';
  @override
  String get chartLabel => 'Temperature of each week, from calmest to a fight';
  @override
  String get emptyTitle => 'Nothing here yet';
  @override
  String get emptyText => 'When you answer how things are between you, the weeks show up here.';
  @override
  String get note =>
      'Only you see this. It never becomes a note and never goes to the other person.';
}

// Path: today.conflict
class _Translations$today$conflict$en extends Translations$today$conflict$pt {
  _Translations$today$conflict$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get tag => 'Now';
  @override
  String get title => 'First, take care of you two';
  @override
  String get highlight => 'care';
  @override
  String get text => 'No common cards for now. Start with a repair or sort out what to say.';
  @override
  String get repair => 'Start the repair';
  @override
  String get chat => 'Talk to get organized';
}

// Path: unpair.done
class _Translations$unpair$done$en extends Translations$unpair$done$pt {
  _Translations$unpair$done$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Unpaired';
  @override
  String get highlight => 'Unpaired';
  @override
  String get text => 'Your own data stays yours.';
  @override
  String get keepOption => 'Keep a copy of the shared items';
  @override
  String get deleteOption => 'Delete shared items';
  @override
  String get plusNote => 'The Plus that covered your partner ends.';
  @override
  String get continueLabel => 'Continue';
}

// Path: unpair.relationship
class _Translations$unpair$relationship$en extends Translations$unpair$relationship$pt {
  _Translations$unpair$relationship$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Relationship';
  @override
  String unpair({required Object name}) => 'Unpair from ${name}';
  @override
  String get ended => 'The relationship ended';
}

// Path: unpair.breakup
class _Translations$unpair$breakup$en extends Translations$unpair$breakup$pt {
  _Translations$unpair$breakup$en._(TranslationsEn root) : this._root = root, super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get appBarTitle => 'We broke up';
  @override
  String get title => 'I am sorry';
  @override
  String get highlight => 'sorry';
  @override
  String get text => 'You decide what to keep. Nothing is deleted without you wanting it.';
  @override
  String get cancel => 'Cancel';
  @override
  String get continueLabel => 'Continue';
}

// Path: unpair.partnerNotice
class _Translations$unpair$partnerNotice$en extends Translations$unpair$partnerNotice$pt {
  _Translations$unpair$partnerNotice$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object name}) => '${name} unpaired';
  @override
  String get titleNoName => 'Your partner unpaired';
  @override
  String get highlight => 'unpaired';
  @override
  String get text => 'Your data stays yours. Shared cards stopped.';
  @override
  String get ok => 'Ok';
}

// Path: games.kinds.meOrYou
class _Translations$games$kinds$meOrYou$en extends Translations$games$kinds$meOrYou$pt {
  _Translations$games$kinds$meOrYou$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Me or you';
  @override
  String get intro => 'Answer separately who fits each phrase better. Then see where you agreed.';
}

// Path: games.kinds.howWell
class _Translations$games$kinds$howWell$en extends Translations$games$kinds$howWell$pt {
  _Translations$games$kinds$howWell$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'How well you know me';
  @override
  String get intro =>
      'Each of you answers about yourself and guesses the other\'s answer. Then comes the conversation.';
}

// Path: games.kinds.twentyQuestions
class _Translations$games$kinds$twentyQuestions$en
    extends Translations$games$kinds$twentyQuestions$pt {
  _Translations$games$kinds$twentyQuestions$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => '20 questions';
  @override
  String get intro => 'Light questions to answer in private and reveal together.';
}

// Path: games.kinds.neverHaveWe
class _Translations$games$kinds$neverHaveWe$en extends Translations$games$kinds$neverHaveWe$pt {
  _Translations$games$kinds$neverHaveWe$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Never have we';
  @override
  String get intro =>
      'Things you have never done together. Each of you answers in private and you see both sides at the end.';
}

// Path: games.kinds.mission
class _Translations$games$kinds$mission$en extends Translations$games$kinds$mission$pt {
  _Translations$games$kinds$mission$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Date mission';
  @override
  String get intro => 'A date idea to do together and a short reflection afterwards.';
}

// Path: repair.guided.done
class _Translations$repair$guided$done$en extends Translations$repair$guided$done$pt {
  _Translations$repair$guided$done$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Repair done';
  @override
  String get highlight => 'done';
  @override
  String get text =>
      'Taking care of this is already a step. If you want, keep what you learned, just for you.';
  @override
  String get learn => 'Keep what I learned';
  @override
  String get close => 'Not now';
}

// Path: temperature.result.good
class _Translations$temperature$result$good$en extends Translations$temperature$result$good$pt {
  _Translations$temperature$result$good$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'That\'s good';
  @override
  String get text => 'Saved just for you. Carry on with your day.';
}

// Path: temperature.result.pause
class _Translations$temperature$result$pause$en extends Translations$temperature$result$pause$pt {
  _Translations$temperature$result$pause$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'First, breathe';
  @override
  String get text =>
      'When it\'s very hot, waiting helps. Some time apart is worth it before any conversation.';
}

// Path: temperature.result.guided
class _Translations$temperature$result$guided$en extends Translations$temperature$result$guided$pt {
  _Translations$temperature$result$guided$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'You can talk with care';
  @override
  String get text => 'One step at a time, at your pace.';
}

// Path: temperature.result.quick
class _Translations$temperature$result$quick$en extends Translations$temperature$result$quick$pt {
  _Translations$temperature$result$quick$en._(TranslationsEn root)
    : this._root = root,
      super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'A small fix is enough';
  @override
  String get text => 'Something light and quick can do it.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'acceptInvite.title' => 'Got an invite?',
          'acceptInvite.titleHighlight' => 'invite',
          'acceptInvite.connectTitle' => 'Connect with a code',
          'acceptInvite.subtitle' => 'Type the code the other person sent so you can connect.',
          'acceptInvite.codeLabel' => 'Invite code',
          'acceptInvite.codeHint' => 'E.g. ABCD2345',
          'acceptInvite.codeErrors.empty' => 'Type the invite code.',
          'acceptInvite.codeErrors.tooShort' => 'The code has 8 characters.',
          'acceptInvite.codeErrors.tooLong' => 'The code has 8 characters.',
          'acceptInvite.codeErrors.invalid' => 'Use letters and numbers only.',
          'acceptInvite.privacyNote' =>
            'Accepting shares cards and tools. Your private notes stay private.',
          'acceptInvite.accept' => 'Accept',
          'acceptInvite.connected.title' => 'You are connected',
          'acceptInvite.connected.titleHighlight' => 'connected',
          'acceptInvite.connected.text' =>
            'Shared cards and tools are on. Everything private stays private.',
          'acceptInvite.connected.goToToday' => 'Go to Today',
          'acceptInvite.unusable.title' => 'That invite is old',
          'acceptInvite.unusable.titleHighlight' => 'old',
          'acceptInvite.unusable.text' =>
            'Check the code or ask for a new invite from whoever invited you.',
          'acceptInvite.unusable.tryAgain' => 'Type again',
          'acceptInvite.unusable.close' => 'Close',
          'acceptInvite.ownCodeTitle' => 'That code is yours',
          'acceptInvite.ownCodeHighlight' => 'yours',
          'acceptInvite.ownCodeText' =>
            'That is your own code. To connect, use your partner\'s code.',
          'acceptInvite.errors.ALREADY_PAIRED' => 'You are already connected with someone.',
          'acceptInvite.errors.COUPLE_FULL' => 'That space already has two people.',
          'acceptInvite.errors.RATE_LIMITED' =>
            'Too many tries in a row. Wait a bit and try again.',
          'acceptInvite.errors.NETWORK' => 'No connection. Check your internet and try again.',
          'acceptInvite.errors.other' => 'Could not connect right now. Try again.',
          'acceptInvite.headline' => ({required Object name}) => 'Connect with ${name}',
          'acceptInvite.headlineNoName' => 'Connect with your person',
          'acceptInvite.headlineNoNameHighlight' => 'your person',
          'acceptInvite.pageSubtitle' =>
            'Both already use the app? One invites and the other types the code.',
          'acceptInvite.segmentHaveCode' => 'I have a code',
          'acceptInvite.segmentInvite' => 'I want to invite',
          'acceptInvite.connectAction' => 'Connect',
          'acceptInvite.ownCodeLabel' => 'Your invite code',
          'acceptInvite.ownCodeNote' =>
            'Send this code to your person. What each of you has written so far stays private.',
          'account.deleteTitle' => 'Delete account',
          'account.deleteHighlight' => 'account',
          'account.deleteText' => 'Your data is erased after 30 days. This needs a fresh sign-in.',
          'account.deleteWarningTitle' => 'This also ends the link',
          'account.deleteWarning' => ({
            required Object name,
          }) => 'This also ends the link with ${name}.',
          'account.deleteWarningNoPartner' => 'This also ends the link with your partner.',
          'account.deleteAction' => 'Delete account',
          'account.deleteConfirmTitle' => 'Delete your account?',
          'account.deleteConfirmText' =>
            'You have 30 days to change your mind. After that, nothing can be recovered.',
          'account.reauthReason' => 'Confirm to delete your account.',
          'account.pendingTitle' => ({
            required Object month,
            required Object day,
          }) => 'Deletion on ${month} ${day}',
          'account.pendingHighlight' => ({
            required Object month,
            required Object day,
          }) => '${month} ${day}',
          'account.pendingText' => 'You can cancel before that.',
          'account.pendingCancel' => 'Cancel deletion',
          'account.signOutTitle' => 'Sign out?',
          'account.signOutText' => 'Remove the local data too?',
          'account.signOutPending' => ({
            required Object count,
          }) => 'You have ${count} slips that were not sent yet. Signing out and removing data erases them.',
          'account.signOut' => 'Sign out',
          'account.signOutRemove' => 'Sign out and remove data',
          'account.months.0' => 'Jan',
          'account.months.1' => 'Feb',
          'account.months.2' => 'Mar',
          'account.months.3' => 'Apr',
          'account.months.4' => 'May',
          'account.months.5' => 'Jun',
          'account.months.6' => 'Jul',
          'account.months.7' => 'Aug',
          'account.months.8' => 'Sep',
          'account.months.9' => 'Oct',
          'account.months.10' => 'Nov',
          'account.months.11' => 'Dec',
          'account.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'account.errors.other' => 'Could not finish now. Try again.',
          'account.export.appBarTitle' => 'Export my data',
          'account.export.title' => 'Take your data with you',
          'account.export.titleHighlight' => 'your data',
          'account.export.text' => 'We build a file with only what is yours: slips, notes and answers. Nothing from the other person goes in it.',
          'account.export.note' => 'The link lasts a few minutes. You can build one file a day.',
          'account.export.action' => 'Build the file',
          'account.export.again' => 'Build again',
          'account.export.beforeDelete' => 'Export before deleting',
          'account.export.openFailed' => 'We could not open the file. Try building it again.',
          'account.export.errors.EXPORT_LIMIT' =>
            'You already built a file today. Try again tomorrow.',
          'account.export.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'account.export.errors.other' => 'We could not build the file now. Try again.',
          'agreements.title' => 'Agreements',
          'agreements.add' => 'New agreement',
          'agreements.addTitle' => 'New agreement',
          'agreements.bodyLabel' => 'What you agree on',
          'agreements.bodyHint' => 'E.g. Talk about money once a month',
          'agreements.bodyErrors.empty' => 'Write the agreement.',
          'agreements.bodyErrors.tooLong' => 'Use 200 characters at most.',
          'agreements.propose' => 'Propose',
          'agreements.confirm' => 'Confirm',
          'agreements.options' => 'Agreement options',
          'agreements.subtitleShared' =>
            'Short sentences you agree on. They only count once the other person confirms.',
          'agreements.subtitlePrivate' =>
            'Notes for yourself. When someone joins you they become agreements.',
          'agreements.emptyTitle' => 'No agreements yet',
          'agreements.emptyTextShared' =>
            'Agree on something small and ask the other person to confirm.',
          'agreements.emptyTextPrivate' => 'Note something you would like to agree on.',
          'agreements.statusPrivate' => 'Only you see it',
          'agreements.statusConfirmed' => 'Confirmed by both',
          'agreements.statusWaitingPartner' => 'Waiting for the other person',
          'agreements.statusWaitingYou' => 'Waiting for you',
          'agreements.archiveTitle' => 'Put this agreement away?',
          'agreements.archiveTextShared' => 'It leaves the list for both of you.',
          'agreements.archiveTextPrivate' => 'It leaves your list.',
          'agreements.archiveConfirm' => 'Put away',
          'agreements.metaShared' => 'What you agreed on',
          'agreements.metaPrivate' => 'Notes for yourself',
          'agreements.errors.FREE_LIMIT_REACHED' =>
            'You reached the free plan limit of agreements. Put one away or see Plus.',
          'agreements.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'agreements.errors.other' => 'We could not finish that now. Try again.',
          'annoyanceCheck.title' => 'Does this still bother you?',
          'annoyanceCheck.titleHighlight' => 'bother',
          'annoyanceCheck.age' => ({
            required Object days,
            required Object left,
          }) => 'You wrote it ${days} days ago · gone in ${left} days',
          'annoyanceCheck.talkTitle' => 'Talk about it',
          'annoyanceCheck.talkText' => 'Write a gentle request',
          'annoyanceCheck.chatTitle' => 'Talk to the chat',
          'annoyanceCheck.chatText' => 'Only you and the chat',
          'annoyanceCheck.letGoTitle' => 'Let it go',
          'annoyanceCheck.letGoText' => 'Delete now, without telling anyone',
          'annoyanceCheck.note' =>
            'Good things stay forever. What bothered you goes away on its own if you do nothing.',
          'annoyanceCheck.letGoConfirmTitle' => 'Let it go?',
          'annoyanceCheck.letGoConfirmText' => 'The note is deleted now and nobody is told.',
          'annoyanceCheck.letGoConfirm' => 'Delete now',
          'annoyanceCheck.letGoDone' => 'Note deleted',
          'annoyanceCheck.goneTitle' => 'That note is gone',
          'annoyanceCheck.goneText' => 'It expired, was deleted or became a request.',
          'annoyanceCheck.close' => 'Close',
          'annoyanceCheck.errorTitle' => 'We could not open the note',
          'annoyanceCheck.errors.NETWORK' => 'No connection. Try again.',
          'annoyanceCheck.errors.other' => 'Something went wrong. Try again.',
          'authentication.signInTitle' => 'Sign in',
          'authentication.signInSubtitle' => 'No email and password. Just Apple or Google.',
          'authentication.signInNote' => 'Signing in takes you straight to your Today.',
          'authentication.emailSignInFallback' => 'Sign in with email and password',
          'authentication.existingAccountTitle' => 'You already have an account',
          'authentication.existingAccountSubtitle' => 'Sign in to pick up where you left off.',
          'authentication.continueWithApple' => 'Continue with Apple',
          'authentication.continueWithGoogle' => 'Continue with Google',
          'authentication.errors.NETWORK' => 'No connection. Check your internet and try again.',
          'authentication.errors.anonymous_provider_disabled' =>
            'Signing in without an account is off right now.',
          'authentication.errors.bad_code_verifier' => 'Sign in again to continue.',
          'authentication.errors.bad_json' => 'Something went wrong. Try again.',
          'authentication.errors.bad_jwt' => 'Your session ended. Sign in again.',
          'authentication.errors.bad_oauth_callback' => 'Sign in again to continue.',
          'authentication.errors.bad_oauth_state' => 'Sign in again to continue.',
          'authentication.errors.captcha_failed' =>
            'We could not confirm you are human. Try again.',
          'authentication.errors.conflict' => 'That did not go through. Try again.',
          'authentication.errors.email_address_invalid' => 'That email address is not valid.',
          'authentication.errors.email_address_not_authorized' =>
            'We cannot send email to that address yet.',
          'authentication.errors.email_conflict_identity_not_deletable' =>
            'This is your only way to sign in, so it cannot be removed.',
          'authentication.errors.email_exists' => 'This email already has an account.',
          'authentication.errors.email_not_confirmed' => 'Confirm your email before signing in.',
          'authentication.errors.email_provider_disabled' =>
            'New email accounts are closed right now.',
          'authentication.errors.flow_state_expired' => 'Sign in again to continue.',
          'authentication.errors.flow_state_not_found' => 'Sign in again to continue.',
          'authentication.errors.hook_payload_invalid_content_type' =>
            'Something went wrong. Try again.',
          'authentication.errors.hook_payload_over_size_limit' =>
            'Something went wrong. Try again.',
          'authentication.errors.hook_timeout' => 'That took too long. Try again.',
          'authentication.errors.hook_timeout_after_retry' => 'That took too long. Try again.',
          'authentication.errors.identity_already_exists' => 'This account is already linked.',
          'authentication.errors.identity_not_found' => 'That sign-in method is no longer linked.',
          'authentication.errors.insufficient_aal' => 'Finish the extra security step first.',
          'authentication.errors.invalid_credentials' => 'Email or password is incorrect.',
          'authentication.errors.invite_not_found' => 'This invite expired or was already used.',
          'authentication.errors.manual_linking_disabled' => 'Linking accounts is off right now.',
          'authentication.errors.mfa_challenge_expired' => 'That check expired. Try again.',
          'authentication.errors.mfa_factor_name_conflict' =>
            'You already have a security key with that name.',
          'authentication.errors.mfa_factor_not_found' => 'That security key is no longer set up.',
          'authentication.errors.mfa_ip_address_mismatch' =>
            'Start and finish setup on the same connection.',
          'authentication.errors.mfa_phone_enroll_not_enabled' =>
            'Phone verification is off right now.',
          'authentication.errors.mfa_phone_verify_not_enabled' =>
            'Phone verification is off right now.',
          'authentication.errors.mfa_totp_enroll_not_enabled' =>
            'Authenticator codes are off right now.',
          'authentication.errors.mfa_totp_verify_not_enabled' =>
            'Authenticator codes are off right now.',
          'authentication.errors.mfa_verification_failed' => 'That code is not right. Try again.',
          'authentication.errors.mfa_verification_rejected' =>
            'We could not verify that. Try again later.',
          'authentication.errors.mfa_verified_factor_exists' =>
            'This phone is already set up for verification.',
          'authentication.errors.mfa_web_authn_enroll_not_enabled' =>
            'Passkey setup is off right now.',
          'authentication.errors.mfa_web_authn_verify_not_enabled' => 'Passkeys are off right now.',
          'authentication.errors.no_authorization' => 'Your session ended. Sign in again.',
          'authentication.errors.oauth_provider_not_supported' =>
            'That sign-in option is not available.',
          'authentication.errors.otp_disabled' => 'Sign-in codes are off right now.',
          'authentication.errors.otp_expired' => 'That code expired. Ask for a new one.',
          'authentication.errors.over_email_send_rate_limit' =>
            'Too many emails sent. Wait a bit and try again.',
          'authentication.errors.over_request_rate_limit' =>
            'Too many tries in a row. Wait a moment and try again.',
          'authentication.errors.over_sms_send_rate_limit' =>
            'Too many texts sent. Wait a bit and try again.',
          'authentication.errors.phone_exists' => 'This phone number already has an account.',
          'authentication.errors.phone_not_confirmed' =>
            'Confirm your phone number before signing in.',
          'authentication.errors.phone_provider_disabled' =>
            'New phone accounts are closed right now.',
          'authentication.errors.provider_disabled' => 'That sign-in option is not available.',
          'authentication.errors.provider_email_needs_verification' =>
            'Check your email to finish signing in.',
          'authentication.errors.reauthentication_needed' => 'Sign in again to continue.',
          'authentication.errors.reauthentication_not_valid' =>
            'That code is not right. Try again.',
          'authentication.errors.refresh_token_already_used' =>
            'Your session ended. Sign in again.',
          'authentication.errors.refresh_token_not_found' => 'Your session ended. Sign in again.',
          'authentication.errors.request_timeout' => 'That took too long. Try again.',
          'authentication.errors.same_password' => 'Choose a password you have not used here.',
          'authentication.errors.saml_assertion_no_email' =>
            'Your organization did not share an email. Contact them.',
          'authentication.errors.saml_assertion_no_user_id' =>
            'Your organization did not share an ID. Contact them.',
          'authentication.errors.saml_idp_not_found' =>
            'Your organization\'s sign-in is not set up.',
          'authentication.errors.saml_provider_disabled' =>
            'Organization sign-in is off right now.',
          'authentication.errors.saml_relay_state_expired' => 'Sign in again to continue.',
          'authentication.errors.saml_relay_state_not_found' => 'Sign in again to continue.',
          'authentication.errors.session_expired' => 'Your session ended. Sign in again.',
          'authentication.errors.session_not_found' => 'Your session ended. Sign in again.',
          'authentication.errors.signup_disabled' => 'New accounts are closed right now.',
          'authentication.errors.single_identity_not_deletable' =>
            'This is your only way to sign in, so it cannot be removed.',
          'authentication.errors.sms_send_failed' => 'We could not send the text. Try again.',
          'authentication.errors.sso_provider_not_found' =>
            'Your organization\'s sign-in is not set up.',
          'authentication.errors.too_many_enrolled_mfa_factors' =>
            'You have reached the limit of security keys.',
          'authentication.errors.unexpected_failure' => 'Something went wrong. Try again.',
          'authentication.errors.user_already_exists' => 'This account already exists.',
          'authentication.errors.user_banned' => 'This account is not available right now.',
          'authentication.errors.user_not_found' => 'We could not find that account.',
          'authentication.errors.user_sso_managed' => 'Your organization manages this account.',
          'authentication.errors.validation_failed' => 'Check the information and try again.',
          'authentication.errors.weak_password' => 'Choose a stronger password.',
          'authentication.errors.other' => 'Could not sign you in right now. Try again.',
          'authentication.legal' => ({
            required Object terms,
            required Object privacy,
          }) => 'By continuing, you confirm you are 18 or older and agree to the ${terms} and the ${privacy}.',
          'authentication.legalTerms' => 'Terms',
          'authentication.legalPrivacy' => 'Privacy Policy',
          'authentication.legalPlain' => 'By continuing, you confirm you are 18 or older and agree to the Terms and the Privacy Policy.',
          'authentication.tryAgain' => 'Try again',
          'capsules.title' => 'Time capsule',
          'capsules.text' => 'Write something to be opened on a future date. Until then nobody reads it, not even you.',
          'capsules.bodyHint' => 'What do you want to say to the future?',
          'capsules.bodyErrors.empty' => 'Write the message',
          'capsules.bodyErrors.tooLong' => 'The message is too long',
          'capsules.dateLabel' => 'Opens on',
          'capsules.dateHint' => 'Pick a date',
          'capsules.dateErrors.empty' => 'Pick the day it opens',
          'capsules.dateErrors.outOfRange' => 'Pick a date between a week and 50 years ahead',
          'capsules.dateFormat' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'capsules.months.0' => 'January',
          'capsules.months.1' => 'February',
          'capsules.months.2' => 'March',
          'capsules.months.3' => 'April',
          'capsules.months.4' => 'May',
          'capsules.months.5' => 'June',
          'capsules.months.6' => 'July',
          'capsules.months.7' => 'August',
          'capsules.months.8' => 'September',
          'capsules.months.9' => 'October',
          'capsules.months.10' => 'November',
          'capsules.months.11' => 'December',
          'capsules.sharedLabel' => 'For both of us',
          'capsules.sharedText' =>
            'Your partner reads it too when the date comes. Off, only you read it.',
          'capsules.save' => 'Save capsule',
          'capsules.saved' => 'Capsule saved',
          'capsules.closedUntil' => ({required Object date}) => 'Closed until ${date}',
          'capsules.ownerSharedBy' => 'Yours, for both',
          'capsules.ownerPrivate' => 'Only yours',
          'capsules.fromPartner' => 'From your partner',
          'capsules.delete' => 'Delete',
          'capsules.deleteTitle' => 'Delete this capsule?',
          'capsules.deleteText' => 'It will be gone before anyone reads it. This cannot be undone.',
          'capsules.deleteConfirm' => 'Delete',
          'capsules.emptyTitle' => 'No capsules yet',
          'capsules.emptyText' => 'Write one and choose the day it opens.',
          'capsules.errorTitle' => 'Couldn\'t load',
          'capsules.errorText' => 'Your capsules are still saved. Try again.',
          'capsules.errors.CAPSULE_OPENS_TOO_SOON' => 'Pick a date at least a week ahead.',
          'capsules.errors.CAPSULE_OPENS_TOO_FAR' => 'Pick a date within the next 50 years.',
          'capsules.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'capsules.errors.other' => 'Couldn\'t save right now. Your text is still here.',
          'capsules.deleteErrors.other' => 'Couldn\'t delete this capsule. It\'s still here.',
          'cardSettings.title' => 'Weekly card',
          'cardSettings.day' => 'Day',
          'cardSettings.hour' => 'Time',
          'cardSettings.defaultTitle' => 'New slips go on the card',
          'cardSettings.defaultSubtitle' => 'Each slip can change this later.',
          'cardSettings.note' => 'Changes apply to the next card.',
          'cardSettings.saveError' => 'Could not save. Your earlier choice was kept.',
          'cardSettings.errorTitle' => 'We could not open the settings',
          'cardSettings.errors.NETWORK' => 'No connection. Try again.',
          'cardSettings.errors.other' => 'Your choices are still saved. Try again.',
          'cardSettings.open' => 'Card settings',
          'cardView.forPartner' => ({required Object name}) => 'For ${name}',
          'cardView.forPartnerNoName' => 'For your person',
          'cardView.goodThings' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  zero: 'No good things yet',
                  one: '1 good thing this week',
                  other: '${count} good things this week',
                ),
          'cardView.weekdays.0' => 'mon',
          'cardView.weekdays.1' => 'tue',
          'cardView.weekdays.2' => 'wed',
          'cardView.weekdays.3' => 'thu',
          'cardView.weekdays.4' => 'fri',
          'cardView.weekdays.5' => 'sat',
          'cardView.weekdays.6' => 'sun',
          'cardView.categories.said' => 'said something',
          'cardView.categories.did' => 'did something',
          'cardView.categories.noticed' => 'noticed me',
          'cardView.categories.helped' => 'helped me',
          'cardView.categories.other' => '',
          'cardsList.title' => 'Past cards',
          'cardsList.dateShort' => ({
            required Object month,
            required Object day,
          }) => '${month} ${day}',
          'cardsList.monthsShort.0' => 'Jan',
          'cardsList.monthsShort.1' => 'Feb',
          'cardsList.monthsShort.2' => 'Mar',
          'cardsList.monthsShort.3' => 'Apr',
          'cardsList.monthsShort.4' => 'May',
          'cardsList.monthsShort.5' => 'Jun',
          'cardsList.monthsShort.6' => 'Jul',
          'cardsList.monthsShort.7' => 'Aug',
          'cardsList.monthsShort.8' => 'Sep',
          'cardsList.monthsShort.9' => 'Oct',
          'cardsList.monthsShort.10' => 'Nov',
          'cardsList.monthsShort.11' => 'Dec',
          'cardsList.slipCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  zero: 'no slips',
                  one: '1 slip',
                  other: '${count} slips',
                ),
          'cardsList.sent' => 'Sent',
          'cardsList.received' => 'Received',
          'cardsList.opened' => 'opened',
          'cardsList.reacted' => 'reaction',
          'cardsList.replied' => 'replied',
          'cardsList.emptyTitle' => 'No cards yet',
          'cardsList.emptyText' => 'When a card is sent or arrives, it shows up here. No rush.',
          'cardsList.errorTitle' => 'Could not load the cards',
          'cardsList.errorText' => 'They are still saved. Try again.',
          'cardsList.detailTitle' => 'Card',
          'cardsList.detailErrorTitle' => 'Could not open the card',
          'cardsList.errors.CARD_NOT_FOUND' => 'That card is no longer available.',
          'cardsList.errors.other' => 'It is still saved. Try again.',
          'cardsList.reactionPrompt' => 'How do you want to reply?',
          'cardsList.reactionThankYou' => 'Thank you',
          'cardsList.reactionHug' => 'Hug',
          'cardsList.reactionMadeMyDay' => 'Made my day',
          'cardsList.reactionNoted' => 'Noted',
          'cardsList.reactionError' => 'Could not reply right now. Try again.',
          'cardsList.responseReceivedName' => ({required Object name}) => '${name}',
          'cardsList.responseReceivedNoName' => 'Your person replied',
          'cardsList.responseReceivedVerb' => 'replied',
          'cardsList.responseQuote' => ({required Object label}) => '“${label}”',
          'cardsList.notFound' => 'That card is no longer available.',
          'cardsList.reactionQuoteMadeMyDay' => 'That made my week.',
          'chat.title' => 'Mascot',
          'chat.inputHint' => 'Write here',
          'chat.draftErrors.empty' => 'Write something to send',
          'chat.draftErrors.tooLong' => 'This message is too long',
          'chat.send' => 'Send',
          'chat.messagesLeft' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 message left today',
                  other: '${count} messages left today',
                ),
          'chat.saveAsSlip' => 'Make it a slip',
          'chat.slipSaved' => 'Slip saved',
          'chat.saveLearning' => 'Save as learning',
          'chat.learningSheetTitle' => 'Save as learning',
          'chat.learningSheetTarget' => 'What is it about?',
          'chat.learningTargetError' => 'Pick what this is about.',
          'chat.learningSheetHint' => 'What you want to keep',
          'chat.learningTextErrors.empty' => 'Write what you want to keep',
          'chat.learningTextErrors.tooLong' => 'This is too long',
          'chat.learningSave' => 'Save',
          'chat.learningSaved' => 'Learning saved',
          'chat.learnedLink' => 'What I learned',
          'chat.settingsTitle' => 'Conversation settings',
          'chat.planPlus' => 'Plus plan',
          'chat.planFree' => 'Free plan',
          'chat.usagePlus' => ({
            required Object left,
            required Object limit,
          }) => '${left} of ${limit} messages left today',
          'chat.usageFree' => 'The chat is part of Plus. The free plan has no messages.',
          'chat.sendingTitle' => 'What is sent',
          'chat.sendingText' => 'Only the text you type and the last turns of the conversation go to the model, to produce the reply. Nothing is stored unless you save it as a slip or a learning.',
          'chat.offline' => 'You\'re offline. The chat resumes when you reconnect.',
          'chat.interrupted' => 'The reply was interrupted.',
          'chat.retry' => 'Try again',
          'chat.limitTitle' => 'Today\'s messages are used up',
          'chat.limitText' => 'Come back tomorrow, or see Plus to talk more.',
          'chat.plusTitle' => 'The chat is part of Plus',
          'chat.plusText' => 'The mascot is available on Plus, with 20 messages a day.',
          'chat.plusCta' => 'See plans',
          'chat.unavailableTitle' => 'The chat is not available right now',
          'chat.unavailableText' => 'Try again later.',
          'chat.errorTitle' => 'Couldn\'t load',
          'chat.errorText' => 'Try again in a moment.',
          'chat.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'chat.errors.other' => 'Couldn\'t do that right now. Try again.',
          'chat.menuLabel' => 'More options',
          'chat.action.privateHint' => 'Stays only with you.',
          'chat.action.partnerHint' => 'Nothing goes until you tap.',
          'chat.action.moodText' => ({required Object mood}) => 'Today: ${mood}',
          'chat.action.moods.happy' => 'happy',
          'chat.action.moods.tired' => 'tired',
          'chat.action.moods.sad' => 'sad',
          'chat.action.moods.stressed' => 'stressed',
          'chat.action.moods.loving' => 'loving',
          'chat.action.moods.playful' => 'playful',
          'chat.action.dismiss' => 'Not now',
          'chat.action.running' => 'One moment…',
          'chat.action.done' => 'Done',
          'chat.action.dismissed' => 'Set aside',
          'chat.action.failed' => 'It did not work',
          'chat.action.retry' => 'Try again',
          'chat.action.runLabels.create_private_slip' => 'Save',
          'chat.action.runLabels.send_slip_to_partner' => 'Send',
          'chat.action.runLabels.log_mood' => 'Log',
          'chat.action.runLabels.share_mood' => 'Share',
          'chat.action.runLabels.save_learning' => 'Keep',
          'chat.action.runLabels.open_purchase' => 'See Plus',
          'chat.action.runLabels.other' => 'Do it',
          'chat.action.tags.create_private_slip' => 'Suggestion · Write a slip',
          'chat.action.tags.send_slip_to_partner' => 'Suggestion · Send a slip',
          'chat.action.tags.log_mood' => 'Suggestion · Log mood',
          'chat.action.tags.share_mood' => 'Suggestion · Share mood',
          'chat.action.tags.save_learning' => 'Suggestion · Remember this',
          'chat.action.tags.suggest_couple_question' => 'A question to talk about',
          'chat.action.tags.draft_note' => 'Draft note',
          'chat.action.tags.open_purchase' => 'Plus',
          'chat.action.tags.other' => 'Suggestion',
          'chat.greeting.morning' => 'Good morning',
          'chat.greeting.afternoon' => 'Good afternoon',
          'chat.greeting.evening' => 'Good evening',
          'chat.entryTitle' => 'What do you want to talk about?',
          'chat.entryHighlight' => 'talk',
          'chat.starterBothered' => 'Something bothered me',
          'chat.starterThanks' => 'I want to say thanks',
          'chat.starterDate' => 'A date idea',
          'chat.starterTalk' => 'Prepare a conversation',
          'chat.startHere' => 'Start here',
          'chat.offlineSlip' => 'Make a slip',
          'chat.offlineDiary' => 'Write in the diary',
          'chat.remembersTitle' => 'What it sees and remembers',
          'chat.remembersAction' => 'What I learned',
          'chat.remembersText' =>
            'It only keeps what you confirm, item by item. You can review and delete it any time.',
          'checkin.title' => 'Weekly check-in',
          'checkin.titleHighlight' => 'Weekly',
          'checkin.introSubtitle' => 'Ten minutes. Each of you answers privately first.',
          'checkin.start' => 'Start',
          'checkin.notThisWeek' => 'Not this week',
          'checkin.questionOf' => ({
            required Object current,
            required Object total,
          }) => 'Question ${current} of ${total}',
          'checkin.questions.0' => 'What was good this week?',
          'checkin.questions.1' => 'What do you want us to do together?',
          'checkin.questions.2' => 'Did anything weigh on you this week?',
          'checkin.questions.3' => 'What do you want me to know?',
          'checkin.answerHint' => 'Write as much or as little as you want.',
          'checkin.privateNote' => 'Answers stay hidden until both of you finish.',
          'checkin.next' => 'Next',
          'checkin.finish' => 'Finish',
          'checkin.skip' => 'Skip this question',
          'checkin.skipNote' => 'Skipping leaves this question blank. The check-in only appears when both of you answer all four.',
          'checkin.waitingTitle' => 'Your answers are kept',
          'checkin.waitingText' => 'Answers appear when both of you have answered all four.',
          'checkin.waitingIncomplete' =>
            'Some questions are still blank. Answers appear when both of you answer all four.',
          'checkin.answerMissing' => 'Answer the missing ones',
          'checkin.checkAgain' => 'Check again',
          'checkin.review' => 'Review my answers',
          'checkin.discardTitle' => 'Discard this answer?',
          'checkin.discardText' => 'The text you wrote was not saved.',
          'checkin.discard' => 'Discard',
          'checkin.keepWriting' => 'Keep writing',
          'checkin.revealTitle' => 'Your answers together',
          'checkin.revealHighlight' => 'together',
          'checkin.revealSubtitle' =>
            'Now that you both finished, both answers to each question are shown.',
          'checkin.revealNote' => 'No scores. Just what each of you wrote.',
          'checkin.you' => 'You',
          'checkin.partnerFallback' => 'Your partner',
          'checkin.skippedAnswer' => 'Skipped this question',
          'checkin.close' => 'Close',
          'checkin.soloTitle' => 'The check-in is for both of you',
          'checkin.soloText' => 'When your person joins, the weekly check-in shows up here.',
          'checkin.loadErrorTitle' => 'Couldn\'t open the check-in',
          'checkin.loadErrorText' => 'Nothing was lost. Try again.',
          'checkin.errors.other' => 'Couldn\'t save that now. Try again.',
          'common.appName' => 'Mingo',
          'common.send' => 'Send',
          'common.save' => 'Save',
          'common.retry' => 'Retry',
          'common.loading' => 'Loading',
          'common.username' => 'Username',
          'common.email' => 'Email',
          'common.password' => 'Password',
          'common.firstName' => 'First Name',
          'common.lastName' => 'Last Name',
          'common.genericError' => 'Something went wrong',
          'common.discardTitle' => 'Discard changes?',
          'common.discardText' => 'What you wrote won\'t be saved.',
          'common.discard' => 'Discard',
          'common.keepWriting' => 'Keep writing',
          'connectTouch.title' => 'Touch',
          'connectTouch.text' => 'Neutral cards, nothing spicy. Do it or skip it, no pressure.',
          'connectTouch.switchTitle' => 'Touch topics',
          'connectTouch.switchText' =>
            'Applies to both of you: if one turns it off, it goes away for both.',
          'connectTouch.offTitle' => 'Touch topics are off',
          'connectTouch.offText' =>
            'You or your partner turned them off. You can turn them back on here anytime.',
          'connectTouch.emptyTitle' => 'No cards right now',
          'connectTouch.emptyText' => 'Come back later.',
          'connectTouch.done' => 'Done',
          'connectTouch.skip' => 'Skip',
          'connectTouch.errorTitle' => 'Couldn\'t load',
          'connectTouch.errorText' => 'Try again in a moment.',
          'connectTouch.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'connectTouch.errors.other' => 'Couldn\'t change that right now. Try again.',
          'connectUs.title' => 'I miss us',
          'connectUs.text' =>
            'Send “I miss us” with one tap. Light, no guilt. Your partner doesn\'t have to answer.',
          'connectUs.send' => 'Send with care',
          'connectUs.plan' => 'Suggest a small plan',
          'connectUs.sentNote' => 'Sent. No rush to reply.',
          'connectUs.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'connectUs.errors.other' => 'Couldn\'t send right now. Try again.',
          'connectUs.titleHighlight' => 'us',
          'createAccount.title' => 'Create account',
          'createAccount.headline' => 'Keep it safe',
          'createAccount.headlineHighlight' => 'safe',
          'createAccount.subtitleWithSlip' =>
            'Your first slip is saved on this phone. Create the account so you do not lose it.',
          'createAccount.subtitleWithoutSlip' =>
            'Create the account to keep your slips and not lose them.',
          'dateNight.title' => 'Date night',
          'dateNight.subtitle' => 'Ideas for the two of you, picked together.',
          'dateNight.hint' => 'E.g. picnic in the park',
          'dateNight.add' => 'Add',
          'dateNight.save' => 'Save',
          'dateNight.nextTitle' => 'Next date',
          'dateNight.ideasTitle' => 'Ideas',
          'dateNight.suggestionsTitle' => 'To start with',
          'dateNight.plannedFor' => ({
            required Object month,
            required Object day,
          }) => '${month} ${day}',
          'dateNight.monthsShort.0' => 'Jan',
          'dateNight.monthsShort.1' => 'Feb',
          'dateNight.monthsShort.2' => 'Mar',
          'dateNight.monthsShort.3' => 'Apr',
          _ => null,
        } ??
        switch (path) {
          'dateNight.monthsShort.4' => 'May',
          'dateNight.monthsShort.5' => 'Jun',
          'dateNight.monthsShort.6' => 'Jul',
          'dateNight.monthsShort.7' => 'Aug',
          'dateNight.monthsShort.8' => 'Sep',
          'dateNight.monthsShort.9' => 'Oct',
          'dateNight.monthsShort.10' => 'Nov',
          'dateNight.monthsShort.11' => 'Dec',
          'dateNight.planChoices.today' => 'Plan for today',
          'dateNight.planChoices.tomorrow' => 'Plan for tomorrow',
          'dateNight.planChoices.saturday' => 'Plan for Saturday',
          'dateNight.planChoices.sunday' => 'Plan for Sunday',
          'dateNight.planChoices.other' => '',
          'dateNight.markDone' => 'We did it',
          'dateNight.reopen' => 'Back to ideas',
          'dateNight.done' => 'Done',
          'dateNight.delete' => 'Delete',
          'dateNight.emptyTitle' => 'No ideas yet',
          'dateNight.emptyText' => 'Write a date idea. You both see it.',
          'dateNight.errorTitle' => 'Couldn\'t load',
          'dateNight.errorText' => 'Your ideas are still saved. Try again.',
          'dateNight.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'dateNight.errors.other' => 'Couldn\'t do that right now. Try again.',
          'dates.title' => 'Dates',
          'dates.segmentDates' => 'Dates',
          'dates.segmentGifts' => 'Gifts',
          'dates.segmentHolidays' => 'Holidays',
          'dates.titleLabel' => 'Name',
          'dates.titleHint' => 'E.g. their birthday',
          'dates.titleErrors.empty' => 'Give this date a name',
          'dates.titleErrors.tooLong' => 'The name is too long',
          'dates.kinds.relationship' => 'Relationship',
          'dates.kinds.birthday' => 'Birthday',
          'dates.kinds.first' => 'A first time',
          'dates.kinds.trip' => 'Trip',
          'dates.kinds.custom' => 'Other',
          'dates.kinds.holiday' => 'Holiday',
          'dates.kinds.reunion' => 'Reunion',
          'dates.kinds.other' => '',
          'dates.monthLabel' => 'Month',
          'dates.dayLabel' => 'Day',
          'dates.yearLabel' => 'Year (optional)',
          'dates.yearHint' => 'E.g. 1994',
          'dates.yearHelp' => 'Without the year the date just repeats, with no age.',
          'dates.yearErrors.invalid' => 'Use a year between 1900 and 2200',
          'dates.months.0' => 'January',
          'dates.months.1' => 'February',
          'dates.months.2' => 'March',
          'dates.months.3' => 'April',
          'dates.months.4' => 'May',
          'dates.months.5' => 'June',
          'dates.months.6' => 'July',
          'dates.months.7' => 'August',
          'dates.months.8' => 'September',
          'dates.months.9' => 'October',
          'dates.months.10' => 'November',
          'dates.months.11' => 'December',
          'dates.monthsShort.0' => 'Jan',
          'dates.monthsShort.1' => 'Feb',
          'dates.monthsShort.2' => 'Mar',
          'dates.monthsShort.3' => 'Apr',
          'dates.monthsShort.4' => 'May',
          'dates.monthsShort.5' => 'Jun',
          'dates.monthsShort.6' => 'Jul',
          'dates.monthsShort.7' => 'Aug',
          'dates.monthsShort.8' => 'Sep',
          'dates.monthsShort.9' => 'Oct',
          'dates.monthsShort.10' => 'Nov',
          'dates.monthsShort.11' => 'Dec',
          'dates.dayLine' => ({
            required Object month,
            required Object day,
            required Object kind,
          }) => '${month} ${day} · ${kind}',
          'dates.dayOnly' => ({required Object month, required Object day}) => '${month} ${day}',
          'dates.saveDate' => 'Save date',
          'dates.delete' => 'Delete',
          'dates.deleteTitle' => 'Delete this date?',
          'dates.deleteText' => 'It disappears from the calendar for both of you.',
          'dates.deleteConfirm' => 'Delete',
          'dates.add' => 'Add',
          'dates.emptyDatesTitle' => 'No dates yet',
          'dates.emptyDatesText' => 'Keep birthdays and dates that matter. We remind you ahead.',
          'dates.giftsPrivate' => 'Gift ideas only you see.',
          'dates.giftHint' => 'E.g. book of poems',
          'dates.giftErrors.empty' => 'Write the gift idea',
          'dates.giftErrors.tooLong' => 'The gift idea is too long',
          'dates.given' => 'Given',
          'dates.emptyGiftsTitle' => 'No ideas yet',
          'dates.emptyGiftsText' => 'Jot down gifts when you think of them.',
          'dates.emptyHolidaysTitle' => 'No holidays here',
          'dates.emptyHolidaysText' => 'The calendar has no holidays for you yet.',
          'dates.errorTitle' => 'Couldn\'t load',
          'dates.errorText' => 'Your data is still saved. Try again.',
          'dates.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'dates.errors.other' => 'Couldn\'t do that right now. Try again.',
          'day.dateLine' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'day.months.0' => 'January',
          'day.months.1' => 'February',
          'day.months.2' => 'March',
          'day.months.3' => 'April',
          'day.months.4' => 'May',
          'day.months.5' => 'June',
          'day.months.6' => 'July',
          'day.months.7' => 'August',
          'day.months.8' => 'September',
          'day.months.9' => 'October',
          'day.months.10' => 'November',
          'day.months.11' => 'December',
          'day.previous' => 'Previous day',
          'day.next' => 'Next day',
          'day.planned' => 'Planned date',
          'day.emptyTitle' => 'Nothing set for this day',
          'day.emptyText' => 'A free day is good too.',
          'day.errorTitle' => 'Couldn\'t load',
          'day.errorText' => 'Try again in a moment.',
          'debugSignIn.title' => 'Sign in (debug)',
          'debugSignIn.signIn' => 'Sign in',
          'debugSignIn.createAccount' => 'Create account',
          'debugSignIn.confirmEmail' =>
            'Account created. Check your email to confirm it before signing in.',
          'devices.title' => 'Notification devices',
          'devices.subtitle' => 'Phones that receive notifications for this account. Removing one stops its notifications.',
          'devices.current' => 'This device',
          'devices.registeredToday' => ({required Object time}) => 'Registered today at ${time}',
          'devices.registeredYesterday' => ({
            required Object time,
          }) => 'Registered yesterday at ${time}',
          'devices.registeredOn' => ({required Object date}) => 'Registered on ${date}',
          'devices.platformIos' => 'iPhone',
          'devices.platformAndroid' => 'Android',
          'devices.revokeTitle' => 'Stop notifications on this device?',
          'devices.revokeText' => ({
            required Object name,
          }) => '${name} will stop receiving notifications for this account.',
          'devices.revokeConfirm' => 'Stop notifications',
          'devices.revoked' => 'Notifications stopped on that device.',
          'devices.emptyTitle' => 'No notification devices',
          'devices.emptyText' => 'Devices that receive notifications for this account appear here.',
          'devices.errors.NETWORK' => 'No connection. Try again when you are back online.',
          'devices.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'devices.errors.DEVICE_REVOKE_FAILED' =>
            'Couldn\'t stop notifications on that device. Try again.',
          'devices.errors.other' => 'Couldn\'t stop notifications on that device. Try again.',
          'distance.title' => 'Distance',
          'distance.text' => 'Two clocks, each in its own time zone, never mixed up.',
          'distance.you' => 'You',
          'distance.partner' => 'Your partner',
          'distance.noPartner' => 'When your partner joins, their clock shows up here.',
          'distance.sameZone' => 'You are in the same time zone for now.',
          'distance.reunionDays' => ({required Object n}) => '${n} days until you see each other',
          'distance.reunionToday' => 'You see each other today',
          'distance.reunionTomorrow' => 'You see each other tomorrow',
          'distance.noReunionTitle' => 'No reunion date',
          'distance.noReunionText' =>
            'Save a “Reunion” in your dates and the countdown shows here.',
          'distance.addReunion' => 'Save a date',
          'distance.errorTitle' => 'Couldn\'t load',
          'distance.errorText' => 'Try again in a moment.',
          'fightStyle.questionOf' => ({
            required Object current,
            required Object total,
          }) => 'Question ${current} of ${total}',
          'fightStyle.questions.0' => 'When the conversation heats up, what do you do first?',
          'fightStyle.questions.1' => 'If your partner goes quiet mid-fight, you...',
          'fightStyle.questions.2' => 'After an argument, what usually happens?',
          'fightStyle.questions.3' => 'What bothers you most in a fight?',
          'fightStyle.questions.4' => 'When you notice you went too far, you...',
          'fightStyle.questions.5' => 'What helps you feel normal again?',
          'fightStyle.questionHighlights.0' => 'first',
          'fightStyle.questionHighlights.1' => 'goes quiet',
          'fightStyle.questionHighlights.2' => 'happens',
          'fightStyle.questionHighlights.3' => 'bothers',
          'fightStyle.questionHighlights.4' => 'went too far',
          'fightStyle.questionHighlights.5' => 'back to normal',
          'fightStyle.options1.pursue' => 'I keep talking until it\'s settled.',
          'fightStyle.options1.withdraw' => 'I need some time before going on.',
          'fightStyle.options1.repair' => 'I try to lighten the mood.',
          'fightStyle.options1.avoid' => 'I change the subject so it doesn\'t get worse.',
          'fightStyle.options1.other' => '',
          'fightStyle.options2.pursue' => 'I push for them to speak.',
          'fightStyle.options2.withdraw' => 'I go quiet too.',
          'fightStyle.options2.repair' => 'I calmly ask what happened.',
          'fightStyle.options2.avoid' => 'I leave it for later.',
          'fightStyle.options2.other' => '',
          'fightStyle.options3.pursue' => 'I look for the conversation right away.',
          'fightStyle.options3.withdraw' => 'I spend some time alone.',
          'fightStyle.options3.repair' => 'I think about what I can fix.',
          'fightStyle.options3.avoid' => 'I\'d rather not go back to it.',
          'fightStyle.options3.other' => '',
          'fightStyle.options4.pursue' => 'Getting no answer.',
          'fightStyle.options4.withdraw' => 'Feeling pressured.',
          'fightStyle.options4.repair' => 'Seeing that we don\'t understand each other.',
          'fightStyle.options4.avoid' => 'The conversation dragging on.',
          'fightStyle.options4.other' => '',
          'fightStyle.options5.pursue' => 'I talk even more to explain.',
          'fightStyle.options5.withdraw' => 'I close up until I calm down.',
          'fightStyle.options5.repair' => 'I apologize or suggest a way to fix it.',
          'fightStyle.options5.avoid' => 'I wait for it to cool down.',
          'fightStyle.options5.other' => '',
          'fightStyle.options6.pursue' => 'Finishing the conversation.',
          'fightStyle.options6.withdraw' => 'Some quiet time.',
          'fightStyle.options6.repair' => 'A small gesture of care.',
          'fightStyle.options6.avoid' => 'Carrying on with the day as if nothing happened.',
          'fightStyle.options6.other' => '',
          'fightStyle.continueAction' => 'Continue',
          'fightStyle.finishAction' => 'See result',
          'fightStyle.back' => 'Back',
          'fightStyle.privateNote' => 'Only you see your answers. Nothing is sent to your partner.',
          'fightStyle.resultTitle' => 'How you usually react',
          'fightStyle.resultHighlight' => 'react',
          'fightStyle.patternTag' => 'Your pattern',
          'fightStyle.descriptions.pursue' =>
            'You tend to seek the conversation right away, even while things are still hot.',
          'fightStyle.descriptions.withdraw' => 'You tend to step back first and come back later.',
          'fightStyle.descriptions.repair' =>
            'You tend to look for a way to fix things soon after a fight.',
          'fightStyle.descriptions.avoid' =>
            'You tend to set the subject aside so it doesn\'t get worse in the moment.',
          'fightStyle.descriptions.other' => '',
          'fightStyle.practices.pursue' => 'That helps you sort it out fast. Pausing before it gets worse and listening to the end is worth it.',
          'fightStyle.practices.withdraw' =>
            'That helps you pause before it gets worse. Pick a set way to come back.',
          'fightStyle.practices.repair' =>
            'That helps you return after a fight. A short apology often does it.',
          'fightStyle.practices.avoid' =>
            'That helps you pause before it gets worse. Choose a short moment to come back to it.',
          'fightStyle.practices.other' => '',
          'fightStyle.partnerSignal' => ({
            required Object name,
          }) => 'Agree on a signal with ${name} to come back.',
          'fightStyle.addToTools' => 'Add to my repair tools',
          'fightStyle.addedToTools' => 'Already in your repair tools',
          'fightStyle.keepMine' => 'Keep it to myself',
          'fightStyle.retake' => 'Take it again',
          'fightStyle.addedToast' => 'Added to your repair tools.',
          'fightStyle.loadErrorTitle' => 'Couldn\'t load',
          'fightStyle.loadErrorText' => 'Couldn\'t open your result right now. Try again.',
          'fightStyle.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'fightStyle.errors.other' => 'Couldn\'t save right now. Your answers are still here.',
          'fightStyle.addErrors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'fightStyle.addErrors.other' => 'Couldn\'t add it right now. Try again.',
          'fightStyle.resultBarTitle' => 'Result',
          'firstSlip.title' => 'Start with one good thing',
          'firstSlip.titleHighlight' => 'one good thing',
          'firstSlip.subtitle' => 'What did your partner do lately that made you smile? 30 seconds is enough. No account yet.',
          'firstSlip.hint' => 'E.g. made coffee before I woke up',
          'firstSlip.textErrors.empty' => 'Write one good thing first.',
          'firstSlip.textErrors.tooLong' => 'Use at most 140 characters.',
          'firstSlip.localNote' => 'Stays saved on this phone only.',
          'firstSlip.save' => 'Save',
          'firstSlip.saveError' => 'Could not keep it right now. Try again.',
          'games.hub.title' => 'Play',
          'games.hub.subtitle' => 'Short games for the two of you. No scores and no winner.',
          'games.hub.guessLabel' => 'Guesses',
          'games.hub.talkLabel' => 'Conversation',
          'games.hub.challengeLabel' => 'Challenge',
          'games.hub.minutes' => ({required Object minutes}) => '${minutes} min',
          'games.hub.invitedTitle' => ({required Object name}) => '${name} invited you',
          'games.hub.invitedFallbackTitle' => 'Your partner invited you',
          'games.hub.join' => 'Join',
          'games.hub.stateWaiting' => ({required Object name}) => 'Waiting for ${name}',
          'games.hub.stateWaitingFallback' => 'Waiting for your partner',
          'games.hub.stateInvited' => 'Invited you',
          'games.hub.stateActive' => 'In progress',
          'games.hub.stateFinished' => 'Finished',
          'games.hub.stateCancelled' => 'Invitation cancelled',
          'games.hub.stateExpired' => 'Invitation expired',
          'games.hub.lockChip' => 'Needs both of you',
          'games.hub.noPartnerNote' =>
            'Games need both of you. When your partner joins, you can play.',
          'games.hub.refreshNote' =>
            'To see if anything changed, come back to the app or pull to refresh.',
          'games.hub.loadErrorTitle' => 'Could not open the games',
          'games.hub.loadErrorText' => 'Nothing was lost. Try again.',
          'games.hub.questionCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 question',
                  other: '${count} questions',
                ),
          'games.hub.guessCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 guess',
                  other: '${count} guesses',
                ),
          'games.kinds.meOrYou.title' => 'Me or you',
          'games.kinds.meOrYou.intro' =>
            'Answer separately who fits each phrase better. Then see where you agreed.',
          'games.kinds.howWell.title' => 'How well you know me',
          'games.kinds.howWell.intro' => 'Each of you answers about yourself and guesses the other\'s answer. Then comes the conversation.',
          'games.kinds.twentyQuestions.title' => '20 questions',
          'games.kinds.twentyQuestions.intro' =>
            'Light questions to answer in private and reveal together.',
          'games.kinds.neverHaveWe.title' => 'Never have we',
          'games.kinds.neverHaveWe.intro' => 'Things you have never done together. Each of you answers in private and you see both sides at the end.',
          'games.kinds.mission.title' => 'Date mission',
          'games.kinds.mission.intro' =>
            'A date idea to do together and a short reflection afterwards.',
          'games.start.noWinnerNote' => 'No winner, no points.',
          'games.start.cta' => ({required Object name}) => 'Invite ${name}',
          'games.start.ctaFallback' => 'Invite your partner',
          'games.start.cancelledNote' =>
            'The last invitation was cancelled. You can start again whenever you like.',
          'games.start.expiredNote' =>
            'The previous invitation expired. Invite again whenever you like.',
          'games.start.noContentTitle' => 'This game has no questions yet',
          'games.start.noContentText' => 'There is no content to play yet. Come back soon.',
          'games.invitation.title' => ({required Object name}) => '${name} invited you',
          'games.invitation.titleFallback' => 'Your partner invited you',
          'games.invitation.join' => 'Play now',
          'games.invitation.later' => 'Later',
          'games.waiting.text' => ({
            required Object name,
          }) => 'Invitation sent to ${name}. It starts when they join.',
          'games.waiting.textFallback' => 'Invitation sent. It starts when your partner joins.',
          'games.waiting.status' => 'Waiting…',
          'games.waiting.window' => 'The invitation waits for up to 48 hours.',
          'games.waiting.checkAgain' => 'Check if they joined',
          'games.waiting.stillWaiting' => 'Not in yet. The invite is still here.',
          'games.waiting.cancel' => 'Cancel',
          'games.active.cancel' => 'End the game',
          'games.playing.progress' => ({
            required Object current,
            required Object total,
          }) => 'Question ${current} of ${total}',
          'games.playing.guessProgress' => ({
            required Object current,
            required Object total,
          }) => 'Guess ${current} of ${total}',
          'games.playing.me' => 'Me',
          'games.playing.both' => 'Both',
          'games.playing.partnerFallback' => 'Your partner',
          'games.playing.skip' => 'Skip',
          'games.playing.guessAboutYou' => 'About you',
          'games.playing.guessAboutPartner' => ({required Object name}) => 'About ${name}',
          'games.playing.guessAboutPartnerFallback' => 'About your partner',
          'games.playing.guessPrompt' => ({required Object name}) => 'What did ${name} answer?',
          'games.playing.guessPromptFallback' => 'What did your partner answer?',
          'games.playing.answerHint' => 'Answer as you would.',
          'games.playing.guessHint' => 'Guess what they answered.',
          'games.playing.talkHint' =>
            'Write your answer. Only you can read it until you both finish.',
          'games.playing.talkSubtitle' => 'Answer in private, reveal together.',
          'games.playing.talkNote' => 'Your partner only sees this after both of you answer.',
          'games.playing.privacyNote' =>
            'Each of you answers in private. Skipping is always allowed.',
          'games.playing.changeNote' => ({
            required Object name,
          }) => 'You can change your answer until ${name} answers this question.',
          'games.playing.changeNoteFallback' =>
            'You can change your answer until your partner answers this question.',
          'games.playing.lockedNote' => 'This game is closed. This answer can no longer be edited.',
          'games.playing.introCta' => 'Start',
          'games.playing.next' => 'Next',
          'games.playing.nextGuess' => 'Next',
          'games.date.missionTag' => 'Mission',
          'games.date.start' => 'Accept',
          'games.date.startNote' => 'Do the mission together, then come back and tell how it was.',
          'games.date.reflectionTitle' => 'How was it?',
          'games.date.reflectionText' =>
            'Pick what happened. Your partner sees it only after you both answer.',
          'games.date.save' => 'Save',
          'games.reflections.great' => 'It was great',
          'games.reflections.ok' => 'It was ok',
          'games.reflections.did_not_happen' => 'It did not happen',
          'games.reflections.other' => 'No answer',
          'games.waitingPartner.title' => 'I\'m done',
          'games.waitingPartner.text' => ({
            required Object name,
          }) => 'Now it is ${name}\'s turn. You see the result when both of you finish.',
          'games.waitingPartner.textFallback' =>
            'Now it is your partner\'s turn. You see the result when both of you finish.',
          'games.waitingPartner.checkAgain' => 'Check if they finished',
          'games.waitingPartner.close' => 'Close',
          'games.waitingPartner.cancel' => 'End the game',
          'games.waitingPartner.note' => 'Nothing you answered appears before both of you finish.',
          'games.waitingPartner.stillWaiting' =>
            'Not done yet. The result appears when both of you finish.',
          'games.finished.pickTitle' => ({
            required Object agreed,
            required Object total,
          }) => 'You agreed on ${agreed} of ${total}',
          'games.finished.pickHighlight' => ({
            required Object agreed,
            required Object total,
          }) => '${agreed} of ${total}',
          'games.finished.pickNote' => 'The differences become conversation, not a score.',
          'games.finished.discoveriesTitle' => 'Discoveries',
          'games.finished.discoveriesText' => 'Things you still did not know about each other.',
          'games.finished.youDidNotKnow' => 'You did not know',
          'games.finished.partnerDidNotKnow' => ({required Object name}) => '${name} did not know',
          'games.finished.partnerAnswered' => ({
            required Object name,
            required Object value,
          }) => '${name} answered: ${value}',
          'games.finished.youAnswered' => ({required Object value}) => 'You answered: ${value}',
          'games.finished.noDiscoveries' =>
            'No discoveries this time: you already knew what the other would answer.',
          'games.finished.doneTitle' => 'Done',
          'games.finished.doneText' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'You answered 1 question. No winner, no score.',
                  other: 'You answered ${count} questions. No winner, no score.',
                ),
          'games.finished.dateText' => 'No winner, no score. Just your date.',
          'games.finished.you' => 'You',
          'games.finished.noAnswer' => 'No answer',
          'games.finished.both' => 'Both of you',
          'games.finished.bothSaid' => ({required Object value}) => 'You both said: ${value}',
          'games.finished.eachSaid' => ({
            required Object you,
            required Object name,
            required Object partner,
          }) => 'You said ${you} · ${name} said ${partner}',
          'games.finished.matchedLabel' => 'Same',
          'games.finished.differentLabel' => 'Different',
          'games.finished.replayTag' => 'New round',
          'games.finished.replayQuestions' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 question you have not seen yet',
                  other: '${count} questions you have not seen yet',
                ),
          'games.finished.replayGuesses' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 guess you have not seen yet',
                  other: '${count} guesses you have not seen yet',
                ),
          'games.finished.replayMission' => 'A new mission for you',
          'games.finished.replayText' => 'Each round brings new content. When it runs out, the app tells you and mixes in what you already saw.',
          'games.finished.playAgain' => 'Play again',
          'games.finished.chooseAnother' => 'Choose another game',
          'games.finished.missingTitle' => 'This round is no longer available',
          'games.finished.missingText' =>
            'The content changed since you played. You can start another one.',
          'games.notFound.title' => 'This game does not exist',
          'games.notFound.text' =>
            'It may have changed or never existed. Go back and pick another one.',
          'games.notFound.action' => 'Go back',
          'games.cancel.title' => 'End the game?',
          'games.cancel.text' => 'The game ends for both of you. You can start another later.',
          'games.cancel.confirm' => 'End game',
          'games.cancel.keep' => 'Keep playing',
          'games.noPartner.title' => 'Games are for two',
          'games.noPartner.text' => 'When your partner joins, you can play together.',
          'games.loadErrorTitle' => 'Could not open the game',
          'games.loadErrorText' => 'Nothing was lost. Try again.',
          'games.errors.NOT_PAIRED' => 'Games need both of you connected.',
          'games.errors.NOT_FOUND' => 'That game no longer exists. We\'ll refresh.',
          'games.errors.INVALID_GAME_ACTION' => 'That game changed. We\'ll refresh.',
          'games.errors.GAME_ALREADY_OPEN' =>
            'A game is already open. Finish or cancel it before inviting again.',
          'games.errors.GAME_NOT_COMPLETE' =>
            'Your partner is still answering. Try again when they finish.',
          'games.errors.INVALID_GAME_INDEX' => 'That question changed. We\'ll refresh.',
          'games.errors.ANSWER_LOCKED' =>
            'This game\'s answers are closed. You can\'t edit them now.',
          'games.errors.other' => 'Could not do that right now. Try again.',
          'games.common.back' => 'Back',
          'gentleRequest.title' => 'Gentle request',
          'gentleRequest.titleHighlight' => 'Gentle',
          'gentleRequest.whenLabel' => 'When…',
          'gentleRequest.feelLabel' => 'I feel…',
          'gentleRequest.wishLabel' => 'I would like to…',
          'gentleRequest.whenHint' => 'I get home and the house is a mess',
          'gentleRequest.feelHint' => 'alone with the chores',
          'gentleRequest.wishHint' => 'share Saturday afternoon with you',
          'gentleRequest.previewTitle' => ({required Object name}) => 'What ${name} will read',
          'gentleRequest.previewTitleNoName' => 'What your person will read',
          'gentleRequest.previewEmpty' => 'Fill in the three sentences to see the request.',
          'gentleRequest.sentence' => ({
            required Object when,
            required Object feel,
            required Object wish,
          }) => 'When ${when}, I feel ${feel}. I would like to ${wish}.',
          'gentleRequest.note' =>
            'It does not go on the Sunday card. The request goes away 7 days after it is answered.',
          'gentleRequest.keep' => 'Keep',
          'gentleRequest.sendNow' => 'Send now',
          'gentleRequest.confirmTitle' => 'Send this request?',
          'gentleRequest.confirmText' =>
            'Your person will read the three sentences. The note it came from stops existing.',
          'gentleRequest.sent' => 'Request sent',
          'gentleRequest.fieldErrors.empty' => 'Fill in this sentence.',
          'gentleRequest.fieldErrors.tooLong' => 'Use at most 140 characters.',
          'gentleRequest.errors.NOT_PAIRED' => 'A gentle request needs a connected person.',
          'gentleRequest.errors.NETWORK' => 'No connection. Try again.',
          'gentleRequest.errors.other' => 'We could not send it now. Try again.',
          'gentleRequestDetail.partnerFallback' => 'your person',
          'gentleRequestDetail.fromYou' => ({required Object name}) => 'You wrote to ${name}.',
          'gentleRequestDetail.toYou' => ({required Object name}) => '${name} wrote to you.',
          'gentleRequestDetail.answerTitle' => 'How do you want to answer?',
          'gentleRequestDetail.responses.willDo' => 'I will take care of it',
          'gentleRequestDetail.responses.later' => 'Later',
          'gentleRequestDetail.responses.notNow' => 'Not now',
          'gentleRequestDetail.responses.talk' => 'I want to talk',
          'gentleRequestDetail.responses.moreTime' => 'I need more time',
          'gentleRequestDetail.responses.other' => '',
          'gentleRequestDetail.answeredBy' => ({
            required Object name,
            required Object answer,
          }) => '${name} answered: ${answer}',
          'gentleRequestDetail.youAnswered' => ({
            required Object answer,
          }) => 'You answered: ${answer}',
          'gentleRequestDetail.waiting' => 'No answer yet.',
          'gentleRequestDetail.thankAction' => 'Say thanks',
          'gentleRequestDetail.thanked' => 'You said thanks. It became a slip of yours.',
          'gentleRequestDetail.thankBody' => ({
            required Object name,
            required Object wish,
          }) => '${name} took care of it: ${wish}',
          'gentleRequestDetail.goneTitle' => 'That request is gone',
          'gentleRequestDetail.goneText' =>
            'It was answered more than 7 days ago or no longer exists.',
          'gentleRequestDetail.errorTitle' => 'We could not open the request',
          'gentleRequestDetail.errors.NETWORK' => 'No connection. Try again.',
          'gentleRequestDetail.errors.other' => 'Something went wrong. Try again.',
          'gifts.title' => 'Gift page',
          'gifts.subtitle' => 'A page your partner can see in the app. You choose what to share.',
          'gifts.myTitle' => 'My wishes',
          'gifts.partnerTitle' => 'From your partner',
          'gifts.emptyPageTitle' => 'No wishes yet',
          'gifts.emptyPageTextShared' => 'Add a wish, or wait for your partner to share one.',
          'gifts.emptyPageTextSolo' =>
            'Add what you would love to receive. It stays private until you pair.',
          'gifts.emptyMineTitle' => 'No wishes yet',
          'gifts.emptyMineText' => 'Add what you would love to receive.',
          'gifts.emptyPartnerTitle' => 'Nothing shared yet',
          'gifts.emptyPartnerText' => 'When your partner shares a wish, it shows up here.',
          'gifts.addTitle' => 'New wish',
          'gifts.editTitle' => 'Edit wish',
          'gifts.titleLabel' => 'Gift',
          'gifts.titleHint' => 'E.g. a book of poems',
          'gifts.titleErrors.empty' => 'Give the wish a name.',
          'gifts.titleErrors.tooLong' => 'Keep it to 120 characters or fewer.',
          'gifts.noteHint' => 'Size, color, where to find it.',
          'gifts.noteErrors.tooLong' => 'Keep the note under 1000 characters.',
          'gifts.budgetLabel' => 'Budget (optional)',
          'gifts.budgets.free' => 'Free',
          'gifts.budgets.low' => 'Low',
          'gifts.budgets.medium' => 'Medium',
          'gifts.budgets.high' => 'High',
          'gifts.budgets.other' => '',
          'gifts.noBudget' => 'No budget',
          'gifts.shared' => 'Shared',
          'gifts.private' => 'Private',
          'gifts.sharedHint' => 'Your partner can see this wish.',
          'gifts.privateHint' => 'Only you can see this wish.',
          'gifts.sharedNeedsPartner' => 'Pair with your partner to share a wish.',
          'gifts.save' => 'Save',
          'gifts.add' => 'Add',
          'gifts.delete' => 'Delete',
          'gifts.deleteTitle' => 'Delete this wish?',
          'gifts.deleteText' => 'It disappears for you and your partner.',
          'gifts.deleteConfirm' => 'Delete',
          'gifts.entryLabel' => 'GIFTS',
          'gifts.entryTitle' => 'Gift page',
          'gifts.entryText' => 'Wishes you choose to share, or keep to yourself.',
          'gifts.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'gifts.errors.other' => 'Couldn\'t do that right now. Try again.',
          'globalErrors.offline' => 'No connection. Your notes stay saved and sync later.',
          'globalErrors.errorTitle' => 'Something went wrong',
          'globalErrors.errorText' => 'Try again in a moment.',
          'globalErrors.networkTitle' => 'No connection',
          'globalErrors.networkText' => 'Check the connection and try again.',
          'globalErrors.timeoutTitle' => 'The connection took too long',
          'globalErrors.timeoutText' => 'Try again in a moment.',
          'globalErrors.rateTitle' => 'Easy there',
          'globalErrors.rateText' => 'Too many tries in a row. Wait a little and try again.',
          'globalErrors.notFoundTitle' => 'Not found',
          'globalErrors.notFoundText' => 'Maybe this is no longer available.',
          'globalErrors.retry' => 'Try again',
          'globalErrors.retryIn' => ({required Object seconds}) => 'Try in ${seconds}s',
          'globalErrors.updateTitle' => 'Update the app',
          'globalErrors.updateHighlight' => 'app',
          'globalErrors.updateText' => 'There is a new version. Update to continue.',
          'globalErrors.updateAction' => 'Update',
          'globalErrors.updateUnavailable' => 'Could not open the store. Update there.',
          'griefSupport.title' => 'We\'re with you',
          'griefSupport.highlight' => 'you',
          'griefSupport.text' => 'Your memories stay here, at your pace.',
          'griefSupport.seeSupport' => 'See support',
          'griefSupport.backHome' => 'Back to the start',
          'guides.hub.title' => 'Difficult conversations',
          'guides.hub.titleHighlight' => 'Difficult',
          'guides.hub.subtitle' => 'One step at a time, in private.',
          'guides.hub.privateNote' => 'Your notes stay with you. Nothing is sent to your partner.',
          'guides.hub.stepCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 step',
                  other: '${count} steps',
                ),
          'guides.hub.loadErrorTitle' => 'Could not open the topics',
          'guides.hub.loadErrorText' => 'Nothing was lost. Try again.',
          'guides.viewer.stepOf' => ({
            required Object current,
            required Object total,
          }) => 'Step ${current} of ${total}',
          'guides.viewer.answerHint' => 'Write whatever makes sense. It can stay blank.',
          'guides.viewer.stepNote' => 'Saved as you go. Only you can see it.',
          'guides.viewer.next' => 'Next',
          'guides.viewer.finish' => 'Finish',
          'guides.viewer.back' => 'Back',
          'guides.viewer.loadErrorTitle' => 'Could not open this conversation',
          'guides.viewer.loadErrorText' => 'Nothing was lost. Try again.',
          'guides.viewer.errors.other' => 'Could not save right now. Your answers are still here.',
          'guides.gate.title' => 'A sensitive topic',
          'guides.gate.text' => 'This topic is about intimacy and is meant for adults. You can go slowly or choose another topic whenever you like.',
          'guides.gate.cycleText' => 'This topic is about your body and mood through the month and is meant for adults. You can go slowly or choose another topic whenever you like.',
          'guides.gate.continueAction' => 'Continue',
          'guides.gate.otherAction' => 'See other topics',
          'guides.finish.title' => 'Your conversation is ready',
          'guides.finish.titleHighlight' => 'ready',
          'guides.finish.text' => 'Your notes are saved to your account, privately.',
          'guides.finish.finishSaved' => 'Saved only for you.',
          'guides.finish.start' => 'Start a conversation',
          'guides.finish.other' => 'Back to topics',
          'hardConversation.title' => 'Prepare a hard conversation',
          'hardConversation.stepOf' => ({
            required Object current,
            required Object total,
          }) => 'Step ${current} of ${total}',
          'hardConversation.whatTitle' => 'What happened?',
          'hardConversation.whatHint' => 'If you want, tell me in your own words',
          _ => null,
        } ??
        switch (path) {
          'hardConversation.whatIgnored' => 'She felt ignored',
          'hardConversation.whatMoney' => 'We fought about money',
          'hardConversation.whatMisunderstanding' => 'It was a misunderstanding',
          'hardConversation.whatOther' => 'Other: write it',
          'hardConversation.needTitle' => 'What do I need?',
          'hardConversation.needHint' => 'If you want, add something',
          'hardConversation.needHeard' => 'To be heard',
          'hardConversation.needApology' => 'To apologize',
          'hardConversation.needAgree' => 'To agree on something',
          'hardConversation.sayTitle' => 'How to say it',
          'hardConversation.sayIntro' => 'A starting point for you to edit before sending.',
          'hardConversation.sayHint' => 'Your opening sentence',
          'hardConversation.messageErrors.empty' => 'Write the sentence first',
          'hardConversation.messageErrors.tooLong' => 'This sentence is too long',
          'hardConversation.generating' => 'Writing a gentle opening…',
          'hardConversation.gentler' => 'More gentle',
          'hardConversation.moreDirect' => 'More direct',
          'hardConversation.copy' => 'Copy',
          'hardConversation.copied' => 'Copied',
          'hardConversation.sendAsNote' => 'Send as a note',
          'hardConversation.sent' => 'Note sent',
          'hardConversation.exit' => 'Leave',
          'hardConversation.next' => 'Next',
          'hardConversation.back' => 'Back',
          'hardConversation.retry' => 'Try again',
          'hardConversation.generationFailed' => 'Couldn\'t write a sentence right now.',
          'hardConversation.privateNote' =>
            'The mascot only sees what you write here. Your partner\'s data is never sent.',
          'hardConversation.offline' => 'You\'re offline. The opening sentence needs a connection.',
          'hardConversation.emptyTitle' => 'Couldn\'t load',
          'hardConversation.emptyText' => 'Try again in a moment.',
          'hardConversation.plusTitle' => 'Preparing a conversation is part of Plus',
          'hardConversation.plusText' => 'The three steps and the opening suggestion are in Plus.',
          'hardConversation.plusCta' => 'See plans',
          'hardConversation.limitTitle' => 'Today\'s messages are used up',
          'hardConversation.limitText' =>
            'Come back tomorrow, or see Plus to prepare more conversations.',
          'hardConversation.errors.CHAT_LIMIT' => 'Today\'s messages are used up.',
          'hardConversation.errors.CHAT_DISABLED' =>
            'The chat is off. Turn it on to use the mascot.',
          'hardConversation.errors.CHAT_UNAVAILABLE' => 'The chat is not available right now.',
          'hardConversation.errors.UPSTREAM' => 'Couldn\'t write a sentence right now. Try again.',
          'hardConversation.errors.NOT_PAIRED' =>
            'To send this, you need to be connected with your partner in the app.',
          'hardConversation.errors.other' => 'Couldn\'t do that right now. Try again.',
          'help.badDayTitle' => 'A hard day',
          'help.badDayText' => 'Three small things that may help right now. Nothing required.',
          'help.starterTitle' => 'Start a conversation',
          'help.starterText' => 'A question to open with, no rush.',
          'help.another' => 'Another',
          'help.emptyTitle' => 'Nothing here yet',
          'help.emptyText' => 'We\'re preparing more suggestions.',
          'help.errorTitle' => 'Couldn\'t load',
          'help.errorText' => 'Try again in a moment.',
          'helpSupport.title' => 'Help',
          'helpSupport.contactTitle' => 'Talk to support',
          'helpSupport.reportBug' => 'Report a bug',
          'helpSupport.faqTitle' => 'Common questions',
          'helpSupport.faqQuestions.replyTime' => 'When will I get an answer?',
          'helpSupport.faqQuestions.offline' => 'What if I send without internet?',
          'helpSupport.faqQuestions.privacy' => 'Who reads what I send?',
          'helpSupport.faqQuestions.reportBug' => 'How do I report a bug?',
          'helpSupport.faqAnswers.replyTime' => 'We reply within 2 business days.',
          'helpSupport.faqAnswers.offline' =>
            'Your message stays saved and goes out when you\'re online again.',
          'helpSupport.faqAnswers.privacy' =>
            'Only the support team. Nothing is shared with your partner.',
          'helpSupport.faqAnswers.reportBug' => 'Choose Bug in the form and tell us what happened.',
          'helpSupport.pendingNote' => 'A message is saved and will be sent when you\'re online.',
          'helpSupport.discardedNote' => 'A saved message couldn\'t be sent and was removed. Write to us again if it still matters.',
          'helpSupport.supportTitle' => 'Support',
          'helpSupport.supportHeading' => 'How can we help?',
          'helpSupport.supportHighlight' => 'help',
          'helpSupport.topics.account' => 'Account',
          'helpSupport.topics.billing' => 'Billing',
          'helpSupport.topics.bug' => 'Bug',
          'helpSupport.topics.other' => 'Other',
          'helpSupport.messageLabel' => 'Message',
          'helpSupport.messageHint' => 'Tell us what happened, with as much detail as you like.',
          'helpSupport.messageErrors.empty' => 'Write your message first',
          'helpSupport.messageErrors.tooLong' => 'The message is too long',
          'helpSupport.replyEmailLabel' => 'Reply email',
          'helpSupport.replyEmailHint' => 'you@email.com',
          'helpSupport.replyEmailErrors.invalid' => 'Check the email address.',
          'helpSupport.replyEmailErrors.tooLong' => 'This email is too long',
          'helpSupport.replyTime' => 'We reply within 2 business days.',
          'helpSupport.send' => 'Send',
          'helpSupport.sentTitle' => 'Message sent',
          'helpSupport.sentText' => 'Thanks. We reply within 2 business days.',
          'helpSupport.queuedTitle' => 'Saved',
          'helpSupport.queuedText' =>
            'We\'ll send it when you\'re back online. It hasn\'t been delivered yet.',
          'helpSupport.done' => 'Done',
          'helpSupport.errors.RATE_LIMITED' =>
            'You sent several messages today. Try again tomorrow.',
          'helpSupport.errors.noData' => 'Couldn\'t send right now. Your message is still here.',
          'helpSupport.errors.other' => 'Couldn\'t send right now. Your message is still here.',
          'helpSupport.discardTitle' => 'Discard this message?',
          'helpSupport.discardText' => 'What you wrote won\'t be saved.',
          'history.title' => 'Our history',
          'history.addMilestoneTooltip' => 'Add milestone',
          'history.togetherSinceLine' => ({required Object date}) => 'together since ${date}',
          'history.setStartDate' => 'Set when our story started',
          'history.beginningHeadline' => 'Starting out',
          'history.reunionCountdown' =>
            ({required num days}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  days,
                  one: '${days} day to go',
                  other: '${days} days to go',
                ),
          'history.durationFull' => ({
            required Object years,
            required Object yearsUnit,
            required Object months,
            required Object monthsUnit,
            required Object days,
            required Object daysUnit,
          }) => '${years} ${yearsUnit}, ${months} ${monthsUnit}\nand ${days} ${daysUnit}',
          'history.durationFullInline' => ({
            required Object years,
            required Object yearsUnit,
            required Object months,
            required Object monthsUnit,
            required Object days,
            required Object daysUnit,
          }) => '${years} ${yearsUnit}, ${months} ${monthsUnit} and ${days} ${daysUnit}',
          'history.durationMonthsDays' => ({
            required Object months,
            required Object monthsUnit,
            required Object days,
            required Object daysUnit,
          }) => '${months} ${monthsUnit} and ${days} ${daysUnit}',
          'history.durationDaysOnly' => ({
            required Object days,
            required Object daysUnit,
          }) => '${days} ${daysUnit}',
          'history.yearOne' => 'year',
          'history.yearMany' => 'years',
          'history.monthOne' => 'month',
          'history.monthMany' => 'months',
          'history.dayOne' => 'day',
          'history.dayMany' => 'days',
          'history.statDays' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'day',
                  other: 'days',
                ),
          'history.statWeekends' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'weekend',
                  other: 'weekends',
                ),
          'history.statChristmases' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'Christmas',
                  other: 'Christmases',
                ),
          'history.statPlaces' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'place',
                  other: 'places',
                ),
          'history.storyDatesAction' => 'Story dates',
          'history.numbersAction' => 'In numbers',
          'history.variationsAction' => 'How the counter looks',
          'history.avatarAction' => 'Your avatar',
          'history.differentDatesBanner' => 'You chose different start dates',
          'history.differentDatesAction' => 'See dates',
          'history.timelineSection' => 'MILESTONES AND MEMORIES',
          'history.recentChip' => 'Recent',
          'history.unknownYearChip' => 'No date',
          'history.timelineRecentNote' => 'Showing your most recent milestones.',
          'history.loadEarlierYear' => ({required Object year}) => 'See ${year}',
          'history.unknownDateLabel' => 'Unknown date',
          'history.addMilestoneRow' => 'Add a milestone',
          'history.emptyTitle' => 'Start with your first milestone',
          'history.emptyText' => 'Save when you met or a special moment.',
          'history.suggestedFirstTitle' => 'We met',
          'history.suggestedFirstSub' => 'Suggested first milestone · tap to add',
          'history.monthsShort.0' => 'Jan',
          'history.monthsShort.1' => 'Feb',
          'history.monthsShort.2' => 'Mar',
          'history.monthsShort.3' => 'Apr',
          'history.monthsShort.4' => 'May',
          'history.monthsShort.5' => 'Jun',
          'history.monthsShort.6' => 'Jul',
          'history.monthsShort.7' => 'Aug',
          'history.monthsShort.8' => 'Sep',
          'history.monthsShort.9' => 'Oct',
          'history.monthsShort.10' => 'Nov',
          'history.monthsShort.11' => 'Dec',
          'history.monthsLong.0' => 'January',
          'history.monthsLong.1' => 'February',
          'history.monthsLong.2' => 'March',
          'history.monthsLong.3' => 'April',
          'history.monthsLong.4' => 'May',
          'history.monthsLong.5' => 'June',
          'history.monthsLong.6' => 'July',
          'history.monthsLong.7' => 'August',
          'history.monthsLong.8' => 'September',
          'history.monthsLong.9' => 'October',
          'history.monthsLong.10' => 'November',
          'history.monthsLong.11' => 'December',
          'history.fullDate' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'history.shortDayMonthYear' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'history.shortMonthYear' => ({
            required Object month,
            required Object year,
          }) => '${month} ${year}',
          'history.shortDayMonth' => ({
            required Object month,
            required Object day,
          }) => '${month} ${day}',
          'history.milestoneNewTitle' => 'New milestone',
          'history.milestoneDetailTitle' => 'Milestone details',
          'history.milestoneDefaultHighlight' => 'together',
          'history.milestoneTitleLabel' => 'What happened',
          'history.milestoneTitleHint' => 'E.g. First trip together',
          'history.milestoneTitleErrors.empty' => 'Say what happened',
          'history.milestoneTitleErrors.tooLong' => 'The title is too long',
          'history.milestonePlaceLabel' => 'Place (optional)',
          'history.milestonePlaceHint' => 'E.g. Paraty',
          'history.milestonePlaceErrors.tooLong' => 'The place is too long',
          'history.milestoneBodyHint' => 'A note about this moment (optional)',
          'history.milestoneBodyErrors.tooLong' => 'The note is too long',
          'history.milestoneKindLabel' => 'Milestone kind',
          'history.kindFirst' => 'First time',
          'history.kindTrip' => 'Trip',
          'history.kindHome' => 'Moved in together',
          'history.kindCustom' => 'Milestone',
          'history.unknownDateToggle' => 'Unknown date',
          'history.precisionDay' => 'Exact day',
          'history.precisionMonth' => 'Month and year',
          'history.precisionYear' => 'Year only',
          'history.dateRowLabel' => 'Date',
          'history.addedByRowLabel' => 'Added by',
          'history.addedByYou' => 'You',
          'history.visibilityRowLabel' => 'Who sees it',
          'history.visibilityBoth' => 'Both',
          'history.visibilityOnlyYou' => 'Only you',
          'history.deleteMilestone' => 'Delete',
          'history.deleteMilestoneTitle' => 'Delete this milestone?',
          'history.deleteMilestoneTextShared' => 'It will be removed from both of your stories.',
          'history.deleteMilestoneTextPrivate' => 'It will be removed from your story.',
          'history.deleteMilestoneConfirm' => 'Delete',
          'history.saveMilestone' => 'Save',
          'history.storyDatesTitle' => 'Dates of our story',
          'history.storyMet' => 'We met',
          'history.storyDating' => 'Started dating',
          'history.storyEngaged' => 'Got engaged',
          'history.storyMarried' => 'Got married',
          'history.storyAdd' => 'Add',
          'history.storyDateAddedBy' => ({required Object name}) => 'Added by ${name}',
          'history.storyDatesNote' => 'Everything is optional. The start date feeds the counter.',
          'history.variationsTitle' => 'How the counter looks',
          'history.variationDating' => 'Dating',
          'history.variationEngaged' => 'Engaged',
          'history.variationMarried' => 'Married',
          'history.variationBeginning' => 'Starting out',
          'history.variationLongDistance' => 'Long distance',
          'history.variationsPreviewNote' => 'Style preview. The time shown is your real total; per-phase counts need their own dates.',
          'history.avatarHeadline' => 'How do you appear?',
          'history.avatarHighlight' => 'appear',
          'history.avatarInitials' => 'Initials',
          'history.avatarInitialsNote' => 'Your avatar uses your initials.',
          'history.avatarNote' =>
            'Each person chooses their own. The app never pulls the other\'s photo.',
          'history.avatarContinue' => 'Continue',
          'history.numbersTitle' => 'In numbers',
          'history.numbersHeroDays' => ({required Object days}) => '${days} days',
          'history.numbersHeroEmpty' => 'In your own time',
          'history.numbersHeroEmptySub' => 'Set a start date whenever you want to track the days.',
          'history.numbersWeekends' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'weekend together',
                  other: 'weekends together',
                ),
          'history.numbersFullMoons' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'full moon',
                  other: 'full moons',
                ),
          'history.numbersChristmases' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'Christmas together',
                  other: 'Christmases together',
                ),
          'history.numbersNextAnniversary' =>
            ({required num years, required Object suffix}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  years,
                  one: 'until ${years} year ${suffix}',
                  other: 'until ${years} years ${suffix}',
                ),
          'history.numbersSuffixDating' => 'dating',
          'history.numbersSuffixEngaged' => 'engaged',
          'history.numbersSuffixMarried' => 'married',
          'history.numbersSuffixTogether' => 'together',
          'history.numbersMonthsCount' =>
            ({required num months}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  months,
                  one: '${months} month',
                  other: '${months} months',
                ),
          'history.numbersDaysCount' =>
            ({required num days}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  days,
                  one: '${days} day',
                  other: '${days} days',
                ),
          'history.numbersPlacesSection' => 'PLACES THAT MATTERED',
          'history.numbersYearSection' => ({required Object year}) => 'YOUR YEAR (${year})',
          'history.numbersYearNote' => 'Only your own records this year.',
          'history.numbersFirstsCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'first time',
                  other: 'first times',
                ),
          'history.differentHeadline' => 'The dates differ',
          'history.differentHighlight' => 'differ',
          'history.differentSubtitle' => ({
            required Object partner,
          }) => 'You and ${partner} chose different start dates.',
          'history.differentYourDate' => 'Your date',
          'history.differentPartnerDate' => ({required Object partner}) => '${partner}\'s date',
          'history.differentNote' => 'Each sees their own. Nothing is changed without both.',
          'history.differentNoDates' => 'There are no start dates to compare yet.',
          'history.differentContinue' => 'Continue',
          'history.partnerFallback' => 'your partner',
          'history.errorTitle' => 'Couldn\'t load',
          'history.errorText' => 'Your story is still saved. Try again.',
          'history.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'history.errors.NOT_OWNER' => 'Only its author can edit or delete it.',
          'history.errors.other' => 'Couldn\'t do that right now. Try again.',
          'history.numbersMemoriesCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'saved memory',
                  other: 'saved memories',
                ),
          'history.numbersMemoriesRecent' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'recent memory',
                  other: 'recent memories',
                ),
          'history.numbersPlaces' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'place',
                  other: 'places',
                ),
          'history.readOnlyMilestone' =>
            'This milestone was added by someone else. Only its author can edit it.',
          'history.readOnlyMilestoneBy' => ({
            required Object name,
          }) => 'Added by ${name}. Only its author can edit it.',
          'ideaDetail.label' => 'Idea of the day',
          'ideaDetail.whyTitle' => 'Why this idea',
          'ideaDetail.yourPhase' => 'Your phase',
          'ideaDetail.yourGoal' => 'Your goal',
          'ideaDetail.willDo' => 'I will do it',
          'ideaDetail.done' => 'Noted. Nice!',
          'ideaDetail.another' => 'Another idea',
          'ideaDetail.later' => 'Later',
          'ideaDetail.laterTitle' => 'When should we remind you?',
          'ideaDetail.tonight' => 'Tonight',
          'ideaDetail.tomorrow' => 'Tomorrow morning',
          'ideaDetail.weekend' => 'This weekend',
          'ideaDetail.reminderSet' => 'Done. We will remind you with a gentle nudge.',
          'ideaDetail.reminderSetNotificationsOff' =>
            'Reminder saved. Turn notifications on in settings to receive it.',
          'ideaDetail.reminderError' => 'Could not save the reminder. Try again.',
          'ideaDetail.emptyTitle' => 'No ideas right now',
          'ideaDetail.emptyText' => 'Come back later. In the meantime, note a slip.',
          'ideaDetail.errorTitle' => 'Could not load the idea',
          'ideaDetail.errorText' => 'Try again in a moment.',
          'inbox.title' => 'Notifications',
          'inbox.bellUnread' => 'Notifications, something new',
          'inbox.todayTitle' => 'Today',
          'inbox.earlierTitle' => 'This week',
          'inbox.markAllRead' => 'Mark all as read',
          'inbox.settingsAction' => 'Notification settings',
          'inbox.footnote' =>
            'At most 2 alerts a day arrive as a notification. The rest stay only here.',
          'inbox.emptyTitle' => 'Nothing new here',
          'inbox.emptyText' => 'When someone sends a card or replies, it shows up here.',
          'inbox.errorTitle' => 'We could not load your notifications',
          'inbox.partnerFallback' => 'Your partner',
          'inbox.tapToSee' => 'Tap to see',
          'inbox.cardReadyTitle' => 'Your weekly card is ready',
          'inbox.cardReadyText' => 'Open to see the draft',
          'inbox.cardReceivedTitle' => ({required Object name}) => '${name} sent you a card',
          'inbox.cardReactionTitle' => ({required Object name}) => '${name} reacted to your card',
          'inbox.partnerJoinedTitle' => ({required Object name}) => '${name} joined',
          'inbox.partnerJoinedText' => 'You are connected now',
          'inbox.unpairedTitle' => 'The connection ended',
          'inbox.unpairedText' => 'Your data is still yours',
          'inbox.partnerMessageTitle' => ({required Object name}) => '${name} sent a message',
          'inbox.gameInviteTitle' => ({required Object name}) => '${name} invited you to play',
          'inbox.gameInviteText' => 'Pick a time when you like',
          'inbox.signalTitle' => ({required Object name}) => '${name} sent a note',
          'inbox.dateComingTitle' => 'A date is coming up',
          'inbox.dateComingText' => 'See ideas for the two of you',
          'inbox.ritualTitle' => 'Time for one of your rituals',
          'inbox.dailyIdeaTitle' => 'Idea of the day',
          'inbox.dailyIdeaText' => 'A small idea for today',
          'inbox.gentleReturnTitle' => 'We miss you',
          'inbox.gentleReturnText' => 'Come back whenever you like',
          'inbox.capsuleOpenedTitle' => 'A time capsule opened',
          'inbox.capsuleOpenedText' => 'See what you kept',
          'inbox.errors.NETWORK' => 'No connection. Check the internet and try again.',
          'inbox.errors.other' => 'Something went wrong. Try again.',
          'inbox.gentleRequestTitle' => ({
            required Object name,
          }) => '${name} wrote a gentle request',
          'inbox.gentleRequestAnsweredTitle' => ({
            required Object name,
          }) => '${name} answered your request',
          'inbox.annoyanceCheckTitle' => 'Does this still bother you?',
          'inbox.annoyanceCheckText' => 'One of your notes goes away soon',
          'inbox.quizSharedTitle' => ({required Object name}) => '${name} showed a quiz',
          'inbox.spiceInviteTitle' => 'An invite from Tempero',
          'inbox.spiceInviteText' => 'It only shows up if you both turn it on',
          'inbox.spiceOffTitle' => 'Tempero was turned off',
          'inbox.spiceOffText' => 'Nothing from the mode was kept',
          'inbox.memoryProposedTitle' => ({
            required Object name,
          }) => '${name} wants to keep a memory with you',
          'inbox.memoryAcceptedTitle' => ({required Object name}) => '${name} accepted the memory',
          'inbox.memoryDeclinedTitle' => ({
            required Object name,
          }) => '${name} preferred not to keep the memory',
          'inbox.memoryDeclinedText' => 'It is no longer shared',
          'inbox.plusBillingIssueTitle' => 'There is a problem with the Plus payment',
          'inbox.plusBillingIssueText' => 'See what to do to keep it',
          'inbox.plusCoverageEndedTitle' => 'Plus coverage ended',
          'inbox.plusCoverageEndedText' => 'You keep everything you created',
          'intro.skip' => 'Skip',
          'intro.continueButton' => 'Continue',
          'intro.phase.title' => 'Where are you two right now?',
          'intro.phase.titleHighlight' => 'right now',
          'intro.phase.subtitle' => 'Pick the closest one. You can change it later.',
          'intro.phase.options.dating' => 'Dating',
          'intro.phase.options.livingTogether' => 'Living together',
          'intro.phase.options.engaged' => 'Engaged',
          'intro.phase.options.married' => 'Married',
          'intro.phase.options.longDistance' => 'Long distance',
          'intro.phase.options.restarting' => 'Starting over',
          'intro.phase.options.other' => '',
          'intro.goals.title' => 'What do you want from the app?',
          'intro.goals.titleHighlight' => 'app',
          'intro.goals.subtitle' => 'Pick as many as you like.',
          'intro.goals.options.reconnect' => 'Reconnect',
          'intro.goals.options.fightLess' => 'Fight less',
          'intro.goals.options.keepRomance' => 'Keep the romance',
          'intro.goals.options.rememberDates' => 'Remember dates',
          'intro.goals.options.organizeRoutine' => 'Organise the routine',
          'intro.goals.options.justRecord' => 'Just note the good things',
          'intro.goals.options.other' => '',
          'intro.theme.title' => 'Which colour suits you?',
          'intro.theme.titleHighlight' => 'colour',
          'intro.theme.subtitle' =>
            'You pick the colour, not the gender. The features are the same.',
          'intro.theme.rose' => 'Soft rose',
          'intro.theme.roseSupport' => 'Delicate and warm',
          'intro.theme.blue' => 'Soft blue',
          'intro.theme.blueSupport' => 'Calm and light',
          'intro.theme.neutral' => 'Neutral',
          'intro.theme.neutralSupport' => 'Paper and green',
          'intro.theme.footnote' => 'You can change it later in Settings, Appearance.',
          'invite.title' => ({required Object name}) => 'Invite ${name}',
          'invite.titleNoName' => 'Invite your person',
          'invite.messageIntro' => 'This message will be sent:',
          'invite.message' => ({
            required Object code,
          }) => 'I started something small for us. To connect in the app, use the code ${code}.',
          'invite.expiryNote' => ({
            required Object days,
          }) => 'The invite is valid for ${days} days. Only the latest invite you create works.',
          'invite.share' => 'Share invite',
          'invite.copy' => 'Copy invite',
          'invite.sentTitle' => 'Invite sent',
          'invite.sentHighlight' => 'sent',
          'invite.sentText' => ({
            required Object name,
          }) => '${name} has not joined yet. In the meantime you can use the app on your own.',
          'invite.sentTextNoName' =>
            'Your person has not joined yet. In the meantime you can use the app on your own.',
          'invite.resend' => 'Send again',
          'invite.revoke' => 'Revoke',
          'invite.errorTitle' => 'Could not create the invite',
          'invite.errors.ALREADY_PAIRED' => 'You are already connected with someone.',
          'invite.errors.RATE_LIMITED' => 'You created too many invites today. Try again tomorrow.',
          'invite.errors.NETWORK' => 'No connection. Check your internet and try again.',
          'invite.errors.other' => 'Something went wrong. Try again.',
          'invite.shareTitle' => 'Share invite',
          'invite.waitingTitle' => 'Waiting for your partner',
          'language.language' => 'Language',
          'language.languagePortuguese' => 'Portuguese (Brazil)',
          'language.languageEnglish' => 'English',
          'language.comingSoon' => 'Coming soon',
          'language.languageNote' => 'English is finished later.',
          'language.saveError' => 'Could not save. Try again.',
          'learned.title' => 'What I learned',
          'learned.intro' => 'Things you chose to keep from the conversation. Only you see them.',
          'learned.pendingTitle' => 'To review',
          'learned.confirmedTitle' => 'Confirmed',
          'learned.targets.partnerFact' => 'About my partner',
          'learned.targets.date' => 'A date',
          'learned.targets.memory' => 'A memory',
          'learned.targets.commitment' => 'A promise',
          'learned.confirm' => 'Confirm',
          'learned.edit' => 'Edit',
          'learned.discard' => 'Discard',
          'learned.confirmTitle' => 'Confirm this learning?',
          'learned.confirmText' => 'It will show in What I learned. Only you see it.',
          'learned.discardTitle' => 'Discard this learning?',
          'learned.discardText' => 'It will not be saved.',
          'learned.discardConfirm' => 'Discard',
          'learned.editTitle' => 'Edit learning',
          'learned.editHint' => 'What you want to keep',
          'learned.textErrors.empty' => 'Write what you want to keep',
          'learned.textErrors.tooLong' => 'This is too long',
          'learned.save' => 'Save',
          'learned.partnerFactLabel' => 'From the conversation',
          'learned.updated' => 'Learning updated',
          'learned.emptyTitle' => 'Nothing kept yet',
          'learned.emptyText' =>
            'When you want, save a reply from the conversation to remember it later.',
          'learned.errorTitle' => 'Couldn\'t load',
          'learned.errorText' => 'Try again in a moment.',
          'learned.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'learned.errors.other' => 'Couldn\'t do that right now. Try again.',
          'lists.title' => 'Lists',
          'lists.subtitle' => 'Trips, places and films, shared or just for you.',
          'lists.newList' => 'New list',
          'lists.createTitle' => 'New list',
          'lists.titleLabel' => 'Name',
          'lists.titleHint' => 'E.g. Trips of our dreams',
          'lists.titleErrors.empty' => 'Give the list a name.',
          'lists.titleErrors.tooLong' => 'Use at most 80 characters.',
          'lists.kindLabel' => 'Type',
          'lists.visibilityLabel' => 'Who can see it',
          'lists.sharedHint' => 'You both can see and change this list.',
          'lists.privateHint' => 'Only you can see this list.',
          'lists.kinds.travel' => 'Travel',
          'lists.kinds.restaurants' => 'Restaurants',
          'lists.kinds.movies' => 'Movies',
          'lists.kinds.custom' => 'Other',
          'lists.kinds.other' => '',
          'lists.shared' => 'Shared',
          'lists.private' => 'Private',
          'lists.emptyTitle' => 'No lists yet',
          'lists.emptyTextShared' => 'Start a list of things you want to do together.',
          'lists.emptyTextPrivate' => 'Start a list of things you want to keep for yourself.',
          'lists.create' => 'Create list',
          'lists.rename' => 'Rename',
          'lists.delete' => 'Delete',
          'lists.renameTitle' => 'Rename list',
          'lists.save' => 'Save',
          'lists.deleteTitle' => 'Delete list?',
          'lists.deleteTextShared' => 'The list and everything in it will be gone for both of you.',
          'lists.deleteTextPrivate' => 'The list and everything in it will be gone for good.',
          'lists.deleteConfirm' => 'Delete',
          'lists.itemDeleteTitle' => 'Delete item?',
          'lists.itemDeleteTextShared' => 'This item will be gone for both of you.',
          'lists.itemDeleteTextPrivate' => 'This item will be gone for good.',
          'lists.itemDeleteConfirm' => 'Delete item',
          'lists.makePrivate' => 'Make private',
          'lists.shareWithPartner' => 'Share with your partner',
          'lists.addItem' => 'Add item',
          'lists.itemHint' => 'E.g. Lisbon',
          'lists.itemTitleErrors.empty' => 'Type the item name.',
          'lists.itemTitleErrors.tooLong' => 'Use at most 160 characters.',
          'lists.add' => 'Add',
          'lists.itemEmptyTitle' => 'Nothing here yet',
          'lists.itemEmptyTextShared' => 'Add the first thing you want to do together.',
          'lists.itemEmptyTextPrivate' => 'Add the first thing to this list.',
          'lists.statuses.dream' => 'Dream',
          'lists.statuses.planned' => 'Planned',
          'lists.statuses.done' => 'Done',
          'lists.statuses.other' => '',
          'lists.markDream' => 'Mark as a dream',
          'lists.markPlanned' => 'Mark as planned',
          'lists.markDone' => 'Mark as done',
          'lists.moveUp' => 'Move up',
          'lists.moveDown' => 'Move down',
          'lists.itemOptions' => 'Item options',
          'lists.listOptions' => 'List options',
          'lists.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'lists.errors.other' => 'Couldn\'t do that right now. Try again.',
          'logistics.title' => 'Logistics',
          'logistics.subtitle' => 'The practical things, with nobody carrying them alone.',
          'logistics.hint' => 'E.g. call the plumber',
          'logistics.add' => 'Add',
          'logistics.me' => 'Me',
          'logistics.partner' => 'My partner',
          'logistics.both' => 'Both of us',
          'logistics.assignMe' => 'I\'ll take it',
          'logistics.delete' => 'Delete',
          'logistics.doneTitle' => 'Done',
          'logistics.emptyTitle' => 'Nothing here',
          'logistics.emptyText' => 'Add something practical you need to sort out.',
          'logistics.errorTitle' => 'Couldn\'t load',
          'logistics.errorText' => 'The list is still saved. Try again.',
          'logistics.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'logistics.errors.other' => 'Couldn\'t do that right now. Try again.',
          'logistics.confirm' => 'Confirm',
          'logistics.waitingYou' => 'Waiting for you',
          'logistics.waitingPartner' => 'Waiting for the other person',
          'loveStyle.questionOf' => ({
            required Object current,
            required Object total,
          }) => 'Question ${current} of ${total}',
          'loveStyle.questions.0' => 'What makes you feel loved the most?',
          'loveStyle.questions.1' => 'On a hard day, what comforts you the most?',
          'loveStyle.questions.2' => 'What do you notice first when your partner shows care?',
          'loveStyle.questions.3' => 'Which of these gestures warms your heart?',
          'loveStyle.questions.4' => 'What makes you feel important to someone?',
          'loveStyle.questions.5' => 'If you could choose one gesture for today, what would it be?',
          'loveStyle.questionHighlights.0' => 'loved',
          'loveStyle.questionHighlights.1' => 'comforts',
          'loveStyle.questionHighlights.2' => 'care',
          'loveStyle.questionHighlights.3' => 'heart',
          'loveStyle.questionHighlights.4' => 'important',
          'loveStyle.questionHighlights.5' => 'gesture',
          'loveStyle.options1.time' => 'Spending unhurried time together.',
          'loveStyle.options1.words' => 'Hearing that I matter.',
          'loveStyle.options1.acts' => 'Seeing the person help me with something.',
          'loveStyle.options1.gifts' => 'Getting a small gift for no reason.',
          'loveStyle.options1.touch' => 'A long hug.',
          'loveStyle.options1.other' => '',
          'loveStyle.options2.time' => 'Having someone nearby, with no rush to fix it.',
          'loveStyle.options2.words' => 'A message saying I\'m on their mind.',
          'loveStyle.options2.acts' => 'Someone taking a task off my hands.',
          'loveStyle.options2.gifts' => 'A small care that arrived by surprise.',
          'loveStyle.options2.touch' => 'A tight hug.',
          'loveStyle.options2.other' => '',
          'loveStyle.options3.time' => 'When the person puts the phone down to be with me.',
          'loveStyle.options3.words' => 'When the person praises something I did.',
          'loveStyle.options3.acts' => 'When the person notices what I need and does it.',
          'loveStyle.options3.gifts' => 'When the person remembers something I like.',
          'loveStyle.options3.touch' => 'When the person touches me lightly as they pass.',
          _ => null,
        } ??
        switch (path) {
          'loveStyle.options3.other' => '',
          'loveStyle.options4.time' => 'A quiet date, just the two of us.',
          'loveStyle.options4.words' => 'A conversation where I feel heard.',
          'loveStyle.options4.acts' => 'A small help with a task.',
          'loveStyle.options4.gifts' => 'A simple gift that has to do with me.',
          'loveStyle.options4.touch' => 'A caress on my hair or hand.',
          'loveStyle.options4.other' => '',
          'loveStyle.options5.time' => 'When someone chooses to spend time with me.',
          'loveStyle.options5.words' => 'When someone acknowledges what I do.',
          'loveStyle.options5.acts' => 'When someone makes my day easier.',
          'loveStyle.options5.gifts' => 'When someone remembers me with a detail.',
          'loveStyle.options5.touch' => 'When someone hugs me without needing to speak.',
          'loveStyle.options5.other' => '',
          'loveStyle.options6.time' => 'Saving a free evening for us.',
          'loveStyle.options6.words' => 'Writing a loving note.',
          'loveStyle.options6.acts' => 'Tackling a boring task together.',
          'loveStyle.options6.gifts' => 'Picking a small gift.',
          'loveStyle.options6.touch' => 'Holding hands.',
          'loveStyle.options6.other' => '',
          'loveStyle.continueAction' => 'Next',
          'loveStyle.finishAction' => 'See result',
          'loveStyle.back' => 'Back',
          'loveStyle.privateNote' =>
            'Only you see your answers. You choose whether to show the result.',
          'loveStyle.resultTitle' => 'What makes you feel loved',
          'loveStyle.resultHighlight' => 'loved',
          'loveStyle.resultSubtitle' => 'A reading of what fits you best.',
          'loveStyle.labels.time' => 'Time just for us',
          'loveStyle.labels.words' => 'Words of care',
          'loveStyle.labels.acts' => 'Help with tasks',
          'loveStyle.labels.gifts' => 'Small gifts',
          'loveStyle.labels.touch' => 'Touch and hugs',
          'loveStyle.labels.other' => '',
          'loveStyle.commonLabels.time' => 'time just for us',
          'loveStyle.commonLabels.words' => 'words of care',
          'loveStyle.commonLabels.acts' => 'help with tasks',
          'loveStyle.commonLabels.gifts' => 'small gifts',
          'loveStyle.commonLabels.touch' => 'touch and hugs',
          'loveStyle.commonLabels.other' => '',
          'loveStyle.descriptions.time' => 'You feel loved when you have real time with someone you care about: unhurried, no screens, just presence.',
          'loveStyle.descriptions.words' =>
            'You feel loved when you hear, honestly, what the other person feels for you.',
          'loveStyle.descriptions.acts' =>
            'You feel loved when someone notices what you need and helps without being asked.',
          'loveStyle.descriptions.gifts' =>
            'You feel loved when someone remembers you in a small detail, chosen with care.',
          'loveStyle.descriptions.touch' =>
            'You feel loved when a hug, a held hand or a caress says what words cannot.',
          'loveStyle.descriptions.other' => '',
          'loveStyle.resultPrivacyNote' =>
            'Saved only for you until you show it. You can undo it whenever you want.',
          'loveStyle.saveManualAction' => 'Save to My manual',
          'loveStyle.savedManualAction' => 'Saved to My manual',
          'loveStyle.manualToast' => 'Saved to My manual.',
          'loveStyle.shareAction' => ({required Object name}) => 'Show ${name}',
          'loveStyle.revokeAction' => ({required Object name}) => 'Stop showing ${name}',
          'loveStyle.shareConfirmTitle' => ({required Object name}) => 'Show ${name}?',
          'loveStyle.shareConfirmText' => ({
            required Object name,
          }) => 'Only the result appears, never your answers. ${name} gets a notice and may choose not to respond.',
          'loveStyle.shareConfirm' => 'Show',
          'loveStyle.shareCancel' => 'Not now',
          'loveStyle.shareToast' => ({
            required Object name,
          }) => 'Done. ${name} can see the result now.',
          'loveStyle.revokeToast' => ({required Object name}) => '${name} can no longer see it.',
          'loveStyle.shareSoloNote' =>
            'It stays with you. When someone joins, you decide whether to show it.',
          'loveStyle.inviteAction' => 'Invite my person',
          'loveStyle.compareAction' => 'Compare the two',
          'loveStyle.compareTitle' => 'The two of you',
          'loveStyle.compareHeadline' => 'What makes you both feel loved',
          'loveStyle.compareHighlight' => 'both',
          'loveStyle.compareYou' => 'You',
          'loveStyle.compareMost' => 'Most important',
          'loveStyle.compareNext' => 'Then',
          'loveStyle.compareCommon' => 'In common',
          'loveStyle.compareCommonText' => ({required Object label}) => 'You both value ${label}.',
          'loveStyle.comparePlan' => 'Plan time just for us',
          'loveStyle.compareMissingTitle' => 'The comparison is not ready yet',
          'loveStyle.compareMissingText' => 'It appears when both of you have shown your result.',
          'loveStyle.partnerFallback' => 'your partner',
          'loveStyle.pairingErrorNote' => 'Couldn\'t check your partner right now.',
          'loveStyle.retryPairing' => 'Try again',
          'loveStyle.retake' => 'Take the quiz again',
          'loveStyle.loadErrorTitle' => 'Couldn\'t load',
          'loveStyle.loadErrorText' => 'Couldn\'t open your result right now. Try again.',
          'loveStyle.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'loveStyle.errors.other' => 'Couldn\'t save right now. Your answers are still here.',
          'loveStyle.manualErrors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'loveStyle.manualErrors.other' => 'Couldn\'t save to My manual right now. Try again.',
          'loveStyle.shareErrors.NOT_PAIRED' => 'You don\'t have a connected partner yet.',
          'loveStyle.shareErrors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'loveStyle.shareErrors.other' => 'Couldn\'t show it right now. Try again.',
          'loveStyle.revokeErrors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'loveStyle.revokeErrors.other' => 'Couldn\'t stop showing it right now. Try again.',
          'memories.title' => 'Memories',
          'memories.historyLabel' => 'OUR HISTORY',
          'memories.historyTitle' => 'Our history',
          'memories.historyText' => 'Milestones, dates, places and our story in numbers.',
          'memories.placesLabel' => 'PLACES',
          'memories.placesText' => 'Only the name of the place, never the location.',
          'memories.placeLabel' => 'Place (optional)',
          'memories.placeHint' => 'E.g. Lisbon',
          'memories.placeAddressNote' =>
            'Prefer just the name of the place, with no address or number.',
          'memories.segmentTimeline' => 'Timeline',
          'memories.segmentJar' => 'Jar',
          'memories.jarEmpty' => 'When a slip feels good, keep it in the jar from its details.',
          'memories.jarAnother' => 'Another',
          'memories.jarClose' => 'Close',
          'memories.titleLabel' => 'A memory',
          'memories.titleHint' => 'E.g. our first dinner',
          'memories.titleErrors.empty' => 'Give this memory a title',
          'memories.titleErrors.tooLong' => 'The title is too long',
          'memories.placeErrors.tooLong' => 'The place is too long',
          'memories.bodyErrors.tooLong' => 'The note is too long',
          'memories.bodyHint' => 'Tell how it went (optional)',
          'memories.add' => 'Add a memory',
          'memories.save' => 'Save memory',
          'memories.delete' => 'Delete',
          'memories.deleteTitle' => 'Delete this memory?',
          'memories.deleteText' => 'It disappears from the timeline for both of you.',
          'memories.deleteConfirm' => 'Delete',
          'memories.detailPlace' => 'Place',
          'memories.detailBody' => 'How it went',
          'memories.monthsShort.0' => 'Jan',
          'memories.monthsShort.1' => 'Feb',
          'memories.monthsShort.2' => 'Mar',
          'memories.monthsShort.3' => 'Apr',
          'memories.monthsShort.4' => 'May',
          'memories.monthsShort.5' => 'Jun',
          'memories.monthsShort.6' => 'Jul',
          'memories.monthsShort.7' => 'Aug',
          'memories.monthsShort.8' => 'Sep',
          'memories.monthsShort.9' => 'Oct',
          'memories.monthsShort.10' => 'Nov',
          'memories.monthsShort.11' => 'Dec',
          'memories.dateLine' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'memories.emptyTitle' => 'No memories yet',
          'memories.emptyText' => 'Keep moments you want to look back on.',
          'memories.errorTitle' => 'Couldn\'t load',
          'memories.errorText' => 'Your memories are still saved. Try again.',
          'memories.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'memories.errors.other' => 'Couldn\'t do that right now. Your text is still here.',
          'memories.jarEmptyTitle' => 'The jar is empty',
          'memories.jarEmptyAction' => 'See my slips',
          'memories.menu.timeline' => 'Timeline',
          'memories.menu.timelineText' => 'Memories you kept',
          'memories.menu.jar' => 'Jar',
          'memories.menu.jarText' => 'A good slip for a bad day',
          'memories.menu.storyText' => 'Milestones, places and numbers',
          'memories.menu.dates' => 'Dates and numbers',
          'memories.menu.datesText' => 'Anniversaries, holidays and counts',
          'memories.menu.diary' => 'Diary',
          'memories.menu.diaryText' => 'Only yours, never goes to the other person',
          'memories.menu.gifts' => 'Gift ideas',
          'memories.menu.giftsText' => 'Each one\'s wishes and ideas for the other',
          'memories.onThisDay.label' => 'ON THIS DAY',
          'memories.onThisDay.yearsAgo' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 year ago',
                  other: '${count} years ago',
                ),
          'mood.title' => 'How are you today?',
          'mood.titleHighlight' => 'today',
          'mood.subtitle' => 'One tap. The “I need…” tag is optional.',
          'mood.privateCue' => 'Only you see this',
          'mood.sharedCue' => ({required Object name}) => 'shared with ${name}',
          'mood.sharedCueNoName' => 'shared with your partner',
          'mood.moods.happy' => 'Happy',
          'mood.moods.tired' => 'Tired',
          'mood.moods.sad' => 'Sad',
          'mood.moods.stressed' => 'Stressed',
          'mood.moods.loving' => 'Loving',
          'mood.moods.playful' => 'Playful',
          'mood.needTitle' => 'I need…',
          'mood.needs.listen' => 'To be heard',
          'mood.needs.opinion' => 'An opinion',
          'mood.needs.hug' => 'A hug',
          'mood.needs.space' => 'Some space',
          'mood.needs.chocolate' => 'Chocolate',
          'mood.needs.cuteMessage' => 'A cute message',
          'mood.needs.foreheadKiss' => 'A kiss on the forehead',
          'mood.needs.company' => 'Some company',
          'mood.needs.rest' => 'To rest',
          'mood.needMenuAction' => 'I need…',
          'mood.needMenuActionSelected' => ({required Object need}) => 'I need: ${need}',
          'mood.needSheetSubtitle' =>
            'One thing a day. Your partner sees it only if you share your mood.',
          'mood.needSaved' => 'Saved',
          'mood.shareSubtitle' => 'You decide. Nothing is shared by default.',
          'mood.shareNeedFirst' => 'Pick an “I need…” first.',
          'mood.share.none' => 'Keep private',
          'mood.share.mood' => 'Only my mood',
          'mood.share.moodNeed' => 'Mood and what I need',
          'mood.shareSupport.none' => 'Nothing is shared.',
          'mood.shareSupport.mood' => 'Your partner sees the mood only.',
          'mood.shareSupport.moodNeed' => 'Your partner sees the mood and the need.',
          'mood.privacyNote' =>
            'Nothing is shared by default. Your partner never sees a chart or a score.',
          'mood.save' => 'Save',
          'mood.saved' => 'Mood saved',
          'mood.errors.NETWORK' => 'Couldn\'t save your mood. Check your connection and try again.',
          'mood.errors.TIMEOUT' => 'Couldn\'t save your mood in time. Try again.',
          'mood.errors.other' => 'Couldn\'t save your mood. Try again.',
          'mood.entryCategory' => 'Mood of the day',
          'mood.entryTitle' => 'How are you today?',
          'mood.entryText' => 'One tap. Only you see it until you share.',
          'mood.partnerLabel' => 'Your partner\'s mood',
          'mood.partnerFallback' => 'Your partner',
          'mood.partnerHappy' => ({required Object name}) => '${name} is happy today',
          'mood.partnerTired' => ({required Object name}) => '${name} is out of energy today',
          'mood.partnerSad' => ({required Object name}) => '${name} is feeling low today',
          'mood.partnerStressed' => ({
            required Object name,
          }) => '${name} has a lot on their mind today',
          'mood.partnerLoving' => ({required Object name}) => '${name} is feeling tender today',
          'mood.partnerPlayful' => ({required Object name}) => '${name} is in a playful mood today',
          'mood.partnerNeedListen' => 'What helps: just listening.',
          'mood.partnerNeedOpinion' => 'What helps: an opinion.',
          'mood.partnerNeedHug' => 'What helps: a hug.',
          'mood.partnerNeedSpace' => 'What helps: some space.',
          'mood.partnerNeedChocolate' => 'What helps: some chocolate.',
          'mood.partnerNeedCuteMessage' => 'What helps: a cute message.',
          'mood.partnerNeedForeheadKiss' => 'What helps: a kiss on the forehead.',
          'mood.partnerNeedCompany' => 'What helps: some company.',
          'mood.partnerNeedRest' => 'What helps: rest.',
          'mood.partnerSharedChoice' => ({
            required Object name,
          }) => '${name} chose to share this with you.',
          'mood.homeTitle' => 'How are you?',
          'mood.homePrivacy' => 'Only you see it',
          'mood.homePrivacyShared' => ({required Object name}) => '${name} sees it',
          'mood.homePrivacySharedNoName' => 'Your partner sees it',
          'mood.homeLoadFailed' => 'Couldn\'t load it. Tap to open.',
          'mood.homeDetailsLink' => 'What your partner sees',
          'mood.homeMoods.happy' => 'Good',
          'mood.homeMoods.loving' => 'Loving',
          'mood.homeMoods.tired' => 'Tired',
          'mood.homeMoods.stressed' => 'Tense',
          'mood.homeMoods.sad' => 'Sad',
          'mood.next' => 'Next',
          'mood.shareAction' => 'Share',
          'mood.shareHeadline' => ({required Object name}) => 'Share with ${name}?',
          'mood.shareHeadlineNoName' => 'Share with your person?',
          'mood.shareHeadlineNoNameHighlight' => 'your person',
          'mood.calendarTitle' => 'My moods',
          'mood.calendarMonth' => ({
            required Object month,
            required Object year,
          }) => '${month} ${year}',
          'mood.calendarEmpty' => 'No mood recorded this month yet.',
          'mood.calendarPrivacyNote' => 'Only you see this. It never shows up for your partner unless it was shared for the day.',
          'mood.calendarAction' => 'Record my mood',
          'mood.calendarErrorTitle' => 'Couldn\'t open your moods',
          'mood.calendarErrorText' => 'Nothing was lost. Try again.',
          'mood.monthNames.0' => 'January',
          'mood.monthNames.1' => 'February',
          'mood.monthNames.2' => 'March',
          'mood.monthNames.3' => 'April',
          'mood.monthNames.4' => 'May',
          'mood.monthNames.5' => 'June',
          'mood.monthNames.6' => 'July',
          'mood.monthNames.7' => 'August',
          'mood.monthNames.8' => 'September',
          'mood.monthNames.9' => 'October',
          'mood.monthNames.10' => 'November',
          'mood.monthNames.11' => 'December',
          'moodHelp.listenTitle' => 'Listen first',
          'moodHelp.listenSubtitle' => 'No rush, no pressure to answer.',
          'moodHelp.talkLabel' => 'Talk',
          'moodHelp.askToTalk' => 'Ask if they want to talk',
          'moodHelp.askToTalkSupport' => 'An open question, with no rush for an answer.',
          'moodHelp.careLabel' => 'Care',
          'moodHelp.sendLove' => 'Send a little love',
          'moodHelp.sendLoveSupport' => 'A hug arrives as a signal in the app.',
          'moodHelp.helpLabel' => 'Help',
          'moodHelp.seeHowToHelp' => 'See how to help',
          'moodHelp.seeHowToHelpSupport' => 'Small things for today.',
          'moodHelp.helpTitle' => 'How to help today',
          'moodHelp.helpSubtitle' => 'Small things, at today\'s pace.',
          'moodHelp.suggestionLabel' => 'Suggestion',
          'moodHelp.takeChore' => 'Take on a chore',
          'moodHelp.takeChoreSupport' => 'Pick one thing at home and handle it without asking.',
          'moodHelp.askListenOrSpace' => 'Ask: do you want to talk or have space?',
          'moodHelp.askListenOrSpaceSupport' => 'Let the answer choose the next step.',
          'moodHelp.sendSweetMessage' => 'Send a short, sweet message',
          'moodHelp.sweetMessagePreview' => ({required Object body}) => 'It reads: “${body}”',
          'moodHelp.sweetMessageBody' => 'No rush. I\'m here.',
          'moodHelp.makeCoffeeOrDinner' => 'Make coffee or dinner',
          'moodHelp.makeCoffeeOrDinnerSupport' => 'Without turning it into a shared task.',
          'moodHelp.noDiagnosisNote' => 'App suggestions, not a diagnosis. No rush.',
          'moodHelp.reactionLabel' => 'Send a heart',
          'moodHelp.sent' => 'Heart sent',
          'moodHelp.askSent' => 'Question sent',
          'moodHelp.messageSent' => 'Message sent',
          'moodHelp.partnerNeedTitle' => ({required Object name}) => 'What ${name} needs',
          'moodHelp.partnerNeedTitleGeneric' => 'What your partner needs',
          'moodHelp.partnerNeedSubtitle' => 'Today\'s ask. No pressure.',
          'moodHelp.partnerNeedNote' => 'This comes from the mood your partner shared today.',
          'moodHelp.partnerNeedActions.listen' => 'Just listen',
          'moodHelp.partnerNeedActions.opinion' => 'Give an opinion',
          'moodHelp.partnerNeedActions.hug' => 'Send a hug',
          'moodHelp.partnerNeedActions.space' => 'Give some space',
          'moodHelp.partnerNeedActions.chocolate' => 'Bring some chocolate',
          'moodHelp.partnerNeedActions.cuteMessage' => 'Open the chat',
          'moodHelp.partnerNeedActions.foreheadKiss' => 'A kiss on the forehead',
          'moodHelp.partnerNeedActions.company' => 'Stay close',
          'moodHelp.partnerNeedActions.rest' => 'Let them rest',
          'moodHelp.partnerNeedActions.other' => '',
          'moodHelp.partnerNeedSupports.listen' => 'No advice, no fixing.',
          'moodHelp.partnerNeedSupports.opinion' => 'An honest opinion, without judging.',
          'moodHelp.partnerNeedSupports.hug' => 'It arrives as a signal in the app.',
          'moodHelp.partnerNeedSupports.space' => 'Some time without asking for an answer.',
          'moodHelp.partnerNeedSupports.chocolate' => 'A small chocolate, no reason needed.',
          'moodHelp.partnerNeedSupports.cuteMessage' => 'One kind line is enough.',
          'moodHelp.partnerNeedSupports.foreheadKiss' => 'Small and unhurried.',
          'moodHelp.partnerNeedSupports.company' => 'Sit nearby, no words needed.',
          'moodHelp.partnerNeedSupports.rest' => 'Take what you can off their plate.',
          'moodHelp.partnerNeedSupports.other' => '',
          'moodHelp.errors.NOT_PAIRED' => 'You are not connected yet.',
          'moodHelp.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'moodHelp.errors.NETWORK' =>
            'Couldn\'t send it now. Check your connection and try again.',
          'moodHelp.errors.TIMEOUT' => 'Couldn\'t send it in time. Try again.',
          'moodHelp.errors.other' => 'Couldn\'t send it now. Try again.',
          'need.title' => 'I need…',
          'need.titleHighlight' => 'need',
          'need.subtitle' => 'Pick one thing. Your partner gets a gentle note, no pressure.',
          'need.options.hug' => 'A hug',
          'need.options.talk' => 'To talk',
          'need.options.help_home' => 'Help at home',
          'need.options.quiet' => 'Some quiet time',
          'need.options.time_together' => 'Time together',
          'need.options.rest' => 'To rest',
          'need.options.other' => '',
          'need.note' => 'It\'s not a demand. It\'s just a simple way to ask.',
          'need.send' => 'Send',
          'need.sent.title' => 'Sent',
          'need.sent.text' => 'Your partner will see it when they open the app.',
          'need.sent.done' => 'Done',
          'need.errors.NOT_PAIRED' =>
            'To send this, you need to be connected with your partner in the app.',
          'need.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'need.errors.other' => 'Couldn\'t send right now. Try again.',
          'notFound.title' => '404',
          'notFound.description' => 'Page not found',
          'notFound.buttonBack' => 'Go back home',
          'notes.title' => 'A note or a drawing',
          'notes.intro' =>
            'A short note for your partner, or a drawing that stays in your sent list.',
          'notes.kinds.0' => 'Note',
          'notes.kinds.1' => 'Drawing',
          'notes.noteHint' => 'E.g. good luck at today\'s meeting',
          'notes.textErrors.empty' => 'Write the note first',
          'notes.textErrors.tooLong' => 'This note is too long',
          'notes.canvasLabel' => 'Drawing area',
          'notes.pens.0' => 'Black',
          'notes.pens.1' => 'Orange',
          'notes.pens.2' => 'Purple',
          'notes.pens.3' => 'Green',
          'notes.eraser' => 'Eraser',
          'notes.undo' => 'Undo',
          'notes.clear' => 'Clear',
          'notes.emptyDrawing' => 'Draw something to be able to send it.',
          'notes.startDrawing' => 'Draw',
          'notes.continueDrawing' => 'Keep drawing',
          'notes.done' => 'Done',
          'notes.widgetLabel' => 'Send to the widget',
          'notes.widgetText' => 'It appears on their widget if they allow notes.',
          'notes.drawingHint' =>
            'Drawings stay in your sent list. Widget notes are text-only for now.',
          'notes.unpairedTitle' => 'Connect with your partner',
          'notes.unpairedText' =>
            'You need to be connected with your partner to send a note or drawing.',
          'notes.send' => 'Send',
          'notes.sent' => 'Sent',
          'notes.sentTitle' => 'Sent by you',
          'notes.justNow' => 'Just now',
          'notes.minutesAgo' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 min ago',
                  other: '${count} min ago',
                ),
          'notes.hoursAgo' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 h ago',
                  other: '${count} h ago',
                ),
          'notes.daysAgo' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 day ago',
                  other: '${count} days ago',
                ),
          'notes.drawingAlt' => 'Drawing',
          'notes.delete' => 'Delete',
          'notes.deleteConfirmTitle' => 'Delete this?',
          'notes.deleteConfirmText' =>
            'It leaves your sent list. Notes also leave your partner\'s widget.',
          'notes.deleteConfirm' => 'Delete now',
          'notes.deleted' => 'Deleted',
          'notes.deleteError' => 'Couldn\'t delete right now. Try again.',
          'notes.emptyTitle' => 'Nothing sent yet',
          'notes.emptyText' => 'When you send a note or a drawing, it shows up here.',
          'notes.errorTitle' => 'Couldn\'t load',
          'notes.errorText' => 'Try again in a moment.',
          'notes.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'notes.errors.NOT_PAIRED' =>
            'To send this, you need to be connected with your partner in the app.',
          'notes.errors.other' => 'Couldn\'t send right now. What you wrote is still here.',
          'notificationPermission.label' => 'Reminders',
          'notificationPermission.title' => 'Gentle reminders?',
          'notificationPermission.titleHighlight' => 'Gentle',
          'notificationPermission.pointLimit' => 'At most 1 or 2 a day.',
          'notificationPermission.pointPrivate' => 'They never show names on the lock screen.',
          'notificationPermission.pointChoice' => 'You choose what arrives and when.',
          'notificationPermission.changeLater' => 'You can change this whenever you like.',
          'notificationPermission.notNow' => 'Not now',
          'notificationPermission.allow' => 'Allow',
          'notificationPermission.registrationFailed' =>
            'The system allowed reminders, but we couldn\'t connect this phone.',
          'notificationPermission.retryRegistration' => 'Try again',
          'notificationPermission.continueWithoutReminders' => 'Continue without reminders',
          'notificationPermission.offBanner' => 'Reminders are off. Turn them on in settings.',
          'notificationPermission.openSettings' => 'Open settings',
          'notificationPermission.close' => 'Close',
          'notificationPermission.errors.registerDevice' =>
            'Could not turn notifications on for this phone. Try again later.',
          'notificationPermission.errors.other' => 'Could not turn notifications on. Try again.',
          'notificationPreferences.title' => 'Reminders',
          'notificationPreferences.systemOff' =>
            'Notifications are off on this phone. Your choices apply when you turn them on.',
          'notificationPreferences.openSystem' => 'Open settings',
          'notificationPreferences.perDayTitle' => 'Per day',
          'notificationPreferences.perDaySupport' => 'At most',
          'notificationPreferences.perDayValue' => ({required Object count}) => 'Up to ${count}',
          'notificationPreferences.perDaySheetTitle' => 'How many reminders a day?',
          'notificationPreferences.typesTitle' => 'Types',
          'notificationPreferences.types.dailyIdea' => 'Idea of the day',
          'notificationPreferences.types.dateComing' => 'Dates and holidays',
          'notificationPreferences.types.cardReady' => 'Weekly card',
          'notificationPreferences.types.other' => '',
          'notificationPreferences.days.0' => 'Sunday',
          'notificationPreferences.days.1' => 'Monday',
          'notificationPreferences.days.2' => 'Tuesday',
          'notificationPreferences.days.3' => 'Wednesday',
          'notificationPreferences.days.4' => 'Thursday',
          'notificationPreferences.days.5' => 'Friday',
          'notificationPreferences.days.6' => 'Saturday',
          'notificationPreferences.hourFormat' => ({required Object hour}) => '${hour}:00',
          'notificationPreferences.note' =>
            'A hard limit of 1 to 2 messages a day. Each type can be switched off.',
          'notificationPreferences.loadErrorTitle' => 'Could not open your reminders',
          'notificationPreferences.loadErrorText' => 'They are still saved. Try again.',
          'notificationPreferences.errors.rateLimited' => 'Too many tries in a row. Wait a moment.',
          'notificationPreferences.errors.other' =>
            'Could not save now. Your previous choice was kept.',
          'partnerProfile.title' => 'About your partner',
          'partnerProfile.privateNote' => 'Only you see these notes. They never show in notifications, widgets or to your partner.',
          'partnerProfile.categories.likes' => 'Likes',
          'partnerProfile.categories.dislikes' => 'Dislikes',
          'partnerProfile.categories.sizes' => 'Sizes',
          'partnerProfile.categories.health' => 'Health',
          'partnerProfile.categories.comfort' => 'Comfort',
          'partnerProfile.categories.people' => 'People',
          'partnerProfile.categories.other' => 'Other',
          'partnerProfile.labelLabel' => 'Topic',
          'partnerProfile.labelHint' => 'E.g. coffee',
          'partnerProfile.labelErrors.empty' => 'Give the note a topic.',
          'partnerProfile.labelErrors.tooLong' => 'Use at most 80 characters.',
          'partnerProfile.valueHint' => 'E.g. no sugar, very hot',
          'partnerProfile.valueErrors.empty' => 'Write what you want to remember.',
          'partnerProfile.valueErrors.tooLong' => 'Use at most 500 characters.',
          'partnerProfile.save' => 'Save note',
          'partnerProfile.delete' => 'Delete',
          'partnerProfile.emptyTitle' => 'No notes yet',
          'partnerProfile.emptyText' => 'Small details help you pick a gift or a gesture.',
          'partnerProfile.errorTitle' => 'Couldn\'t load',
          'partnerProfile.errorText' => 'Your notes are still saved. Try again.',
          'partnerProfile.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'partnerProfile.errors.other' => 'Couldn\'t do that right now. Your text is still here.',
          'partnerStep.title' => 'Want to bring your partner?',
          'partnerStep.titleHighlight' => 'partner',
          'partnerStep.subtitle' => 'The app works on your own. Invite whenever you want.',
          'partnerStep.inviteTitle' => 'Send an invite',
          'partnerStep.inviteSupport' => 'Your person joins with a code',
          'partnerStep.aloneTitle' => 'Start on my own for now',
          'partnerStep.aloneSupport' => 'Your slips stay with you only',
          'partnerStep.haveCode' => 'I have an invite code',
          'partnerStep.continueButton' => 'Continue',
          'partnerStep.soloOnlyTitle' => 'Just for me',
          'partnerStep.soloOnlySupport' => 'Without inviting anyone',
          'partnerStep.whyInvite' => 'Why invite?',
          'partnerStep.why.title' => 'Why invite?',
          'partnerStep.why.shared' => 'Shared cards and tools need both of you.',
          'partnerStep.why.privacy' =>
            'Your slips and private notes stay yours until you share them.',
          'plus.title' => 'Mingo Plus',
          'plus.subtitle' => 'Compare calmly. The free plan stays whole for the essentials.',
          'plus.activeTitle' => 'You have Plus',
          'plus.activeText' => 'Thank you. Everything is unlocked for you and your partner.',
          'plus.paidByPartner' => 'Your partner has Plus and it covers you both.',
          'plus.freeLeft' => ({
            required Object games,
            required Object rituals,
            required Object lists,
          }) => 'On the free plan you have ${games}, ${rituals} and ${lists} left.',
          'plus.gameCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 game this week',
                  other: '${count} games this week',
                ),
          'plus.ritualCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 ritual',
                  other: '${count} rituals',
                ),
          'plus.listCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 list',
                  other: '${count} lists',
                ),
          'plus.freeName' => 'Free',
          'plus.freeFeatures' => 'Unlimited slips and cards, repair, 3 games a week, 3 rituals, 3 lists and everything you already saved.',
          'plus.plusName' => 'Plus',
          'plus.plusFeatures' => 'Unlimited games, rituals and lists, more chats with the mascot and more for both of you, covering you and your partner.',
          'plus.monthly' => 'Monthly',
          'plus.yearly' => 'Yearly',
          'plus.storeTitle' => 'Couldn\'t load the prices',
          'plus.storeText' => 'The store didn\'t answer. Nothing was charged. Try again.',
          'plus.subscribe' => 'Subscribe',
          'plus.started' => 'Plus is on. Thank you.',
          'plus.pending' => 'Purchase received. We\'re confirming, Plus will show up shortly.',
          'plus.purchaseError' => 'Couldn\'t complete the purchase. Nothing was charged.',
          'plus.billingTitle' => 'Payment problem',
          'plus.billingText' => 'The last payment didn\'t go through. Plus stays on for now. Open your subscriptions in the store and update the payment method.',
          'plus.alwaysFree' => 'Unpairing is never locked.',
          'plus.lockLabel' => 'PLUS',
          'plus.lockText' => 'Available with Plus. Tap to see the plans.',
          'plus.errorTitle' => 'Couldn\'t load',
          'plus.errorText' => 'Try again in a moment.',
          'plus.manageTitle' => 'Manage Plus',
          'plus.planRow' => 'Plan',
          'plus.statusRow' => 'Status',
          'plus.coversRow' => 'Covers',
          'plus.coversBoth' => 'You and your partner',
          'plus.coveredByPartner' => 'Your partner',
          'plus.plusActive' => 'Plus active',
          'plus.statusActive' => 'Active',
          'plus.statusTrialing' => 'Trial',
          'plus.statusGrace' => 'Payment pending',
          'plus.statusBillingIssue' => 'Payment problem',
          'plus.manageInStore' => 'Manage in store',
          'plus.seePlus' => 'See Plus',
          'plus.managePlan' => 'Manage plan',
          'plus.restorePurchases' => 'Restore purchases',
          'plus.partnerPays' => 'Your partner looks after this subscription.',
          'plus.partnerCancel' =>
            'If either partner cancels, Plus ends for both, with a clear notice.',
          'plus.storeIssueTitle' => 'The store didn\'t open',
          'plus.restoreLoadingTitle' => 'Restoring purchases',
          'plus.restoreLoadingText' => 'This takes a few seconds.',
          'plus.restoredTitle' => 'Purchases restored',
          'plus.restoredHighlight' => 'restored',
          'plus.restoredText' => 'We found your Plus in the store.',
          'plus.pendingRestoreTitle' => 'We found a purchase',
          'plus.pendingRestoreHighlight' => 'purchase',
          'plus.pendingRestoreText' =>
            'It can take a moment, or sign in with the account that bought it.',
          'plus.nothingTitle' => 'Nothing to restore',
          'plus.nothingHighlight' => 'restore',
          'plus.nothingText' => 'We found no active purchases in this store. If you subscribed with another account, sign in with it and try again.',
          'plus.restoreFailedTitle' => 'Couldn\'t restore',
          'plus.restoreFailedHighlight' => 'restore',
          'plus.tryAgain' => 'Try again',
          'plus.done' => 'Done',
          'plus.errors.storeUnavailable' => 'The store isn\'t available on this device right now.',
          'plus.errors.manageUnavailable' => 'There\'s no store page for this subscription here.',
          'plus.errors.other' => 'Couldn\'t do that right now. Try again.',
          _ => null,
        } ??
        switch (path) {
          'privacy.title' => 'Privacy and security',
          'privacy.partnerTitle' => 'What your partner sees',
          'privacy.partnerSlips' => 'Sent slips',
          'privacy.partnerSlipsText' => 'Only what you send',
          'privacy.partnerPrivateSlips' => 'Private slips',
          'privacy.partnerTemperature' => 'Temperature',
          'privacy.partnerJournal' => 'Journal',
          'privacy.never' => 'Never',
          'privacy.partnerNote' => 'Whoever makes the data decides who sees it.',
          'privacy.ourTitle' => 'What we can see',
          'privacy.ourEncrypted' => 'Your content is encrypted in transit.',
          'privacy.ourPrivate' => 'The team cannot read your private notes.',
          'privacy.ourAnalytics' => 'Analytics: counts only.',
          'privacy.ourPlain' => 'This page in plain language.',
          'privacy.consents' => 'Consents',
          'privacy.analytics' => 'Analytics',
          'privacy.marketing' => 'Marketing',
          'privacy.ai' => 'AI (when available)',
          'privacy.terms' => 'Terms',
          'privacy.required' => 'Required',
          'privacy.requiredNote' => 'Accepting the Terms is required to use the app.',
          'privacy.consentsNote' => 'Changes apply now.',
          'privacy.saveError' => 'Could not save now. Try again.',
          'privacy.errorTitle' => 'Could not load the consents',
          'privacy.errorText' => 'Try again in a moment.',
          'profileDetails.title' => 'Profile',
          'profileDetails.nameLabel' => 'Your name',
          'profileDetails.nameHint' => 'Your first name',
          'profileDetails.nameErrors.empty' => 'Your name cannot be empty.',
          'profileDetails.nameErrors.tooLong' => 'Use at most 30 characters.',
          'profileDetails.pronounsLabel' => 'Pronouns',
          'profileDetails.timeZoneLabel' => 'Time zone',
          'profileDetails.timeZonePlaceholder' => 'Pick a time zone',
          'profileDetails.loginLabel' => 'Login',
          'profileDetails.loginAccount' => 'Account',
          'profileDetails.loginEmail' => 'Email',
          'profileDetails.loginApple' => 'Apple',
          'profileDetails.loginGoogle' => 'Google',
          'profileDetails.photoNote' => 'Photo upload is not available yet.',
          'profileDetails.saved' => 'Saved',
          'profileDetails.loadErrorTitle' => 'Could not load your profile',
          'profileDetails.loadErrorText' => 'Check your connection and try again.',
          'profileDetails.timeZones.America/Sao_Paulo' => 'São Paulo',
          'profileDetails.timeZones.America/Argentina/Buenos_Aires' => 'Buenos Aires',
          'profileDetails.timeZones.America/Bogota' => 'Bogotá',
          'profileDetails.timeZones.America/Mexico_City' => 'Mexico City',
          'profileDetails.timeZones.America/New_York' => 'New York',
          'profileDetails.timeZones.America/Los_Angeles' => 'Los Angeles',
          'profileDetails.timeZones.Europe/Lisbon' => 'Lisbon',
          'profileDetails.timeZones.Europe/London' => 'London',
          'profileDetails.timeZones.Europe/Madrid' => 'Madrid',
          'profileDetails.timeZones.Europe/Paris' => 'Paris',
          'profileDetails.timeZones.Europe/Berlin' => 'Berlin',
          'profileDetails.timeZones.Africa/Luanda' => 'Luanda',
          'profileDetails.timeZones.Asia/Tokyo' => 'Tokyo',
          'profileDetails.timeZones.Australia/Sydney' => 'Sydney',
          'profileDetails.timeZones.UTC' => 'UTC',
          'profileDetails.errors.NETWORK' => 'No connection. Try again.',
          'profileDetails.errors.other' => 'Could not save right now. Try again.',
          'profileSetup.title' => 'The basics',
          'profileSetup.titleHighlight' => 'basics',
          'profileSetup.subtitle' =>
            'Used for the words in the app and for the first date of your story.',
          'profileSetup.nameLabel' => 'Your name',
          'profileSetup.nameHint' => 'Your first name',
          'profileSetup.nameErrors.empty' => 'Your name cannot be empty.',
          'profileSetup.nameErrors.tooLong' => 'Use at most 30 characters.',
          'profileSetup.partnerNameLabel' => 'Partner\'s name',
          'profileSetup.partnerNameHint' => 'Their first name',
          'profileSetup.partnerNameErrors.tooLong' => 'Use at most 30 characters.',
          'profileSetup.dateLabel' => 'When did you start?',
          'profileSetup.dateHint' => 'Pick a date',
          'profileSetup.dateErrors.empty' => 'Pick the date you started.',
          'profileSetup.dateFormat' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'profileSetup.months.0' => 'January',
          'profileSetup.months.1' => 'February',
          'profileSetup.months.2' => 'March',
          'profileSetup.months.3' => 'April',
          'profileSetup.months.4' => 'May',
          'profileSetup.months.5' => 'June',
          'profileSetup.months.6' => 'July',
          'profileSetup.months.7' => 'August',
          'profileSetup.months.8' => 'September',
          'profileSetup.months.9' => 'October',
          'profileSetup.months.10' => 'November',
          'profileSetup.months.11' => 'December',
          'profileSetup.continueButton' => 'Continue',
          'profileSetup.errors.INVALID_DATE' =>
            'That date does not look right. Pick one between 1950 and today.',
          'profileSetup.errors.NETWORK' => 'No connection. Your answers are still here, try again.',
          'profileSetup.errors.other' => 'Could not save right now. Try again.',
          'profileSetup.themeLabel' => 'Your app colour',
          'profileSetup.themeRose' => 'Rose',
          'profileSetup.themeBlue' => 'Blue',
          'profileSetup.themeNeutral' => 'Neutral',
          'programs.label' => 'PROGRAMS',
          'programs.title' => 'Programs',
          'programs.entryText' => 'Short guided programs, at your own pace.',
          'programs.hubSubtitle' => 'One idea a day. No rush, no pressure.',
          'programs.free' => 'FREE',
          'programs.plus' => 'PLUS',
          'programs.lessonCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 lesson',
                  other: '${count} lessons',
                ),
          'programs.noLessons' => 'Lessons coming',
          'programs.emptyTitle' => 'No programs here yet',
          'programs.emptyText' => 'New programs are on the way. Come back whenever you like.',
          'programs.errorTitle' => 'Couldn\'t load',
          'programs.errorText' => 'The programs are still here. Try again.',
          'programs.diaryLabel' => 'JUST ME',
          'programs.diaryTitle' => 'Diary',
          'programs.diaryText' => 'A private place to write how you are.',
          'programs.start' => 'Start',
          'programs.kContinue' => 'Continue',
          'programs.restart' => 'Start over',
          'programs.restartConfirmTitle' => 'Start over?',
          'programs.restartConfirmText' =>
            'This clears your lesson marks and returns to the first lesson.',
          'programs.restartConfirm' => 'Start over',
          'programs.completed' => 'Completed',
          'programs.lessonsTitle' => 'Lessons',
          'programs.lessonsComingTitle' => 'Lessons coming',
          'programs.lessonsComingText' => 'This program is still being prepared. Come back soon.',
          'programs.lessonGoneTitle' => 'Lesson not here',
          'programs.lessonGoneText' =>
            'This day is no longer part of the program. Choose another lesson.',
          'programs.dayOneHint' => 'The first lesson is always open in this program.',
          'programs.dayLabel' => ({required Object day}) => 'Day ${day}',
          'programs.shortRead' => 'A short idea for today.',
          'programs.ready' => 'Done',
          'programs.saveForLater' => 'Save for later',
          'programs.saved' => 'Saved for later.',
          'programs.savedTag' => 'Saved',
          'programs.lockedTitle' => 'Plus lesson',
          'programs.lockedLessonText' => 'This lesson is part of Plus.',
          'programs.lockedProgramText' => 'This program is part of Plus.',
          'programs.completeTitle' => 'Well done',
          'programs.completeText' => ({required Object title}) => 'You completed ${title}.',
          'programs.completeHint' => 'Choose another whenever you want.',
          'programs.seePrograms' => 'See programs',
          'programs.diaryPrivacy' => 'Just me. Never shared.',
          'programs.diaryPrompt' => 'Today I felt...',
          'programs.diaryHint' => 'Write without hurry. Only you can see this.',
          'programs.diaryBodyErrors.empty' => 'Write a little before saving',
          'programs.diaryBodyErrors.tooLong' => 'The entry is too long',
          'programs.diarySave' => 'Save',
          'programs.diaryNew' => 'New entry',
          'programs.diaryEdit' => 'Edit',
          'programs.diaryDelete' => 'Delete',
          'programs.diaryDeleteTitle' => 'Delete this entry?',
          'programs.diaryDeleteText' => 'This can\'t be undone.',
          'programs.diaryDeleteConfirm' => 'Delete',
          'programs.diaryCapHint' => 'Showing your last 100 entries.',
          'programs.diaryEmptyTitle' => 'Nothing written yet',
          'programs.diaryEmptyText' => 'When you want, write how you are. Only you can see it.',
          'programs.diaryErrorTitle' => 'Couldn\'t load',
          'programs.diaryErrorText' => 'Your entries are still saved. Try again.',
          'programs.monthsShort.0' => 'Jan',
          'programs.monthsShort.1' => 'Feb',
          'programs.monthsShort.2' => 'Mar',
          'programs.monthsShort.3' => 'Apr',
          'programs.monthsShort.4' => 'May',
          'programs.monthsShort.5' => 'Jun',
          'programs.monthsShort.6' => 'Jul',
          'programs.monthsShort.7' => 'Aug',
          'programs.monthsShort.8' => 'Sep',
          'programs.monthsShort.9' => 'Oct',
          'programs.monthsShort.10' => 'Nov',
          'programs.monthsShort.11' => 'Dec',
          'programs.dateLine' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'programs.moods.calm' => 'At peace',
          'programs.moods.tender' => 'Held',
          'programs.moods.tired' => 'Tired',
          'programs.moods.heavy' => 'Heavy',
          'programs.moods.other' => 'How I am',
          'programs.lessonErrors.other' => 'Couldn\'t do that right now. Try again.',
          'programs.diaryErrors.other' => 'Couldn\'t save right now. Your text is still here.',
          'programs.freeNote' => 'Free shows only the first lesson.',
          'pronouns.options.she' => 'She',
          'pronouns.options.he' => 'He',
          'pronouns.options.nameOnly' => 'Name only',
          'pronouns.options.other' => 'Name only',
          'questions.tag' => 'Couple question',
          'questions.answerCta' => 'Answer',
          'questions.introNote' => 'One question a day or a week.',
          'questions.answerHint' => 'Write as much as you like.',
          'questions.answerErrors.empty' => 'Write an answer',
          'questions.answerErrors.tooLong' => 'The answer is too long',
          'questions.partnerAnsweredNote' =>
            'Your partner already answered. Send yours to see both.',
          'questions.partnerSeesAfter' => ({
            required Object name,
          }) => 'Only after you send yours and ${name} answers too.',
          'questions.partnerSeesAfterFallback' =>
            'Only after you send yours and your partner answers too.',
          'questions.soloNote' =>
            'Your answer stays private. Your partner sees it after you connect.',
          'questions.save' => 'Send',
          'questions.cancel' => 'Cancel',
          'questions.skip' => 'Skip',
          'questions.waitingTitle' => 'Your answer is saved',
          'questions.waitingText' => 'It appears here when your partner answers too.',
          'questions.waitingSoloText' =>
            'When your partner joins, they see your answer and you see theirs.',
          'questions.checkAgain' => 'Check again',
          'questions.revealTitle' => 'The two memories',
          'questions.revealHighlight' => 'memories',
          'questions.keepPrompt' => 'Do you want to keep this in your story?',
          'questions.saveMilestone' => 'Save as milestone',
          'questions.notNow' => 'Not now',
          'questions.you' => 'You',
          'questions.partnerFallback' => 'Your partner',
          'questions.discardTitle' => 'Discard this answer?',
          'questions.discardText' => 'The text you wrote was not saved.',
          'questions.discard' => 'Discard',
          'questions.keepWriting' => 'Keep writing',
          'questions.loadErrorTitle' => 'Could not open the question',
          'questions.loadErrorText' => 'Nothing was lost. Try again.',
          'questions.close' => 'Close',
          'questions.errors.other' => 'Could not save right now. Try again.',
          'questions.editCta' => 'Edit my answer',
          'questionsEntry.label' => 'QUESTION OF THE DAY',
          'questionsEntry.title' => 'Question of the day',
          'questionsEntry.text' => 'One question for both of you to answer.',
          'quickSlip.dateLine' => ({
            required Object weekday,
            required Object month,
            required Object day,
          }) => '${weekday}, ${month} ${day}',
          'quickSlip.weekdays.0' => 'Monday',
          'quickSlip.weekdays.1' => 'Tuesday',
          'quickSlip.weekdays.2' => 'Wednesday',
          'quickSlip.weekdays.3' => 'Thursday',
          'quickSlip.weekdays.4' => 'Friday',
          'quickSlip.weekdays.5' => 'Saturday',
          'quickSlip.weekdays.6' => 'Sunday',
          'quickSlip.monthsShort.0' => 'Jan',
          'quickSlip.monthsShort.1' => 'Feb',
          'quickSlip.monthsShort.2' => 'Mar',
          'quickSlip.monthsShort.3' => 'Apr',
          'quickSlip.monthsShort.4' => 'May',
          'quickSlip.monthsShort.5' => 'Jun',
          'quickSlip.monthsShort.6' => 'Jul',
          'quickSlip.monthsShort.7' => 'Aug',
          'quickSlip.monthsShort.8' => 'Sep',
          'quickSlip.monthsShort.9' => 'Oct',
          'quickSlip.monthsShort.10' => 'Nov',
          'quickSlip.monthsShort.11' => 'Dec',
          'quickSlip.title' => 'What made you happy?',
          'quickSlip.titleHighlight' => 'happy',
          'quickSlip.subtitle' => 'One line is enough. 30 seconds.',
          'quickSlip.polarityLabel' => 'Liked or bothered me',
          'quickSlip.polarityLiked' => 'Liked',
          'quickSlip.polarityBothered' => 'Bothered me',
          'quickSlip.hint' => 'E.g. made coffee before I woke up',
          'quickSlip.textErrors.empty' => 'Write the slip first',
          'quickSlip.textErrors.tooLong' => 'This slip is too long',
          'quickSlip.categories.said' => 'Said something',
          'quickSlip.categories.did' => 'Did something',
          'quickSlip.categories.noticed' => 'Noticed me',
          'quickSlip.categories.helped' => 'Helped me',
          'quickSlip.categories.other' => '',
          'quickSlip.privacyNote' =>
            'It stays private. On Sunday you choose what goes on the card.',
          'quickSlip.cardNote' => 'It goes on your weekly card. You can take it out anytime.',
          'quickSlip.save' => 'Save',
          'quickSlip.discardTitle' => 'Discard this slip?',
          'quickSlip.saved.title' => 'Saved',
          'quickSlip.saved.added' => 'Slip added to this week.',
          'quickSlip.saved.queued' =>
            'Saved on this phone. We send it when the connection is back.',
          'quickSlip.saved.undoHint' => 'Undo for 30 seconds.',
          'quickSlip.saved.undo' => 'Undo',
          'quickSlip.saved.done' => 'Done',
          'quickSlip.saved.annoyanceTitle' => 'Kept',
          'quickSlip.saved.annoyanceAdded' =>
            'It stays with you and goes away on its own in 14 days.',
          'quickSlip.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'quickSlip.errors.other' =>
            'Could not save right now. Your text is still here, try again.',
          'quickSlip.annoyanceTitle' => 'What bothered you?',
          'quickSlip.annoyanceTitleHighlight' => 'bothered',
          'quickSlip.annoyanceSubtitle' => 'One line is enough. Only you see it.',
          'quickSlip.annoyanceHint' => 'E.g. I was left with the dishes again',
          'quickSlip.annoyanceNote' => 'It stays with you and goes away on its own in 14 days. It never goes on the card. It only continues if you turn it into a gentle request.',
          'quickSlip.gentleRequest' => 'Gentle request',
          'quickSlip.keep' => 'Keep',
          'quickSlip.addDetails' => 'Add details',
          'quizzes.title' => 'Quizzes',
          'quizzes.headline' => 'Getting to know',
          'quizzes.headlineHighlight' => 'each other',
          'quizzes.intro' => 'Two short quizzes, six questions each. You see the result first and decide whether to show it.',
          'quizzes.entryTitle' => 'Quizzes',
          'quizzes.entryText' => 'Get to know each other',
          'quizzes.lovedTitle' => 'How I feel loved',
          'quizzes.fightTitle' => 'How I react in a fight',
          'quizzes.questionCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 question',
                  other: '${count} questions',
                ),
          'quizzes.minutes' => ({required Object minutes}) => '${minutes} min',
          'quizzes.meta' => ({
            required Object questions,
            required Object minutes,
          }) => '${questions} · ${minutes}',
          'quizzes.start' => 'Start',
          'quizzes.lastDone' => ({required Object date}) => 'Done on ${date}',
          'quizzes.monthsShort.0' => 'Jan',
          'quizzes.monthsShort.1' => 'Feb',
          'quizzes.monthsShort.2' => 'Mar',
          'quizzes.monthsShort.3' => 'Apr',
          'quizzes.monthsShort.4' => 'May',
          'quizzes.monthsShort.5' => 'Jun',
          'quizzes.monthsShort.6' => 'Jul',
          'quizzes.monthsShort.7' => 'Aug',
          'quizzes.monthsShort.8' => 'Sep',
          'quizzes.monthsShort.9' => 'Oct',
          'quizzes.monthsShort.10' => 'Nov',
          'quizzes.monthsShort.11' => 'Dec',
          'quizzes.note' =>
            'Only you see the result, until you tap Show. It is not a psychological test.',
          'quizzes.loadErrorTitle' => 'Could not open the quizzes',
          'quizzes.loadErrorText' => 'Nothing was lost. Try again.',
          'received.kinds.repair' => 'Repair card',
          'received.kinds.need' => 'I need…',
          'received.kinds.missUs' => 'Missing you',
          'received.kinds.hug' => 'A hug',
          'received.kinds.distance' => 'A little distance',
          'received.kinds.goodNews' => 'Good news',
          'received.kinds.other' => '',
          'received.bodies.missUs' => 'Your partner is missing you both.',
          'received.bodies.hug' => 'Your partner would like a hug.',
          'received.bodies.distance' => 'Your partner needs a little distance.',
          'received.bodies.goodNews' => 'Your partner has good news.',
          'received.bodies.other' => '',
          'received.fromPartner' => 'From your partner',
          'received.privateFirst' => 'Your answer is private first. There is no right or wrong.',
          'received.responses.here' => 'I\'m here',
          'received.responses.talk' => 'Let\'s talk',
          'received.responses.moreTime' => 'I need a bit more time',
          'received.responses.willDo' => 'I\'ll do it',
          'received.responses.notNow' => 'Not now',
          'received.responses.plan' => 'Plan something',
          'received.responses.later' => 'I\'ll answer later',
          'received.responses.heart' => 'Send a heart',
          'received.responses.other' => '',
          'received.seen' => 'Got it',
          'received.answered' => ({required Object response}) => 'You answered: ${response}',
          'received.next' => 'Next message',
          'received.doneTitle' => 'All good',
          'received.doneText' => 'Thanks for reading it calmly.',
          'received.emptyTitle' => 'Nothing new',
          'received.emptyText' => 'When your partner sends something, it shows up here.',
          'received.close' => 'Close',
          'received.errorTitle' => 'Couldn\'t open this',
          'received.errorText' => 'Nothing was lost. Try again.',
          'received.errors.NOT_FOUND' => 'That message isn\'t here anymore.',
          'received.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'received.errors.other' => 'Couldn\'t answer right now. Try again.',
          'relationshipChanged.title' => 'Something changed?',
          'relationshipChanged.highlight' => 'changed',
          'relationshipChanged.subtitle' => 'Take your time. This only changes what the app shows.',
          'relationshipChanged.optionEnded' => 'We broke up',
          'relationshipChanged.optionBereaved' => 'I lost them',
          'relationshipChanged.optionTogether' => 'Everything is fine',
          'relationshipChanged.continueLabel' => 'Continue',
          'relationshipChanged.saved' => 'Saved',
          'relationshipChanged.errors.NETWORK' => 'No connection. Try again.',
          'relationshipChanged.errors.other' => 'Could not save right now. Try again.',
          'relationshipSettings.title' => 'Relationship',
          'relationshipSettings.phaseLabel' => 'Phase',
          'relationshipSettings.phasePlaceholder' => 'Pick a phase',
          'relationshipSettings.phases.beginning' => 'Just starting',
          'relationshipSettings.phases.dating' => 'Dating',
          'relationshipSettings.phases.livingTogether' => 'Living together',
          'relationshipSettings.phases.engaged' => 'Engaged',
          'relationshipSettings.phases.married' => 'Married',
          'relationshipSettings.phases.longDistance' => 'Long distance',
          'relationshipSettings.phases.restarting' => 'Starting over',
          'relationshipSettings.dateLabel' => 'Together since',
          'relationshipSettings.dateHint' => 'Pick a date',
          'relationshipSettings.dateFormat' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'relationshipSettings.months.0' => 'January',
          'relationshipSettings.months.1' => 'February',
          'relationshipSettings.months.2' => 'March',
          'relationshipSettings.months.3' => 'April',
          'relationshipSettings.months.4' => 'May',
          'relationshipSettings.months.5' => 'June',
          'relationshipSettings.months.6' => 'July',
          'relationshipSettings.months.7' => 'August',
          'relationshipSettings.months.8' => 'September',
          'relationshipSettings.months.9' => 'October',
          'relationshipSettings.months.10' => 'November',
          'relationshipSettings.months.11' => 'December',
          'relationshipSettings.futureDateNote' =>
            'A future date is fine; the countdown just starts later.',
          'relationshipSettings.partnerLabel' => 'Partner',
          'relationshipSettings.invitePartner' => 'Invite your partner',
          'relationshipSettings.partnerError' => 'Could not load your partner.',
          'relationshipSettings.partnerRetry' => 'Try again',
          'relationshipSettings.phaseNote' => 'The phase only changes the words.',
          'relationshipSettings.saved' => 'Saved',
          'relationshipSettings.loadErrorTitle' => 'Could not load the relationship',
          'relationshipSettings.loadErrorText' => 'Check your connection and try again.',
          'relationshipSettings.errors.NETWORK' => 'No connection. Try again.',
          'relationshipSettings.errors.other' => 'Could not save right now. Try again.',
          'relationshipSettings.changedPrompt' => 'Something changed between you two?',
          'relationshipSettings.changedSubtitle' => 'Update what the app shows',
          'reminders.title' => 'Mingo',
          'reminders.dailyIdea' => 'A small idea for today.',
          'reminders.dates' => 'A date is coming up.',
          'reminders.weeklyCard' => 'Your card is ready.',
          'reminders.generic' => 'Open the app to see.',
          'repair.calm.title' => 'A moment to breathe',
          'repair.calm.titleHighlight' => 'breathe',
          'repair.calm.cadence' =>
            'Breathe in slowly for 4. Breathe out slowly for 6. Repeat at your own pace.',
          'repair.calm.text' => 'There\'s no rush and no timer. Leave whenever you like.',
          'repair.calm.ready' => 'I feel calmer',
          'repair.calm.leave' => 'Leave',
          'repair.softStart.title' => 'Start softly',
          'repair.softStart.titleHighlight' => 'softly',
          'repair.softStart.subtitle' => 'A blame-free template to open the conversation.',
          'repair.softStart.feeling' => 'I feel…',
          'repair.softStart.feelingHint' => 'E.g. tired',
          'repair.softStart.feelingErrors.empty' => 'Say how you feel',
          'repair.softStart.situation' => 'When…',
          'repair.softStart.situationHint' => 'E.g. the dishes wait until later',
          'repair.softStart.situationErrors.empty' => 'Say when it happens',
          'repair.softStart.need' => 'I need…',
          'repair.softStart.needHint' => 'E.g. a little help',
          'repair.softStart.needErrors.empty' => 'Say what you need',
          'repair.softStart.template' => ({
            required Object feeling,
            required Object situation,
            required Object need,
          }) => 'I feel ${feeling} when ${situation}. I need ${need}.',
          'repair.softStart.use' => 'Use this template',
          'repair.quick.title' => 'A small repair',
          'repair.quick.titleHighlight' => 'repair',
          'repair.quick.subtitle' => 'One tap sends. You can change the text first.',
          'repair.quick.presets.tone' => 'Sorry for my tone.',
          'repair.quick.presets.restart' => 'Can we start over?',
          'repair.quick.presets.five_minutes' => 'I need five minutes.',
          'repair.quick.presets.love' => 'I love you, even now.',
          'repair.quick.presets.other' => '',
          'repair.quick.hint' => 'Write my own',
          'repair.quick.textErrors.empty' => 'Write a message',
          'repair.quick.textErrors.tooLong' => 'The message is too long',
          'repair.quick.send' => 'Send',
          'repair.quick.sentTitle' => 'Sent',
          'repair.quick.sentText' => 'Your partner will see it when they open the app.',
          'repair.quick.done' => 'Done',
          'repair.quick.errors.NOT_PAIRED' =>
            'To send this, you need to be connected with your partner in the app.',
          'repair.quick.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'repair.quick.errors.other' => 'Couldn\'t send right now. Your message is still here.',
          'repair.guided.stepOf' => ({
            required Object current,
            required Object total,
          }) => 'Step ${current} of ${total}',
          'repair.guided.stepTitles.0' => 'What happened?',
          'repair.guided.stepTitles.1' => 'What do you need?',
          'repair.guided.stepTitles.2' => 'What can you offer?',
          'repair.guided.stepHighlights.0' => 'happened',
          'repair.guided.stepHighlights.1' => 'need',
          'repair.guided.stepHighlights.2' => 'offer',
          'repair.guided.stepHints.0' => 'In your own words, without blaming anyone.',
          'repair.guided.stepHints.1' => 'One thing that would help right now.',
          'repair.guided.stepHints.2' => 'Something small and sincere.',
          'repair.guided.private' => 'Only you see this. Nothing is sent to your partner.',
          'repair.guided.next' => 'Continue',
          'repair.guided.back' => 'Back',
          'repair.guided.later' => 'Save for later',
          'repair.guided.savedLater' => 'Saved. You\'ll pick up where you left off.',
          'repair.guided.finalTitle' => 'How are you now?',
          'repair.guided.finalHighlight' => 'now',
          'repair.guided.feelings.calmer' => 'Calmer',
          'repair.guided.feelings.stillTense' => 'Still tense',
          'repair.guided.feelings.needMoreTime' => 'I need more time',
          'repair.guided.feelings.other' => '',
          'repair.guided.followUpTitle' => 'Want a reminder to check in on how you are?',
          'repair.guided.followUps.none' => 'No need',
          'repair.guided.followUps.tomorrow' => 'Tomorrow',
          'repair.guided.followUps.inThreeDays' => 'In 3 days',
          'repair.guided.followUps.other' => '',
          'repair.guided.followUpNote' =>
            'The reminder is short and says nothing about what happened.',
          'repair.guided.finish' => 'Finish',
          'repair.guided.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'repair.guided.errors.other' => 'Couldn\'t save right now. Your answers are still here.',
          'repair.guided.loadErrorTitle' => 'Couldn\'t open this',
          'repair.guided.loadErrorText' => 'Nothing was lost. Try again.',
          'repair.guided.done.title' => 'Repair done',
          'repair.guided.done.highlight' => 'done',
          'repair.guided.done.text' => 'Taking care of this is already a step. If you want, keep what you learned, just for you.',
          'repair.guided.done.learn' => 'Keep what I learned',
          'repair.guided.done.close' => 'Not now',
          'repair.learning.title' => 'What did you learn?',
          'repair.learning.titleHighlight' => 'learn',
          'repair.learning.subtitle' => 'It stays with you and can be deleted whenever you like.',
          'repair.learning.kinds.trigger' => 'What bothers me',
          'repair.learning.kinds.need' => 'What I need',
          'repair.learning.kinds.goodFix' => 'What helped',
          'repair.learning.kinds.other' => '',
          'repair.learning.hint' => 'Write one or two sentences',
          'repair.learning.noteErrors.empty' => 'Write what you learned',
          'repair.learning.noteErrors.tooLong' => 'The note is too long',
          'repair.learning.save' => 'Save',
          'repair.learning.listTitle' => 'Your learnings',
          'repair.learning.delete' => 'Delete',
          'repair.learning.emptyTitle' => 'Nothing yet',
          'repair.learning.emptyText' => 'When you write a learning, it shows up here.',
          'repair.learning.errorTitle' => 'Couldn\'t load',
          'repair.learning.errorText' => 'Your learnings are still saved. Try again.',
          'repair.learning.done' => 'Done',
          'repair.learning.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'repair.learning.errors.other' => 'Couldn\'t save right now. Your text is still here.',
          'repair.next.pause' => 'Breathe a little',
          'repair.next.guided' => 'Start the guided repair',
          'repair.next.quick' => 'Send a repair',
          'repair.sos.title' => 'We are fighting',
          'repair.sos.titleHighlight' => 'fighting',
          'repair.sos.subtitle' => 'Pick where to start. Nothing is sent until you confirm.',
          'repair.sos.softStartTitle' => 'Soft start',
          'repair.sos.softStartText' => 'A model to open the talk without blame',
          'repair.sos.repairTitle' => 'Repair',
          'repair.sos.repairText' => 'See how it is and choose a step',
          'repair.sos.talkTitle' => 'Prepare what to say',
          'repair.sos.talkText' => 'Sort your thoughts before you talk',
          'repair.sos.note' => 'Works offline and stays only with you.',
          'repair.sos.action' => 'We are fighting',
          'rituals.title' => 'Rituals',
          'rituals.subtitle' => 'Small habits you want to protect. No streaks, no pressure.',
          'rituals.emptyTitle' => 'No rituals yet',
          'rituals.emptyText' => 'A Friday dinner, a Sunday walk. What do you want to protect?',
          'rituals.create' => 'Create a ritual',
          'rituals.didIt' => 'We did it',
          'rituals.warm' => 'That\'s lovely. A moment for the two of you.',
          'rituals.cadences.daily' => 'Every day',
          'rituals.cadences.weekly' => 'Every week',
          'rituals.cadences.biweekly' => 'Every two weeks',
          'rituals.cadences.monthly' => 'Every month',
          'rituals.cadences.other' => '',
          'rituals.cadenceOn' => ({
            required Object cadence,
            required Object weekday,
          }) => '${cadence}, ${weekday}',
          'rituals.weekdays.0' => 'Sunday',
          'rituals.weekdays.1' => 'Monday',
          'rituals.weekdays.2' => 'Tuesday',
          'rituals.weekdays.3' => 'Wednesday',
          'rituals.weekdays.4' => 'Thursday',
          _ => null,
        } ??
        switch (path) {
          'rituals.weekdays.5' => 'Friday',
          'rituals.weekdays.6' => 'Saturday',
          'rituals.createTitle' => 'New ritual',
          'rituals.editTitle' => 'Your ritual',
          'rituals.nameLabel' => 'Name',
          'rituals.nameHint' => 'E.g. Friday dinner',
          'rituals.cadenceLabel' => 'How often',
          'rituals.weekdayLabel' => 'On which day',
          'rituals.hourLabel' => 'What time',
          'rituals.hourFormat' => ({required Object hour}) => '${hour}:00',
          'rituals.reminderTitle' => 'Reminder',
          'rituals.reminderText' => 'A short notice on this phone, with no details.',
          'rituals.save' => 'Save',
          'rituals.archive' => 'Archive',
          'rituals.archiveTitle' => 'Archive this ritual?',
          'rituals.archiveText' => 'It leaves the list. The history stays saved.',
          'rituals.errorTitle' => 'Couldn\'t open this',
          'rituals.errorText' => 'Nothing was lost. Try again.',
          'rituals.errors.NOT_FOUND' => 'That ritual isn\'t here anymore.',
          'rituals.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'rituals.errors.other' => 'Couldn\'t do that right now. Try again.',
          'rituals.errors.INVALID_PLANNER' => 'The planner has to be one of the two people.',
          'rituals.plannerLabel' => 'Who plans it',
          'rituals.plannerNobody' => 'Nobody in particular',
          'rituals.plannerMe' => 'Me',
          'rituals.plannerPartner' => 'The other person',
          'sessionExpired.title' => 'Your session ended',
          'sessionExpired.highlight' => 'ended',
          'sessionExpired.text' => 'Sign in again to continue. Your data is safe.',
          'sessionExpired.action' => 'Sign in',
          'settingsHome.title' => 'Settings',
          'settingsHome.profile' => 'Profile',
          'settingsHome.relationship' => 'Relationship',
          'settingsHome.connected' => 'You are connected',
          'settingsHome.invitePartner' => 'Invite your partner',
          'settingsHome.notifications' => 'Notifications',
          'settingsHome.devices' => 'Devices',
          'settingsHome.on' => 'On in the app',
          'settingsHome.off' => 'Off in the app',
          'settingsHome.plan' => 'Plan',
          'settingsHome.planFree' => 'Free',
          'settingsHome.planPlus' => 'Plus',
          'settingsHome.spice' => 'Tempero',
          'settingsHome.privacy' => 'Privacy and security',
          'settingsHome.privacyStatus' => 'Who sees what',
          'settingsHome.signOut' => 'Sign out',
          'settingsHome.deleteAccount' => 'Delete account',
          'settingsHome.pendingBanner' => ({
            required Object date,
          }) => 'Your account will be deleted on ${date}.',
          'settingsHome.pendingAction' => 'See',
          'settingsHome.pendingBannerSimple' => 'Your account will be deleted soon.',
          'settingsHome.help' => 'Help and support',
          'settingsHome.helpStatus' => 'FAQ and contact',
          'settingsHome.appPreferences' => 'App preferences',
          'settingsHome.appPreferencesStatus' => 'Appearance, text and language',
          'settingsHome.theme' => 'App colour',
          'settingsHome.themeTitle' => 'Which colour suits you?',
          'settingsHome.themeHighlight' => 'colour',
          'settingsHome.themeSubtitle' =>
            'Applies to the app and to the widgets. The features are the same.',
          'settingsHome.weeklyCard' => 'Weekly card',
          'settingsHome.language' => 'Language',
          'settingsHome.accountSection' => 'Account',
          'settingsHome.preferencesSection' => 'Preferences',
          'settingsHome.privacySection' => 'Privacy and help',
          'settingsHome.connectedWith' => ({required Object name}) => 'Connected with ${name}',
          'share.entryTitle' => 'Share image',
          'share.entrySubtitleToday' => 'Your time together and the moon from the day it began.',
          'share.entrySubtitleMemories' => 'A timeline of the moments you kept.',
          'share.entrySubtitleCard' => 'A line from the card that reached you.',
          'share.sheetTitle' => 'Share image',
          'share.sheetSubtitle' =>
            'The image is made on your device and only leaves when you share it.',
          'share.shareAction' => 'Share',
          'share.cardLabels.counter' => 'Our time',
          'share.cardLabels.moon' => 'The moon of our day',
          'share.cardLabels.timeline' => 'Our timeline',
          'share.cardLabels.quote' => 'From a card',
          'share.cardLabels.other' => '',
          'share.counterEyebrow' => 'OUR TIME',
          'share.counterDays' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'day together',
                  other: 'days together',
                ),
          'share.counterSince' => ({required Object date}) => 'Since ${date}',
          'share.moonEyebrow' => 'THE MOON OF OUR DAY',
          'share.moonSupport' => 'This is how the sky looked when it all began.',
          'share.timelineEyebrow' => 'OUR TIMELINE',
          'share.timelineTitle' => 'Moments we kept',
          'share.quoteEyebrow' => 'FROM A CARD',
          'share.quoteText' => ({required Object quote}) => '“${quote}”',
          'share.quoteFromName' => ({required Object name}) => '— ${name}',
          'share.quoteDate' => ({required Object date}) => 'Card from ${date}',
          'share.dateLine' => ({
            required Object month,
            required Object day,
            required Object year,
          }) => '${month} ${day}, ${year}',
          'share.dateShort' => ({required Object month, required Object day}) => '${month} ${day}',
          'share.monthsLong.0' => 'January',
          'share.monthsLong.1' => 'February',
          'share.monthsLong.2' => 'March',
          'share.monthsLong.3' => 'April',
          'share.monthsLong.4' => 'May',
          'share.monthsLong.5' => 'June',
          'share.monthsLong.6' => 'July',
          'share.monthsLong.7' => 'August',
          'share.monthsLong.8' => 'September',
          'share.monthsLong.9' => 'October',
          'share.monthsLong.10' => 'November',
          'share.monthsLong.11' => 'December',
          'share.phases.newMoon' => 'New moon',
          'share.phases.waxingCrescent' => 'Waxing crescent',
          'share.phases.firstQuarter' => 'First quarter',
          'share.phases.waxingGibbous' => 'Waxing gibbous',
          'share.phases.fullMoon' => 'Full moon',
          'share.phases.waningGibbous' => 'Waning gibbous',
          'share.phases.lastQuarter' => 'Last quarter',
          'share.phases.waningCrescent' => 'Waning crescent',
          'share.phases.other' => '',
          'share.productMark' => 'Mingo',
          'share.errors.other' => 'Couldn\'t share right now. Try again.',
          'slipDetail.dateLine' => ({
            required Object weekday,
            required Object month,
            required Object day,
          }) => '${weekday}, ${month} ${day}',
          'slipDetail.weekdays.0' => 'Monday',
          'slipDetail.weekdays.1' => 'Tuesday',
          'slipDetail.weekdays.2' => 'Wednesday',
          'slipDetail.weekdays.3' => 'Thursday',
          'slipDetail.weekdays.4' => 'Friday',
          'slipDetail.weekdays.5' => 'Saturday',
          'slipDetail.weekdays.6' => 'Sunday',
          'slipDetail.monthsShort.0' => 'Jan',
          'slipDetail.monthsShort.1' => 'Feb',
          'slipDetail.monthsShort.2' => 'Mar',
          'slipDetail.monthsShort.3' => 'Apr',
          'slipDetail.monthsShort.4' => 'May',
          'slipDetail.monthsShort.5' => 'Jun',
          'slipDetail.monthsShort.6' => 'Jul',
          'slipDetail.monthsShort.7' => 'Aug',
          'slipDetail.monthsShort.8' => 'Sep',
          'slipDetail.monthsShort.9' => 'Oct',
          'slipDetail.monthsShort.10' => 'Nov',
          'slipDetail.monthsShort.11' => 'Dec',
          'slipDetail.kinds.quick' => 'Quick',
          'slipDetail.kinds.specific' => 'Specific',
          'slipDetail.kinds.ifThen' => 'If… then',
          'slipDetail.kinds.invisible' => 'Invisible',
          'slipDetail.kinds.other' => '',
          'slipDetail.feeling' => 'How you felt',
          'slipDetail.plan' => 'Then I…',
          'slipDetail.jarTitle' => 'Keep in the jar',
          'slipDetail.jarText' => 'To open on a bad day. Only you see it.',
          'slipDetail.sentNote' => 'This slip already went in a card. The sent card keeps the earlier copy, even if you edit or delete it here.',
          'slipDetail.draftBodyErrors.empty' => 'Write the slip first',
          'slipDetail.draftBodyErrors.tooLong' => 'This slip is too long',
          'slipDetail.edit' => 'Edit',
          'slipDetail.editSave' => 'Save',
          'slipDetail.editCancel' => 'Cancel',
          'slipDetail.delete' => 'Delete',
          'slipDetail.deleteTitle' => 'Delete this slip?',
          'slipDetail.deleteText' => 'It will be removed from your week and your timeline.',
          'slipDetail.deleteConfirm' => 'Delete',
          'slipDetail.saved' => 'Saved',
          'slipDetail.deleted' => 'Slip deleted',
          'slipDetail.notFoundTitle' => 'This slip no longer exists',
          'slipDetail.notFoundText' => 'It may have been deleted.',
          'slipDetail.errors.SLIP_NOT_FOUND' => 'This slip no longer exists.',
          'slipDetail.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'slipDetail.errors.other' => 'Couldn\'t do that right now. Try again.',
          'slipDetail.discardTitle' => 'Discard this slip?',
          'slipDetail.weekdaysShort.0' => 'Mon',
          'slipDetail.weekdaysShort.1' => 'Tue',
          'slipDetail.weekdaysShort.2' => 'Wed',
          'slipDetail.weekdaysShort.3' => 'Thu',
          'slipDetail.weekdaysShort.4' => 'Fri',
          'slipDetail.weekdaysShort.5' => 'Sat',
          'slipDetail.weekdaysShort.6' => 'Sun',
          'slipDetail.factDate' => ({
            required Object weekday,
            required Object month,
            required Object day,
          }) => '${weekday} ${month} ${day}',
          'slipDetail.factDateLabel' => 'Date',
          'slipDetail.factType' => 'Type',
          'slipDetail.factVisibility' => 'Visibility',
          'slipDetail.factInCard' => 'Included in a card',
          'slipDetail.visibilityPrivate' => 'Private',
          'slipDetail.visibilityCard' => 'In the weekly card',
          'slipDetail.visibilitySent' => 'Sent',
          'slipDetail.yes' => 'Yes',
          'slipDetail.no' => 'No',
          'slipDetail.categories.said' => 'Said something',
          'slipDetail.categories.did' => 'Did something',
          'slipDetail.categories.noticed' => 'Noticed me',
          'slipDetail.categories.helped' => 'Helped me',
          'slipDetail.categories.other' => '',
          'slipDetail.visibility.title' => 'Who sees this slip?',
          'slipDetail.visibility.subtitle' => 'Private is the default.',
          'slipDetail.visibility.onlyMe' => 'Only me',
          'slipDetail.visibility.onlyMeText' => 'Stays in your week',
          'slipDetail.visibility.weeklyCard' => 'Put it in my weekly card',
          'slipDetail.visibility.sendNow' => 'Send now',
          'slipDetail.visibility.done' => 'Done',
          'slipDetail.visibility.sentToast' => 'Slip sent',
          'slipDetail.visibility.heldToast' =>
            'The wording sounds harsh, so the card was held. Rewrite it and try again.',
          'slipDetail.visibility.notSentToast' =>
            'It was not sent. Check that you two are connected.',
          'slipKind.switcherTitle' => 'Other ways to write it down',
          'slipKind.quickEntry' => 'Quick',
          'slipKind.needEntry' => 'I need…',
          'slipKind.kinds.specific' => 'Specific',
          'slipKind.kinds.ifThen' => 'If… then',
          'slipKind.kinds.invisible' => 'Invisible',
          'slipKind.kinds.other' => '',
          'slipKind.specific.title' => 'What exactly did they do?',
          'slipKind.specific.titleHighlight' => 'exactly',
          'slipKind.specific.subtitle' => 'Details help you remember why it mattered.',
          'slipKind.specific.hint' => 'E.g. took out the trash without being asked',
          'slipKind.specific.feelingLabel' => 'How did you feel?',
          'slipKind.specific.feelingHint' => 'Optional',
          'slipKind.ifThen.title' => 'Want to tell them?',
          'slipKind.ifThen.titleHighlight' => 'tell',
          'slipKind.ifThen.subtitle' => 'A small plan: when this happens, you do that.',
          'slipKind.ifThen.ifLabel' => 'If…',
          'slipKind.ifThen.ifHint' => 'E.g. I feel overwhelmed',
          'slipKind.ifThen.thenLabel' => 'Then…',
          'slipKind.ifThen.thenHint' => 'E.g. I ask for 10 minutes alone',
          'slipKind.invisible.title' => 'Things nobody notices',
          'slipKind.invisible.titleHighlight' => 'nobody notices',
          'slipKind.invisible.subtitle' => 'Name the work nobody sees.',
          'slipKind.invisible.hint' => 'E.g. remembered the kids\' appointment',
          'slipKind.invisible.areaLabel' => 'What kind of work?',
          'slipKind.invisible.private' => 'Stays with you and never enters a card.',
          'slipKind.workAreas.planning' => 'Planning',
          'slipKind.workAreas.dates' => 'Remembering dates',
          'slipKind.workAreas.kitchen' => 'Kitchen',
          'slipKind.workAreas.cleaning' => 'Cleaning',
          'slipKind.workAreas.kids' => 'Kids\' logistics',
          'slipKind.workAreas.emotional' => 'Emotional support',
          'slipKind.workAreas.finances' => 'Household finances',
          'slipKind.workAreas.other' => 'Other',
          'slipKind.textErrors.empty' => 'Write the slip first',
          'slipKind.textErrors.tooLong' => 'This slip is too long',
          'slipKind.feelingErrors.tooLong' => 'This is too long',
          'slipKind.planErrors.empty' => 'Say what you will do',
          'slipKind.planErrors.tooLong' => 'This is too long',
          'slipKind.save' => 'Save',
          'slipKind.discardTitle' => 'Discard this slip?',
          'slipKind.saved.title' => 'Saved',
          'slipKind.saved.added' => 'Written down.',
          'slipKind.saved.queued' =>
            'Saved on this phone. We\'ll send it when the connection is back.',
          'slipKind.saved.done' => 'Done',
          'slipKind.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'slipKind.errors.other' =>
            'Couldn\'t save right now. Your text is still here, try again.',
          'slipsList.title' => 'Slips',
          'slipsList.scopeWeek' => 'This week',
          'slipsList.scopeAll' => 'All',
          'slipsList.search' => 'Search',
          'slipsList.searchHint' => 'Search your slips',
          'slipsList.searchEmptyTitle' => 'Nothing found',
          'slipsList.searchEmptyText' => 'Try another word.',
          'slipsList.thisWeek' => 'This week',
          'slipsList.lastWeek' => 'Last week',
          'slipsList.weekRange' => ({
            required Object start,
            required Object end,
          }) => '${start} – ${end}',
          'slipsList.dateShort' => ({
            required Object month,
            required Object day,
          }) => '${month} ${day}',
          'slipsList.dayLine' => ({
            required Object weekday,
            required Object category,
          }) => '${weekday} · ${category}',
          'slipsList.weekdaysShort.0' => 'Mon',
          'slipsList.weekdaysShort.1' => 'Tue',
          'slipsList.weekdaysShort.2' => 'Wed',
          'slipsList.weekdaysShort.3' => 'Thu',
          'slipsList.weekdaysShort.4' => 'Fri',
          'slipsList.weekdaysShort.5' => 'Sat',
          'slipsList.weekdaysShort.6' => 'Sun',
          'slipsList.monthsShort.0' => 'Jan',
          'slipsList.monthsShort.1' => 'Feb',
          'slipsList.monthsShort.2' => 'Mar',
          'slipsList.monthsShort.3' => 'Apr',
          'slipsList.monthsShort.4' => 'May',
          'slipsList.monthsShort.5' => 'Jun',
          'slipsList.monthsShort.6' => 'Jul',
          'slipsList.monthsShort.7' => 'Aug',
          'slipsList.monthsShort.8' => 'Sep',
          'slipsList.monthsShort.9' => 'Oct',
          'slipsList.monthsShort.10' => 'Nov',
          'slipsList.monthsShort.11' => 'Dec',
          'slipsList.categories.said' => 'Said something',
          'slipsList.categories.did' => 'Did something',
          'slipsList.categories.noticed' => 'Noticed me',
          'slipsList.categories.helped' => 'Helped',
          'slipsList.categories.other' => '',
          'slipsList.kinds.quick' => 'Quick',
          'slipsList.kinds.specific' => 'Specific',
          'slipsList.kinds.ifThen' => 'If… then',
          'slipsList.kinds.invisible' => 'Invisible',
          'slipsList.kinds.other' => '',
          'slipsList.emptyTitle' => 'Nothing yet',
          'slipsList.emptyText' => 'A slip is one good thing, in one line.',
          'slipsList.emptyAction' => 'Add a slip',
          'slipsList.privateEmptyTitle' => 'Nothing private here',
          'slipsList.privateEmptyText' => 'Slips you keep off the card show up here.',
          'slipsList.privateMarker' => 'Private slip',
          'slipsList.scopePrivate' => 'Private',
          'slipsList.freeNote' => 'Slips are always free.',
          'slipsList.filterThisMonth' => 'This month',
          'slipsList.filterInCard' => 'In a card',
          'slipsList.filterInvisible' => 'Invisible work',
          'slipsList.searchFiltersEmptyText' => 'Adjust the search or the filters.',
          'spice.title' => 'Tempero',
          'spice.introTitle' => 'Tempero, just for the two of you',
          'spice.introHighlight' => 'the two of you',
          'spice.introText' =>
            'An optional space for adults, with cards and desires for the couple. 18+ only.',
          'spice.partnerWantsText' =>
            'The other person wanted to turn it on. It only starts when you turn it on too.',
          'spice.promises.0' => 'It only counts when you both turn it on.',
          'spice.promises.1' =>
            'Either of you can turn it off any time, and everything disappears for both.',
          'spice.promises.2' => 'Your answers are only yours. Only what you both want shows.',
          'spice.promises.3' => 'A "not today" is never explained or announced.',
          'spice.adultLabel' => 'I am 18 or older',
          'spice.adultError' => 'Confirm to continue.',
          'spice.turnOn' => 'Turn on',
          'spice.notNow' => 'Not now',
          'spice.turnOff' => 'Turn off',
          'spice.waitingTitle' => 'Waiting for the other person',
          'spice.waitingText' =>
            'Nothing was announced. When they turn it on too, Tempero opens for both of you.',
          'spice.soloTitle' => 'Tempero is for two',
          'spice.soloText' =>
            'It needs two connected people. When the other person joins, it becomes available.',
          'spice.soloAction' => 'Back',
          'spice.home.subtitle' => 'Everything here is optional and stays between you.',
          'spice.home.cards' => 'Evening cards',
          'spice.home.cardsText' => 'One card at a time',
          'spice.home.desires' => 'Desires',
          'spice.home.desiresText' => 'Answer in secret and see what you both want',
          'spice.home.challenge' => 'Challenge of the week',
          'spice.home.challengeText' => 'An invitation, with no points or deadline',
          'spice.home.settings' => 'Settings',
          'spice.home.settingsText' => 'Your limit and the alerts',
          'spice.cards.title' => 'Evening cards',
          'spice.cards.errors.FREE_LIMIT_REACHED' =>
            'You used this week\'s free cards. Plus unlocks more.',
          'spice.cards.errors.PLUS_REQUIRED' => 'This is part of Plus.',
          'spice.cards.errors.ADULT_REQUIRED' => 'Confirm you are 18 or older.',
          'spice.cards.errors.SPICE_NOT_ON' => 'Tempero is not on for both of you.',
          'spice.cards.errors.SWAP_LIMIT' =>
            'You already swapped the challenge three times this week.',
          'spice.cards.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'spice.cards.errors.other' => 'We could not finish that now. Try again.',
          'spice.cards.answeredTitle' => 'Agreed',
          'spice.cards.answeredText' => 'Whenever you like, there is another card.',
          'spice.cards.next' => 'Another card',
          'spice.cards.emptyTitle' => 'No more cards',
          'spice.cards.emptyText' => 'There are no more cards at this level for now.',
          'spice.cards.mineHint' =>
            'You proposed this card. The other person answers when they like.',
          'spice.cards.theirsHint' => 'The other person proposed this card. You choose.',
          'spice.cards.refresh' => 'Check if they answered',
          'spice.cards.accept' => 'I want to',
          'spice.cards.notToday' => 'Not today',
          'spice.desires.title' => 'Desires',
          'spice.desires.errors.FREE_LIMIT_REACHED' =>
            'You used this week\'s free cards. Plus unlocks more.',
          'spice.desires.errors.PLUS_REQUIRED' => 'This is part of Plus.',
          'spice.desires.errors.ADULT_REQUIRED' => 'Confirm you are 18 or older.',
          'spice.desires.errors.SPICE_NOT_ON' => 'Tempero is not on for both of you.',
          'spice.desires.errors.SWAP_LIMIT' =>
            'You already swapped the challenge three times this week.',
          'spice.desires.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'spice.desires.errors.other' => 'We could not finish that now. Try again.',
          'spice.desires.subtitle' =>
            'Only you see what you answer. If you both want it, it shows in "You both want".',
          'spice.desires.emptyTitle' => 'Nothing here yet',
          'spice.desires.emptyText' => 'When there are desires at this level, they show up here.',
          'spice.desires.matchesTitle' => 'You both want',
          'spice.desires.matchesEmpty' => 'Nothing in common yet. No rush.',
          'spice.desires.answers.want' => 'I want',
          'spice.desires.answers.maybe' => 'Maybe',
          'spice.desires.answers.notToday' => 'Not today',
          'spice.desires.answers.other' => '',
          'spice.challenge.title' => 'Challenge of the week',
          'spice.challenge.errors.FREE_LIMIT_REACHED' =>
            'You used this week\'s free cards. Plus unlocks more.',
          'spice.challenge.errors.PLUS_REQUIRED' => 'This is part of Plus.',
          'spice.challenge.errors.ADULT_REQUIRED' => 'Confirm you are 18 or older.',
          'spice.challenge.errors.SPICE_NOT_ON' => 'Tempero is not on for both of you.',
          'spice.challenge.errors.SWAP_LIMIT' =>
            'You already swapped the challenge three times this week.',
          'spice.challenge.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'spice.challenge.errors.other' => 'We could not finish that now. Try again.',
          'spice.challenge.emptyTitle' => 'No challenge now',
          'spice.challenge.emptyText' => 'Come back next week.',
          'spice.challenge.subtitle' => 'An invitation for you two. No points and no deadline.',
          'spice.challenge.statusDone' => 'You did it. Thank you for caring for this.',
          'spice.challenge.statusBothAccepted' => 'You both said yes.',
          'spice.challenge.statusWaitingPartner' => 'You said yes. Waiting for the other person.',
          'spice.challenge.statusPartnerAccepted' => 'The other person said yes.',
          'spice.challenge.statusNew' => 'Nobody answered yet.',
          'spice.challenge.accept' => 'I am in',
          'spice.challenge.done' => 'We did it',
          'spice.challenge.swap' => 'Swap the challenge',
          'spice.settingsPage.title' => 'Tempero settings',
          'spice.settingsPage.errors.FREE_LIMIT_REACHED' =>
            'You used this week\'s free cards. Plus unlocks more.',
          'spice.settingsPage.errors.PLUS_REQUIRED' => 'This is part of Plus.',
          'spice.settingsPage.errors.ADULT_REQUIRED' => 'Confirm you are 18 or older.',
          'spice.settingsPage.errors.SPICE_NOT_ON' => 'Tempero is not on for both of you.',
          'spice.settingsPage.errors.SWAP_LIMIT' =>
            'You already swapped the challenge three times this week.',
          'spice.settingsPage.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'spice.settingsPage.errors.other' => 'We could not finish that now. Try again.',
          'spice.settingsPage.levelTitle' => 'How far to go',
          'spice.settingsPage.levels.soft' => 'Soft',
          'spice.settingsPage.levels.warm' => 'Warm',
          'spice.settingsPage.levels.hot' => 'Spicy',
          'spice.settingsPage.levels.other' => '',
          'spice.settingsPage.levelNote' =>
            'The gentler of the two limits applies. The other person does not see yours.',
          'spice.settingsPage.notifications' => 'Tempero alerts',
          'spice.settingsPage.notificationsText' =>
            'A short alert that says nothing about the content.',
          'spice.settingsPage.turnOff' => 'Turn off Tempero',
          'spice.settingsPage.turnOffTitle' => 'Turn off Tempero?',
          'spice.settingsPage.turnOffText' => 'It turns off for both of you and erases answers, cards and challenges. This cannot be undone.',
          'spice.settingsPage.turnOffConfirm' => 'Turn off',
          'spice.errors.FREE_LIMIT_REACHED' =>
            'You used this week\'s free cards. Plus unlocks more.',
          'spice.errors.PLUS_REQUIRED' => 'This is part of Plus.',
          'spice.errors.ADULT_REQUIRED' => 'Confirm you are 18 or older.',
          'spice.errors.SPICE_NOT_ON' => 'Tempero is not on for both of you.',
          'spice.errors.SWAP_LIMIT' => 'You already swapped the challenge three times this week.',
          'spice.errors.RATE_LIMITED' => 'Too many tries in a row. Wait a moment.',
          'spice.errors.other' => 'We could not finish that now. Try again.',
          'story.title' => 'Image to share',
          'story.privacyNote' =>
            'The image is made on your device and carries no names or text unless you choose.',
          'story.days' => 'days',
          'story.together' => 'together',
          'story.namesLabel' => 'Include the names',
          'story.namesText' => 'Off by default.',
          'story.phraseLabel' => 'A line (optional)',
          'story.phraseHint' => 'E.g. so much still ahead',
          'story.share' => 'Share image',
          'story.emptyTitle' => 'Your date is missing',
          'story.emptyText' =>
            'Set since when you are together in Our history to create the image.',
          'story.errorTitle' => 'Couldn\'t load',
          'story.errorText' => 'Try again in a moment.',
          'story.errors.other' => 'Couldn\'t share right now. Try again.',
          'sundayCard.title' => 'Your card',
          'sundayCard.edit' => 'Edit',
          'sundayCard.save' => 'Save',
          'sundayCard.cancel' => 'Cancel',
          'sundayCard.noteLabel' => 'Closing note',
          'sundayCard.noteHint' => 'Thank you for this week.',
          'sundayCard.emptyTitle' => 'A week without slips',
          'sundayCard.emptyText' => 'Note one good thing and it goes on the Sunday card.',
          'sundayCard.emptyAction' => 'Note a slip',
          'sundayCard.errorTitle' => 'Could not load the card',
          'sundayCard.errorText' => 'Your slips are still saved. Try again.',
          'sundayCard.saveError' => 'Could not save the card. Try again.',
          'sundayCard.openFromToday' => 'See the draft',
          'sundayCard.deliverError' =>
            'Could not send right now. The card is still here, try again.',
          'sundayCard.send.action' => 'Send',
          'sundayCard.send.invite' => 'Invite to send',
          'sundayCard.send.needsPartner' =>
            'To send the card in the app, your person has to be connected.',
          'sundayCard.send.title' => 'Send the card?',
          'sundayCard.send.text' => ({
            required Object name,
          }) => '${name} receives it now. Once sent, the card does not change.',
          'sundayCard.send.textNoName' =>
            'Your person receives it now. Once sent, the card does not change.',
          'sundayCard.send.confirm' => 'Send',
          'sundayCard.hold.action' => 'Hold this week',
          'sundayCard.hold.title' => 'Hold this week?',
          'sundayCard.hold.text' =>
            'The card is kept and nothing is lost. You can send it whenever you like.',
          'sundayCard.hold.confirm' => 'Hold',
          'sundayCard.held.title' => 'Held this week',
          'sundayCard.held.titleHighlight' => 'Held',
          'sundayCard.held.text' => 'Your card waits. Send it when you are ready. Nothing is lost.',
          'sundayCard.held.keepHolding' => 'Keep holding',
          'sundayCard.held.sendAnyway' => 'Send anyway',
          'sundayCard.sent.title' => 'Sent',
          'sundayCard.sent.text' => ({required Object name}) => 'The card went to ${name}.',
          'sundayCard.sent.textNoName' => 'The card went to your person.',
          'sundayCard.sent.done' => 'Done',
          'sundayCard.heldByRule.title' => 'Worth rereading before you send',
          'sundayCard.heldByRule.titleHighlight' => 'rereading',
          'sundayCard.heldByRule.reasons.absolute' =>
            'Words like “always” and “never” can sound like an accusation.',
          'sundayCard.heldByRule.reasons.insult' => 'A word on the card may hurt.',
          'sundayCard.heldByRule.reasons.blame' => 'The text sounds like blame instead of thanks.',
          'sundayCard.heldByRule.reasons.contempt' => 'The text may sound like contempt.',
          'sundayCard.heldByRule.reasons.other' => 'The text may sound harsher than you mean.',
          'sundayCard.heldByRule.reassurance' => 'Nothing was sent and nothing is lost.',
          'sundayCard.heldByRule.rewrite' => 'Rewrite',
          'sundayCard.heldByRule.sendAnyway' => 'Send anyway',
          'sundayCard.dayTitle' => 'Day',
          'sundayCard.dayError' => 'Could not change the day. The earlier one was kept.',
          'sundayCard.dayNote' => 'Applies to the next card.',
          'sundayCard.editTitle' => 'Edit this week',
          'sundayCard.editSubtitle' => 'Choose what goes in',
          'sundayCard.included' => 'Included',
          'sundayCard.notIncluded' => 'Not included',
          'sundayCard.preview' => 'Preview',
          'tabs.today' => 'Today',
          'tabs.slips' => 'Slips',
          'tabs.together' => 'Together',
          'tabs.memories' => 'Memories',
          'tabs.capture' => 'New slip',
          'tabs.soonTitle' => 'Under construction',
          'tabs.soonText' => 'This part of the app is still being prepared.',
          'tabs.segmentTogether' => 'Us',
          'tabs.forMeFooter' => 'Private tools. Never shared.',
          'tabs.segmentForMe' => 'For me',
          'tabs.checkinLabel' => 'CHECK-IN',
          'tabs.checkinTitle' => 'Weekly check-in',
          'tabs.checkinText' => 'A short conversation, private first.',
          'tabs.logisticsLabel' => 'PRACTICAL',
          'tabs.logisticsTitle' => 'Logistics meeting',
          'tabs.logisticsText' => 'The practical things, with nobody carrying them alone.',
          'tabs.listsLabel' => 'LISTS',
          'tabs.listsTitle' => 'Lists',
          'tabs.listsEmpty' => 'No lists yet. Start one together.',
          'tabs.listsEmptyPrivate' => 'No lists yet. Start one of your own.',
          'tabs.listsSharedCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 list, shared',
                  other: '${count} lists, shared',
                ),
          'tabs.listsPrivateCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 list, private',
                  other: '${count} lists, private',
                ),
          'tabs.soloNote' => 'When your partner joins, shared things show up here.',
          'tabs.ritualsLabel' => 'ROUTINE',
          'tabs.ritualsTitle' => 'Rituals',
          'tabs.ritualsText' => 'Small habits you want to protect.',
          'tabs.dateNightLabel' => 'DATE',
          'tabs.dateNightTitle' => 'Date night',
          'tabs.dateNightText' => 'Ideas for the two of you, picked together.',
          'tabs.partnerLabel' => 'JUST FOR YOU',
          'tabs.partnerTitle' => 'About your partner',
          'tabs.partnerText' => 'Private notes to remember what they like.',
          'tabs.chatLabel' => 'TALK',
          'tabs.chatTitle' => 'Mascot',
          'tabs.chatText' => 'A calm conversation that is not kept.',
          'tabs.hardTalkLabel' => 'HARD CONVERSATION',
          'tabs.hardTalkTitle' => 'Prepare a hard conversation',
          'tabs.hardTalkText' => 'The mascot helps you sort out what to say.',
          'tabs.notesLabel' => 'FOR YOUR PARTNER',
          'tabs.notesTitle' => 'A note or a drawing',
          'tabs.notesText' => 'Send something short and kind, whenever you like.',
          'tabs.usLabel' => 'US',
          'tabs.usTitle' => 'I miss us',
          'tabs.usText' => 'A light tap for your partner, no pressure.',
          'tabs.touchLabel' => 'TOUCH',
          'tabs.touchTitle' => 'Touch cards',
          _ => null,
        } ??
        switch (path) {
          'tabs.touchText' => 'Neutral, to do or skip.',
          'tabs.distanceLabel' => 'DISTANCE',
          'tabs.distanceTitle' => 'Our two clocks',
          'tabs.distanceText' => 'Time zones and the countdown to seeing each other.',
          'tabs.parentsLabel' => 'WITH PARENTS',
          'tabs.parentsText' => 'A short moment just for the two of you, even in a full house.',
          'tabs.capsulesLabel' => 'TIME CAPSULE',
          'tabs.capsulesTitle' => 'A message to the future',
          'tabs.capsulesText' => 'Stays closed until the day you choose.',
          'tabs.datesLabel' => 'DATES',
          'tabs.datesTitle' => 'Important dates',
          'tabs.datesText' => 'Birthdays, gifts and holidays, with a heads-up.',
          'tabs.badDayLabel' => 'HELP',
          'tabs.badDayTitle' => 'A hard day',
          'tabs.badDayText' => 'Three small things to do right now.',
          'tabs.starterLabel' => 'TALK',
          'tabs.starterTitle' => 'Start a conversation',
          'tabs.starterText' => 'A question to open with, no rush.',
          'tabs.dayLabel' => 'DAY',
          'tabs.dayTitle' => 'Day by day',
          'tabs.dayText' => 'What matters on each day.',
          'tabs.plusLabel' => 'PLAN',
          'tabs.plusTitle' => 'Free and Plus',
          'tabs.plusText' => 'What each plan includes, no pressure.',
          'tabs.temperatureLabel' => 'BETWEEN YOU',
          'tabs.temperatureTitle' => 'How is it between you?',
          'tabs.temperatureText' => 'A private check-in, never a score.',
          'tabs.learningLabel' => 'JUST FOR YOU',
          'tabs.learningTitle' => 'What you learned',
          'tabs.learningText' => 'Private notes you can delete.',
          'tabs.fightStyleLabel' => 'JUST FOR YOU',
          'tabs.guidesLabel' => 'CONVERSATIONS',
          'tabs.guidesTitle' => 'Difficult conversations',
          'tabs.guidesText' => 'One step at a time, just for you.',
          'tabs.gamesLabel' => 'GAMES',
          'tabs.gamesTitle' => 'Play together',
          'tabs.gamesText' => 'Short games, no scores and no winner.',
          'tabs.gamesLock' => 'Needs both of you',
          'tabs.sectionForYou' => 'For you two',
          'tabs.sectionTools' => 'Tools',
          'tabs.sectionMore' => 'More',
          'tabs.sectionPrivate' => 'Only yours',
          'tabs.logisticsMeta' => '15 min · weekly',
          'tabs.ritualsMeta' => 'Small habits',
          'tabs.dateNightMeta' => 'For you two',
          'tabs.programsMeta' => 'Micro-lessons',
          'tabs.checkinMeta' => 'Once a week',
          'tabs.questionMeta' => 'One for both',
          'tabs.gamesMeta' => 'No score',
          'tabs.datesMeta' => 'With a heads-up',
          'tabs.giftsMeta' => 'Only for you',
          'tabs.giftsMetaShared' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 shared wish',
                  other: '${count} shared wishes',
                ),
          'tabs.guidesMeta' => 'One step at a time',
          'tabs.starterMeta' => 'One question',
          'tabs.dayMeta' => 'One day at a time',
          'tabs.capsulesMeta' => 'For the future',
          'tabs.temperatureMeta' => 'Private, no score',
          'tabs.widgetsMeta' => 'On the home screen',
          'tabs.usMeta' => 'One touch',
          'tabs.touchMeta' => 'Neutral cards',
          'tabs.badDayMeta' => 'Three small things',
          'tabs.distanceMeta' => 'Time zones and reunion',
          'tabs.diaryMeta' => 'Only yours',
          'tabs.moodCalendarTitle' => 'My moods',
          'tabs.moodCalendarMeta' => 'Your month, only you',
          'tabs.hardTalkMeta' => 'Notes before you talk',
          'tabs.notesMeta' => 'When you want',
          'tabs.learningMeta' => 'Private notes',
          'tabs.partnerMeta' => 'Only for you',
          'tabs.chatMeta' => 'A calm conversation',
          'tabs.listsNone' => 'None yet',
          'tabs.needsBoth' => 'Needs both of you · Invite',
          'tabs.durationYearsMonths' => ({
            required Object years,
            required Object yearsUnit,
            required Object months,
            required Object monthsUnit,
          }) => '${years} ${yearsUnit} and ${months} ${monthsUnit}',
          'tabs.durationYears' => ({
            required Object years,
            required Object yearsUnit,
          }) => '${years} ${yearsUnit}',
          'tabs.durationMonths' => ({
            required Object months,
            required Object monthsUnit,
          }) => '${months} ${monthsUnit}',
          'tabs.durationDays' => ({
            required Object days,
            required Object daysUnit,
          }) => '${days} ${daysUnit}',
          'tabs.unitYear' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'year',
                  other: 'years',
                ),
          'tabs.unitMonth' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'month',
                  other: 'months',
                ),
          'tabs.unitDay' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'day',
                  other: 'days',
                ),
          'tabs.chat' => 'Chat',
          'tabs.couple' => 'Us',
          'tabs.storyChip' => 'Our story',
          'temperature.levelTitle' => 'How is it between you?',
          'temperature.levelHighlight' => 'between you',
          'temperature.levelNote' => 'Private. Never becomes a score.',
          'temperature.levels.good' => 'Good',
          'temperature.levels.soSo' => 'So-so',
          'temperature.levels.turbulent' => 'Turbulent',
          'temperature.levels.fight' => 'An argument',
          'temperature.levels.other' => '',
          'temperature.continueAction' => 'Continue',
          'temperature.back' => 'Back',
          'temperature.skip' => 'Not now',
          'temperature.intensityTitle' => 'How strong is it?',
          'temperature.intensityHighlight' => 'strong',
          'temperature.intensityHint' => 'Under 7 you can talk. Over 7, take a pause first.',
          'temperature.intensityHigh' => 'High value: how about a pause first?',
          'temperature.intensityLow' => 'Mild',
          'temperature.intensityTop' => 'Very strong',
          'temperature.intensityLabel' => 'Intensity',
          'temperature.result.good.title' => 'That\'s good',
          'temperature.result.good.text' => 'Saved just for you. Carry on with your day.',
          'temperature.result.pause.title' => 'First, breathe',
          'temperature.result.pause.text' => 'When it\'s very hot, waiting helps. Some time apart is worth it before any conversation.',
          'temperature.result.guided.title' => 'You can talk with care',
          'temperature.result.guided.text' => 'One step at a time, at your pace.',
          'temperature.result.quick.title' => 'A small fix is enough',
          'temperature.result.quick.text' => 'Something light and quick can do it.',
          'temperature.result.done' => 'Done',
          'temperature.errors.RATE_LIMITED' => 'Too many attempts in a row. Wait a moment.',
          'temperature.errors.other' => 'Couldn\'t save right now. Your answers are still here.',
          'temperature.history.action' => 'See the last weeks',
          'temperature.history.title' => 'Last 8 weeks',
          'temperature.history.titleHighlight' => '8 weeks',
          'temperature.history.subtitle' => 'One point per week, with the last answer given in it.',
          'temperature.history.chartLabel' => 'Temperature of each week, from calmest to a fight',
          'temperature.history.emptyTitle' => 'Nothing here yet',
          'temperature.history.emptyText' =>
            'When you answer how things are between you, the weeks show up here.',
          'temperature.history.note' =>
            'Only you see this. It never becomes a note and never goes to the other person.',
          'timeInApp.title' => 'Time in the app',
          'timeInApp.titleHighlight' => 'app',
          'timeInApp.text' => 'We hide cards and reminders until you come back.',
          'timeInApp.cancel' => 'Cancel',
          'today.greetingMorning' => ({required Object name}) => 'Good morning, ${name}',
          'today.greetingAfternoon' => ({required Object name}) => 'Good afternoon, ${name}',
          'today.greetingEvening' => ({required Object name}) => 'Good evening, ${name}',
          'today.greetingNoName' => 'Hello',
          'today.dateLine' => ({
            required Object weekday,
            required Object month,
            required Object day,
          }) => '${weekday}, ${month} ${day}',
          'today.weekdays.0' => 'Monday',
          'today.weekdays.1' => 'Tuesday',
          'today.weekdays.2' => 'Wednesday',
          'today.weekdays.3' => 'Thursday',
          'today.weekdays.4' => 'Friday',
          'today.weekdays.5' => 'Saturday',
          'today.weekdays.6' => 'Sunday',
          'today.months.0' => 'January',
          'today.months.1' => 'February',
          'today.months.2' => 'March',
          'today.months.3' => 'April',
          'today.months.4' => 'May',
          'today.months.5' => 'June',
          'today.months.6' => 'July',
          'today.months.7' => 'August',
          'today.months.8' => 'September',
          'today.months.9' => 'October',
          'today.months.10' => 'November',
          'today.months.11' => 'December',
          'today.invitePerson' => 'Invite your person',
          'today.pendingInviteTitle' => 'Invite sent',
          'today.pendingInviteText' => 'They have not joined yet. Send again or revoke.',
          'today.answer' => 'Answer',
          'today.slipsThisWeek' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  zero: 'No slips yet',
                  one: '1 slip this week',
                  other: '${count} slips this week',
                ),
          'today.weekHintEmpty' => 'no rush',
          'today.weekHint' => 'card for the week',
          'today.forToday' => 'For today',
          'today.ideaLabel' => 'Idea of the day',
          'today.sundayCardLabel' => 'Sunday card',
          'today.sundayCardTitle' => 'Your card for this week',
          'today.inviteCardLabel' => 'Invite',
          'today.inviteCardTitle' => ({required Object name}) => 'Invite ${name}',
          'today.inviteCardTitleNoName' => 'Invite your person',
          'today.inviteCardText' => 'Shared cards and tools need both of you.',
          'today.privateTag' => 'Only yours',
          'today.privateQuestion' => 'How was your day, really?',
          'today.privateHighlight' => 'day',
          'today.privateAction' => 'Note a slip',
          'today.emptyWeekTag' => 'No rush',
          'today.emptyWeekQuestion' => 'What was one good thing today?',
          'today.emptyWeekHighlight' => 'good',
          'today.emptyWeekAction' => 'Note a slip',
          'today.nothingReceived' => 'No new cards. No rush.',
          'today.cardReceived' => 'You received a card',
          'today.firstDayGreeting' => ({required Object name}) => 'Hi, ${name}',
          'today.firstDaySubtitle' => 'so glad you are here',
          'today.firstDayTag' => 'Good start',
          'today.firstDayTitle' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'You have 1 slip.',
                  other: 'You have ${count} slips.',
                ),
          'today.firstDayHighlight' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '1 slip',
                  other: '${count} slips',
                ),
          'today.firstDayText' =>
            'A slip is one good thing, in one line. On Sunday they become a card.',
          'today.firstDayAction' => 'Note one more',
          'today.errorTitle' => 'Could not load Today',
          'today.errorText' => 'Your slips are safe. Try again.',
          'today.cardReceivedNamed' => ({required Object name}) => '${name} sent you a card',
          'today.inviteCardSupport' =>
            'Your space already works. The other person joins whenever they want.',
          'today.inviteCardAction' => 'Invite',
          'today.carouselCardTag' => 'Card',
          'today.carouselCardSupport' => 'Open to see the good things from this week.',
          'today.carouselCardAction' => 'Open',
          'today.weekTag' => 'Your week',
          'today.weekReadyTitle' => 'Your week is ready',
          'today.weekReadySupport' => 'A summary of what you two did.',
          'today.weekReadySupportPrivate' => 'A summary just for you.',
          'today.weekReadyAction' => 'See',
          'today.haveCode' => 'I already have a code',
          'today.partnerProfile' => 'Partner profile',
          'today.privateWeekTitle' => 'Your private slips',
          'today.privateWeekCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  zero: 'no rush',
                  one: '1 this week',
                  other: '${count} this week',
                ),
          'today.conflict.tag' => 'Now',
          'today.conflict.title' => 'First, take care of you two',
          'today.conflict.highlight' => 'care',
          'today.conflict.text' =>
            'No common cards for now. Start with a repair or sort out what to say.',
          'today.conflict.repair' => 'Start the repair',
          'today.conflict.chat' => 'Talk to get organized',
          'today.questionTag' => 'Today',
          'today.partnerMomentTag' => 'For this moment',
          'today.partnerMomentSupport' => 'A small idea can help.',
          'today.partnerMomentAction' => 'See ideas',
          'today.offlineBand' => 'No connection. Showing what was already on your phone.',
          'unpair.appBarTitle' => 'Unpair',
          'unpair.title' => ({required Object name}) => 'Unpair from ${name}?',
          'unpair.text' => 'Shared cards and lists stop. Your notes stay with you.',
          'unpair.confirm' => 'Unpair',
          'unpair.cancel' => 'Cancel',
          'unpair.unnamedPartner' => 'your person',
          'unpair.done.title' => 'Unpaired',
          'unpair.done.highlight' => 'Unpaired',
          'unpair.done.text' => 'Your own data stays yours.',
          'unpair.done.keepOption' => 'Keep a copy of the shared items',
          'unpair.done.deleteOption' => 'Delete shared items',
          'unpair.done.plusNote' => 'The Plus that covered your partner ends.',
          'unpair.done.continueLabel' => 'Continue',
          'unpair.relationship.title' => 'Relationship',
          'unpair.relationship.unpair' => ({required Object name}) => 'Unpair from ${name}',
          'unpair.relationship.ended' => 'The relationship ended',
          'unpair.breakup.appBarTitle' => 'We broke up',
          'unpair.breakup.title' => 'I am sorry',
          'unpair.breakup.highlight' => 'sorry',
          'unpair.breakup.text' =>
            'You decide what to keep. Nothing is deleted without you wanting it.',
          'unpair.breakup.cancel' => 'Cancel',
          'unpair.breakup.continueLabel' => 'Continue',
          'unpair.partnerNotice.title' => ({required Object name}) => '${name} unpaired',
          'unpair.partnerNotice.titleNoName' => 'Your partner unpaired',
          'unpair.partnerNotice.highlight' => 'unpaired',
          'unpair.partnerNotice.text' => 'Your data stays yours. Shared cards stopped.',
          'unpair.partnerNotice.ok' => 'Ok',
          'unpair.errors.NETWORK' => 'No connection. Check your internet and try again.',
          'unpair.errors.STILL_PAIRED' => 'The relationship is still active. Try again.',
          'unpair.errors.other' => 'Could not unpair right now. Try again.',
          'weeklyReview.title' => 'Your week',
          'weeklyReview.titleHighlight' => 'week',
          'weeklyReview.range' => ({
            required Object month,
            required Object start,
            required Object end,
          }) => '${month} ${start} to ${end}',
          'weeklyReview.months.0' => 'January',
          'weeklyReview.months.1' => 'February',
          'weeklyReview.months.2' => 'March',
          'weeklyReview.months.3' => 'April',
          'weeklyReview.months.4' => 'May',
          'weeklyReview.months.5' => 'June',
          'weeklyReview.months.6' => 'July',
          'weeklyReview.months.7' => 'August',
          'weeklyReview.months.8' => 'September',
          'weeklyReview.months.9' => 'October',
          'weeklyReview.months.10' => 'November',
          'weeklyReview.months.11' => 'December',
          'weeklyReview.slips' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'slip',
                  other: 'slips',
                ),
          'weeklyReview.moodDays' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  zero: 'mood days',
                  one: 'mood day',
                  other: 'mood days',
                ),
          'weeklyReview.rituals' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  zero: 'rituals done',
                  one: 'ritual done',
                  other: 'rituals done',
                ),
          'weeklyReview.note' => 'Counted by the app, no AI. Only you see it.',
          'weeklyReview.talk' => 'Talk about it',
          'weeklyReview.close' => 'Close',
          'weeklyReview.quietTitle' => 'A quiet week',
          'weeklyReview.quietHighlight' => 'quiet',
          'weeklyReview.quietCardTitle' => 'No rush',
          'weeklyReview.quietCardText' =>
            'Writing a good thing takes 30 seconds. Start whenever you like.',
          'weeklyReview.quietNote' => 'Never compared with other weeks.',
          'weeklyReview.writeSlip' => 'Write a slip',
          'weeklyReview.errorTitle' => 'We could not open your week',
          'weeklyReview.errors.NETWORK' => 'No connection. Try again.',
          'weeklyReview.errors.other' => 'Something went wrong. Try again.',
          'welcome.headline' => 'Small good things, said out loud.',
          'welcome.headlineHighlight' => 'said out loud',
          'welcome.subtitle' => 'A light way to notice what the other does well, every week.',
          'welcome.start' => 'Get started',
          'welcome.haveAccount' => 'I already have an account',
          'welcome.debugSignIn' => 'Sign in (debug)',
          'widgets.settingsTitle' => 'Widgets',
          'widgets.settingsSubtitle' => 'Home screen',
          'widgets.togetherCategory' => 'HOME SCREEN',
          'widgets.togetherTitle' => 'Mingo widgets',
          'widgets.togetherSubtitle' => 'Calm reminders for you or for the two of you.',
          'widgets.galleryTitle' => 'Widgets',
          'widgets.segmentOwn' => 'Just mine',
          'widgets.segmentCouple' => 'Couple',
          'widgets.ownSlipLabel' => 'LOG SLIP',
          'widgets.ownSlipTitle' => '+ Slip',
          'widgets.ownSlipSubtitle' => 'Tap to log',
          'widgets.ownIdeaLabel' => 'DAILY IDEA',
          'widgets.ownIdeaDefault' => 'Leave a small note today',
          'widgets.ownIdeaHint' => 'One idea for today.',
          'widgets.ownJarLabel' => 'BAD DAY JAR',
          'widgets.ownJarTitle' => 'Open a saved slip',
          'widgets.ownJarPrivacy' => 'Private: only on your device',
          'widgets.lockScreenLabel' => 'LOCK SCREEN',
          'widgets.lockScreenDefault' => 'Calm reminder · No names',
          'widgets.coupleCounterLabel' => 'COUNTER',
          'widgets.coupleCounterUnset' => 'Set your relationship date to see days together',
          'widgets.coupleCounterDays' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '${count} day together',
                  other: '${count} days together',
                ),
          'widgets.couplePhotosLabel' => 'COUPLE PHOTOS · PLUS',
          'widgets.couplePhotosPrompt' => 'Choose a photo of you two',
          'widgets.couplePhotosPlusHint' => 'Available with Plus',
          'widgets.cardEncounterLabel' => 'CARD & DATE',
          'widgets.cardStateReady' => 'A card arrived · Tap to open',
          'widgets.cardStateSent' => 'Card sent · Waiting for Sunday',
          'widgets.cardStateNone' => 'Sunday card in preparation',
          'widgets.unpairedBanner' => 'No partner connected: couple widgets show a neutral state.',
          'widgets.offlineBanner' => 'Showing the last saved data. Updates when back online.',
          'widgets.loadErrorTitle' => 'Could not load widgets',
          'widgets.loadErrorBody' => 'Check your connection and try again.',
          'widgets.retryAction' => 'Try again',
          'widgets.themeLight' => 'Light',
          'widgets.themeDark' => 'Dark',
          'widgets.signedOutLabel' => 'Mingo',
          'widgets.signedOutBody' => 'Tap to sign in',
          'widgets.ownSmallPageTitle' => 'Widget · Mine (small)',
          'widgets.ownSmallSlipAction' => 'Log',
          'widgets.ownSmallDateDefaultTitle' => 'Next date',
          'widgets.ownSmallDateDays' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '${count} day',
                  other: '${count} days',
                ),
          'widgets.ownSmallMoodLabel' => 'MOOD',
          'widgets.ownSmallMoodPrompt' => 'How are you?',
          'widgets.ownSmallMoodOptions' => 'Happy · Tired · Sad',
          'widgets.ownSmallRitualLabel' => 'RITUAL',
          'widgets.ownSmallRitualDefaultTitle' => 'Sunday walk',
          'widgets.ownSmallRitualDefaultTime' => 'Sun · 10:00',
          'widgets.ownMediumPageTitle' => 'Widget · Mine (medium)',
          'widgets.ownMediumIdeaAction' => 'Tap to view',
          'widgets.ownMediumJarTitle' => 'Tap to open a saved slip',
          'widgets.ownMediumJarPrivacy' => 'Private: only appears on your device',
          'widgets.lockScreenPageTitle' => 'Lock screen',
          'widgets.lockScreenClockTime' => '19:38',
          'widgets.lockScreenClockDate' => 'Friday, April 10',
          'widgets.lockScreenReadyAction' => 'I am ready',
          'widgets.lockScreenGenericPhrase' => 'Calm moment',
          'widgets.lockScreenPrivacyRule' => 'Never shows names or messages on the lock screen.',
          'widgets.lockScreenDisabledNote' =>
            'The lock-screen widget is turned off in widget settings.',
          'widgets.lockScreenFamiliesTitle' => 'iOS formats (Circular, Rectangular and Inline)',
          'widgets.counterPageTitle' => 'Widget · Counter',
          'widgets.counterYearsMonthsTitle' => ({
            required Object years,
            required Object months,
          }) => '${years} years · ${months} months',
          'widgets.counterMonthsDaysSubtitle' => ({
            required Object months,
            required Object days,
          }) => '${months} months · ${days} days',
          'widgets.counterStatusDating' => 'Dating',
          'widgets.counterStatusLivingTogether' => 'Living together',
          'widgets.counterStatusMarried' => 'Married',
          'widgets.counterStatusTogether' => 'Together',
          'widgets.counterMidnightNote' => 'The counter updates automatically at local midnight.',
          'widgets.counterSetDateAction' => 'Set relationship date',
          'widgets.photosPageTitle' => 'Widget · Couple photos',
          'widgets.photosPlusBadge' => 'PLUS',
          'widgets.photosNeutralFallbackNote' => 'When no photo is saved on this device, the widget shows only the neutral card with the time together.',
          'widgets.photosUnlockPlusAction' => 'Explore Plus',
          'widgets.photosChooseAction' => 'Choose photo',
          'widgets.photosRemoveAction' => 'Remove photo',
          'widgets.photosSavedToast' => 'Photo saved to the widget.',
          'widgets.photosRemovedToast' => 'Photo removed from the widget.',
          'widgets.cardEncounterPageTitle' => 'Card & next date',
          'widgets.cardWeeklyLabel' => 'Weekly card',
          'widgets.cardReadyTitle' => 'A card arrived',
          'widgets.cardReadySubtitle' => 'Tap to open',
          'widgets.cardSentTitle' => 'Card sent',
          'widgets.cardSentSubtitle' => 'Waiting for Sunday',
          'widgets.cardNoneTitle' => 'Sunday card',
          'widgets.cardNoneSubtitle' => 'In preparation',
          'widgets.nextEncounterLabel' => 'Next date',
          'widgets.nextEncounterEmptyTitle' => 'No upcoming date',
          'widgets.nextEncounterEmptySubtitle' => 'Tap to schedule',
          'widgets.cardEncounterPrivacyNote' =>
            'This widget only shows card status and the next date — never names or card text.',
          'widgets.statesUnpairedTitle' => 'Invite to see here',
          'widgets.statesUnpairedAction' => 'Invite',
          'widgets.errors.WIDGET_PREFERENCES_SAVE_FAILED' =>
            'Could not save widget preferences right now.',
          'widgets.errors.COUPLE_PHOTO_LOAD_FAILED' => 'Could not load the couple photo right now.',
          'widgets.errors.COUPLE_PHOTO_UPLOAD_FAILED' =>
            'Could not save the couple photo right now.',
          'widgets.errors.COUPLE_PHOTO_REMOVE_FAILED' =>
            'Could not remove the couple photo right now.',
          'widgets.errors.COUPLE_PHOTO_INVALID' =>
            'Choose a JPG, PNG, WebP or HEIC image up to 8 MB.',
          'widgets.errors.COUPLE_PHOTO_READ_FAILED' => 'Could not read the selected file.',
          'widgets.errors.COUPLE_PHOTO_PICK_FAILED' => 'Could not open the photo picker.',
          'widgets.errors.COUPLE_PHOTO_SIGNED_OUT' => 'Sign in to choose a couple photo.',
          'widgets.errors.COUPLE_PHOTO_NOT_PAIRED' =>
            'Connect with your partner to choose a couple photo.',
          'widgets.errors.other' => 'Could not save widget preferences right now.',
          'widgets.howToAddAndroidLockNote' => 'On modern Android the widgets live on the home screen. The lock screen only uses neutral notification icons.',
          'widgets.howToAddIosLockNote' =>
            'On iOS 16 or newer, you can also add the widget to the lock screen.',
          'widgets.coupleLabel' => 'COUPLE',
          'widgets.gallerySubtitle' => 'Small pieces of the app on your home screen.',
          'widgets.favoritesGroup' => 'Most loved',
          'widgets.mediumGroup' => 'Medium',
          'widgets.ownSmallGroup' => 'Log and remember',
          'widgets.ownGroupHint' => 'Work without a partner and only show what is yours.',
          'widgets.ownSmallEntryTitle' => 'Small',
          'widgets.ownSmallEntryHint' => 'Log, remember and the Sunday card.',
          'widgets.ownMediumEntryTitle' => 'Medium',
          'widgets.ownMediumEntryHint' => 'Your week, an idea and the next date.',
          'widgets.ownSmallTitle' => 'Just mine: small',
          'widgets.ownMediumTitle' => 'Just mine: medium',
          'widgets.counterEyebrow' => 'TOGETHER',
          'widgets.counterNeedDate' => 'Set your relationship date',
          'widgets.counterDaysUnit' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '${count} day',
                  other: '${count} days',
                ),
          'widgets.counterBreakdown' => ({
            required Object years,
            required Object months,
            required Object days,
          }) => '${years} years, ${months} months and ${days} days',
          'widgets.counterToday' => 'Today',
          'widgets.counterSince' => ({required Object date}) => 'Since ${date}',
          'widgets.partnerMoodLabel' => 'PARTNER MOOD',
          'widgets.partnerMoodNow' => ({required Object name}) => '${name} now',
          'widgets.partnerMoodNowAnonymous' => 'Now',
          'widgets.partnerMoodHidden' => 'Mood appears when your partner shares it.',
          'widgets.longingLabel' => 'MISSING US',
          'widgets.longingAction' => 'Send some missing',
          'widgets.longingReceived' => 'Your partner misses you',
          'widgets.longingHint' => 'One tap and they feel it.',
          'widgets.ritualLabel' => 'RITUAL',
          'widgets.ritualEmptyTitle' => 'Create a ritual',
          'widgets.ritualEmptyHint' => 'A moment that is yours.',
          'widgets.noteFromPartner' => ({required Object time}) => 'from your partner · ${time}',
          'widgets.noteFromName' => ({
            required Object name,
            required Object time,
          }) => 'from ${name} · ${time}',
          'widgets.noteEmpty' => 'No note here yet',
          'widgets.noteEmptyHint' => 'A note appears when your partner chooses to send one.',
          'widgets.noteDisabled' => 'Notes are off',
          'widgets.noteDisabledHint' => 'Turn on “Notes on the widget” to see them.',
          'widgets.nextEncounterInDays' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: 'in ${count} day',
                  other: 'in ${count} days',
                ),
          'widgets.cardSundayTitle' => 'Sunday card',
          'widgets.cardSendAt' => ({
            required Object day,
            required Object time,
          }) => 'out ${day}, ${time}',
          'widgets.cardReadyShort' => 'A card arrived',
          'widgets.cardSentShort' => 'Card sent',
          'widgets.cardNoneShort' => 'Sunday card',
          'widgets.distanceLabel' => 'LONG DISTANCE',
          'widgets.distanceHidden' => 'Your partner\'s timezone is not set',
          'widgets.distanceHint' => 'Each in their own timezone.',
          'widgets.distanceUntil' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '${count} day until you meet',
                  other: '${count} days until you meet',
                ),
          'widgets.distanceNoReunion' => 'Next meeting without a date',
          'widgets.distanceYou' => ({required Object city}) => '${city} · you',
          'widgets.ownNextDateLabel' => 'NEXT DATE',
          'widgets.ownNextDateHint' => 'Tap to see the dates',
          'widgets.ownDateCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '${count} day',
                  other: '${count} days',
                ),
          'widgets.ownWeekTitle' => 'My week',
          'widgets.ownWeekCount' =>
            ({required num count}) =>
                (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
                  count,
                  one: '${count} slip',
                  other: '${count} slips',
                ),
          'widgets.weekdays.0' => 'mon',
          'widgets.weekdays.1' => 'tue',
          'widgets.weekdays.2' => 'wed',
          'widgets.weekdays.3' => 'thu',
          'widgets.weekdays.4' => 'fri',
          'widgets.weekdays.5' => 'sat',
          'widgets.weekdays.6' => 'sun',
          'widgets.familyLabels.counter' => 'Counter',
          'widgets.familyLabels.counterMedium' => 'Counter',
          'widgets.familyLabels.partnerMood' => 'Partner mood',
          'widgets.familyLabels.longing' => 'Missing us',
          'widgets.familyLabels.ritual' => 'Ritual',
          'widgets.familyLabels.partnerNote' => 'Partner note',
          'widgets.familyLabels.cardEncounter' => 'Card & date',
          'widgets.familyLabels.distance' => 'Long distance',
          'widgets.familyLabels.ownSlip' => 'Log slip',
          'widgets.familyLabels.ownNextDate' => 'Next date',
          'widgets.familyLabels.ownRitual' => 'Ritual',
          'widgets.familyLabels.ownSundayCard' => 'Sunday card',
          'widgets.familyLabels.ownWeek' => 'My week',
          'widgets.familyLabels.ownIdea' => 'Idea of the day',
          'widgets.familyLabels.ownMediumDate' => 'Next date',
          'widgets.familyLabels.other' => 'Widget',
          'widgets.moodJustNow' => 'just now',
          'widgets.moodMinutesAgo' => ({required Object minutes}) => '${minutes} min ago',
          'widgets.moodHoursAgo' => ({required Object hours}) => '${hours} h ago',
          'widgets.moodDaysAgo' => ({required Object days}) => '${days} d ago',
          'widgets.ownSlipQuestion' => 'How was your day?',
          'widgets.ownSlipAction' => 'Log a slip',
          'widgets.howToAddAction' => 'How to add',
          'widgets.howToAddTitle' => 'How to add',
          'widgets.howToAddSubtitle' =>
            'Straight from the home screen, with no extra Mingo permission.',
          'widgets.howToAddIosStep1' => 'Touch and hold an empty spot on the home screen.',
          'widgets.howToAddIosStep2' => 'Tap + in the top corner.',
          'widgets.howToAddIosStep3' => 'Choose Mingo and the widget size.',
          'widgets.howToAddAndroidStep1' => 'Touch and hold an empty spot on the home screen.',
          'widgets.howToAddAndroidStep2' => 'Tap Widgets.',
          'widgets.howToAddAndroidStep3' => 'Choose Mingo and drag it to the screen.',
          'widgets.howToAddLockIosStep1' => 'Touch and hold the lock screen.',
          'widgets.howToAddLockIosStep2' => 'Tap Customize.',
          'widgets.howToAddLockIosStep3' => 'Add the Mingo widget below the clock.',
          'widgets.howToAddNote' =>
            'You can remove the widget whenever you want; nothing is deleted.',
          'widgets.widgetPrivacyTitle' => 'What appears on widgets',
          'widgets.showNamesTitle' => 'Names and initials',
          'widgets.showNamesHint' => 'When off, widgets show only the content.',
          'widgets.allowNotesTitle' => 'Notes on the widget',
          'widgets.allowNotesHint' => 'Only notes your partner marked for the widget.',
          'widgets.privacySectionHint' =>
            'Follows your privacy choices. What is hidden in the app stays hidden here.',
          'widgets.settingsSaved' => 'Preferences updated.',
          'widgets.lockScreenCircular' => 'Circular',
          'widgets.lockScreenRectangular' => 'Rectangular',
          'widgets.lockScreenInline' => 'Inline',
          'widgets.lockScreenNeutralLabel' => 'NEUTRAL TEXT',
          'widgets.lockScreenNeutralPhrase' => 'No names on the lock screen',
          'widgets.lockScreenAndroidUnavailable' =>
            'The Android lock screen does not accept widgets. Use the home-screen widgets.',
          'widgets.ownNextDateDefault' => 'Next date',
          'widgets.ownSundayCardLabel' => 'SUNDAY CARD',
          'widgets.ownGroupTitle' => 'Just mine',
          'widgets.soloBanner' => 'Couple widgets appear once you connect.',
          'widgets.previewSmall' => 'Small',
          'widgets.previewMedium' => 'Medium',
          'widgets.counterSmallLabel' => 'Small',
          'widgets.counterMediumLabel' => 'Medium, with timeline',
          'widgets.partnerNotePageTitle' => 'Partner note',
          'widgets.partnerNotePrivacy' =>
            'Only what your partner chose to send to the widget appears.',
          'widgets.moodLongingPageTitle' => 'Mood and missing',
          'widgets.partnerMoodPrivacy' => 'Mood only appears if your partner shared it.',
          'widgets.longingPrivacy' => 'Missing appears when your partner sends it.',
          'widgets.moodUpdateAction' => 'Update my mood',
          'widgets.openDatesAction' => 'See dates',
          'widgets.lockReminderShortLabel' => 'Reminder',
          _ => null,
        };
  }
}
