import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/mappers/invite_code_mapper.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/deep_links/deep_link_handler.dart';
import 'package:auto_route/auto_route.dart';

/// Opens the accept page for an invite link, keeping the code while the person signs in.
class InviteDeepLinkHandler({
  required final InviteCodeStore _inviteCodes,
  required final AuthenticationRepository _authentication,
}) implements DeepLinkHandler {
  @override
  Future<List<PageRouteInfo>?> resolve(Uri uri) async {
    final code = inviteCodeFromUri(uri);
    if (code == null) return null;

    if (!_authentication.isAuthenticated) await _inviteCodes.save(code);

    return [const HomeRoute(), AcceptInviteRoute(code: code)];
  }
}
