import 'package:arequipa_bus/arequipa_bus_theme.dart';
import 'package:arequipa_bus/default_values.dart';
import 'package:arequipa_bus/lifecycle_reactor_notification.dart';
import 'package:arequipa_bus/pages/survey/repository/survey_hive_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:async_executor/async_executor.dart';

import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/blocs/map_tile_provider/map_tile_provider.dart';
import 'package:trufi_core/base/blocs/theme/theme_cubit.dart';
import 'package:trufi_core/base/models/trufi_latlng.dart';
import 'package:trufi_core/base/utils/certificates_letsencrypt_android.dart';
import 'package:trufi_core/base/utils/graphql_client/hive_init.dart';
import 'package:trufi_core/base/utils/trufi_app_id.dart';
import 'package:trufi_core/base/widgets/drawer/menu/social_media_item.dart';
import 'package:trufi_core/trufi_core.dart';
import 'package:trufi_core/trufi_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter(boxes: [
    ...listPathsHive,
    SurveyHiveLocalRepository.path,
  ]);
  await CertificatedLetsencryptAndroid.workAroundCertificated();
  await TrufiAppId.initialize();
  runApp(
    TrufiCore(
      appNameTitle: 'Arequipa Bus',
      trufiLocalization: ArequipaBusDefaultValues.trufiLocalization(
        currentLocale: const Locale("es"),
      ),
      trufiBaseTheme: TrufiBaseTheme(
        themeMode: ThemeMode.system,
        brightness: Brightness.light,
        theme: theme,
        darkTheme: themeDark,
      ),
      blocProviders: [
        ...ArequipaBusDefaultValues.blocProviders(
          otpEndpoint: "https://arequipabus.app/otp/routers/default",
          otpGraphqlEndpoint:
              "https://arequipabus.app/otp/routers/default/index/graphql",
          mapConfiguration: MapConfiguration(
            center: const TrufiLatLng(-16.4090, -71.5375),
            feedbackForm: "https://forms.gle/QMLhJT7N44Bh9zBN6",
          ),
          // customRequestPlanService: GraphqlRequestPlan(
          //   "https://arequipabus.app/otp/routers/default/index/graphql",
          // ),
          searchAssetPath: "assets/data/search.json",
          photonUrl: "https://arequipabus.app/photon",
          querySearchParameters: {
            "bbox":
                "-71.6969739304, -16.5803448859, -71.408492046, -16.2889070545",
          },
          mapTileProviders: [
            OSMMapLayer(
              mapTilesUrl:
                  "http://arequipabus.app/static-maps/trufi-liberty/{z}/{x}/{y}@2x.jpg",
            ),
          ],
          layersContainer: [],
          additionalProviders: [],
        ),
      ],
      trufiRouter: TrufiRouter(
        routerDelegate: ArequipaBusDefaultValues.routerDelegate(
          appName: 'Arequipa Bus',
          cityName: 'Arequipa',
          countryName: 'Perú',
          backgroundImageBuilder: (_) {
            return Image.asset(
              'assets/images/drawer-bg.jpg',
              fit: BoxFit.cover,
            );
          },
          emailContact: 'feedback@trufi.app',
          urlShareApp: 'https://arequipabus.app/app-stores/',
          urlSocialMedia: const UrlSocialMedia(
            urlFacebook: 'https://www.facebook.com/MuniArequipa',
            urlInstagram: 'https://www.instagram.com/muni.arequipa/',
            urlTiktok: 'https://www.tiktok.com/@muni.arequipa',
            urlYoutube: 'https://www.youtube.com/user/muniArequipa/',
            urlTwitter: 'https://twitter.com/arequipamuni',
          ),
          shareBaseUri: Uri(
            scheme: "https",
            host: "arequipabus.app",
          ),
          lifecycleReactorHandler: LifecycleReactorNotifications2(
            url: 'https://arequipabus.app/static_files/notification.json',
          ),
          asyncExecutor: AsyncExecutor(
            errorMessage: (
              BuildContext context,
              dynamic error,
            ) async {
              await showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text(
                        "Lo sentimos, no pudimos encontrar una ruta."),
                    content: const Text(
                        "Viaje no disponible.\nEl punto de origen y/o destino no coincide con las rutas disponibles. Por favor, modifica los puntos de origen y destino."),
                    actions: [
                      TextButton(
                        child: const Text(
                            "Prueba con otro origen o destino destino"),
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          urlFeedback: 'https://example/feedback',
        ),
      ),
    ),
  );
}
