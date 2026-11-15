import 'package:app/features/dev_menu/storybook/helpers/widgets/gallery_widgets.dart';
import 'package:design_system/design_system.dart';

class const LooseListTilePage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GalleryPage(
      title: 'Loose list tile',
      children: [
        GallerySurface(
          child: BaseListTile(
            title: 'Privacy',
            subtitle: 'Who can see your answers',
            icon: AppIcons.lock,
            showsChevron: true,
            isLoose: true,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
