import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

/// The row a person chose in the [BasePhotoPicker] source sheet.
enum BasePhotoSource() {
  /// Take a new photo with the camera.
  camera,

  /// Choose an existing photo from the library.
  library,

  /// Use an initial on a theme color instead of a photo.
  initial,

  /// Remove the current photo.
  remove,
}

/// The source sheet of the photo flow: a list group of rows with 32 point icon tiles.
///
/// Permission handling, picking and cropping belong to the feature; this only asks where the photo comes
/// from. Cancelling resolves with null and keeps the old photo.
abstract final class BasePhotoPicker() {
  /// Shows the sheet and resolves with the chosen [BasePhotoSource], or null when dismissed.
  ///
  /// [hasCamera] false hides the camera row; [hasPhoto] true adds the destructive remove row.
  static Future<BasePhotoSource?> show(
    BuildContext context, {
    bool hasPhoto = false,
    bool hasCamera = true,
  }) {
    final l10n = context.designSystemL10nOrBase.media;

    return BaseSheet.show<BasePhotoSource>(
      context: context,
      child: Builder(
        builder: (sheetContext) {
          void pick(BasePhotoSource source) => Navigator.of(sheetContext).pop(source);

          return BaseListGroup(
            children: [
              if (hasCamera)
                BaseListTile(
                  icon: AppIcons.camera,
                  title: l10n.takePhoto,
                  onTap: () => pick(.camera),
                ),
              BaseListTile(
                icon: AppIcons.image,
                title: l10n.chooseFromLibrary,
                onTap: () => pick(.library),
              ),
              BaseListTile(
                icon: AppIcons.initial,
                title: l10n.useInitial,
                onTap: () => pick(.initial),
              ),
              if (hasPhoto)
                BaseListTile(
                  icon: AppIcons.trash,
                  title: l10n.removePhoto,
                  isDestructive: true,
                  onTap: () => pick(.remove),
                ),
            ],
          );
        },
      ),
    );
  }
}
