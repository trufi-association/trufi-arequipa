import 'package:arequipa_bus/pages/about/about.dart';
import 'package:arequipa_bus/pages/about/translations/ab_about_localizations.dart';
import 'package:arequipa_bus/pages/feedback/feedback.dart';
import 'package:arequipa_bus/pages/feedback/translations/ab_feedback_localizations.dart';
import 'package:arequipa_bus/pages/survey/survey_cubit/survey_cubit.dart';
import 'package:arequipa_bus/pages/survey/widgets/survey_button.dart';
import 'package:arequipa_bus/pages/survey/translations/ab_survey_localizations.dart';
import 'package:async_executor/async_executor.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trufi_core/base/blocs/map_layer/map_layer.dart';
import 'package:trufi_core/base/blocs/map_layer/map_layers_cubit.dart';

import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/blocs/map_tile_provider/map_tile_provider.dart';
import 'package:trufi_core/base/blocs/map_tile_provider/map_tile_provider_cubit.dart';
import 'package:trufi_core/base/blocs/panel/panel_cubit.dart';
import 'package:trufi_core/base/models/map_provider_collection/leaflet_map_collection.dart';
import 'package:trufi_core/base/models/map_provider_collection/trufi_map_definition.dart';
import 'package:trufi_core/base/pages/home/home.dart';
import 'package:trufi_core/base/pages/home/services/request_plan_service.dart';
import 'package:trufi_core/base/pages/saved_places/saved_places.dart';
import 'package:trufi_core/base/pages/saved_places/translations/saved_places_localizations.dart';
import 'package:trufi_core/base/pages/splash_screen/splash_screen.dart';
import 'package:trufi_core/base/pages/transport_list/translations/transport_list_localizations.dart';
import 'package:trufi_core/base/pages/transport_list/transport_list.dart';
import 'package:trufi_core/base/providers/transit_route/route_transports_cubit/route_transports_cubit.dart';
import 'package:trufi_core/base/widgets/drawer/menu/default_item_menu.dart';
import 'package:trufi_core/base/widgets/drawer/menu/default_pages_menu.dart';
import 'package:trufi_core/base/widgets/drawer/menu/trufi_menu_item.dart';
import 'package:trufi_core/base/widgets/drawer/menu/social_media_item.dart';
import 'package:trufi_core/base/widgets/drawer/trufi_drawer.dart';
import 'package:trufi_core/base/widgets/screen/lifecycle_reactor_wrapper.dart';
import 'package:trufi_core/base/widgets/screen/screen_helpers.dart';
import 'package:trufi_core/base/blocs/localization/trufi_localization_cubit.dart';
import 'package:trufi_core/base/pages/home/route_planner_cubit/route_planner_cubit.dart';
import 'package:trufi_core/base/pages/saved_places/repository/search_location/default_search_location.dart';
import 'package:trufi_core/base/pages/saved_places/search_locations_cubit/search_locations_cubit.dart';
import 'package:trufi_core/realtime/realtime_routes_cubit/realtime_routes_cubit.dart';

abstract class ArequipaBusDefaultValues {
  static TrufiLocalization trufiLocalization({Locale? currentLocale}) =>
      TrufiLocalization(
        currentLocale: currentLocale ?? const Locale("en"),
        localizationDelegates: const [
          SavedPlacesLocalization.delegate,
          ABFeedbackLocalization.delegate,
          ABAboutLocalization.delegate,
          ABSurveyLocalization.delegate,
          TransportListLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
      );

  static List<BlocProvider> blocProviders({
    required String otpEndpoint,
    required String otpGraphqlEndpoint,
    required MapConfiguration mapConfiguration,
    required String searchAssetPath,
    required String photonUrl,
    Map<String, dynamic>? querySearchParameters,
    List<MapLayerContainer>? layersContainer,
    RequestPlanService? customRequestPlanService,
    List<MapTileProvider>? mapTileProviders,
    List<BlocProvider> additionalProviders = const [],
    bool useCustomMapProvider = false,
  }) {
    final routeTransportsCubit = RouteTransportsCubit(otpGraphqlEndpoint);
    return [
      BlocProvider<RouteTransportsCubit>(
        create: (context) => routeTransportsCubit,
      ),
      BlocProvider<SearchLocationsCubit>(
        create: (context) => SearchLocationsCubit(
          searchLocationRepository: DefaultSearchLocation(
            searchAssetPath,
            photonUrl: photonUrl,
            queryParameters: querySearchParameters,
          ),
        ),
      ),
      BlocProvider<RoutePlannerCubit>(
        create: (context) => RoutePlannerCubit(
          otpEndpoint,
          customRequestPlanService: customRequestPlanService,
        ),
      ),
      BlocProvider<MapConfigurationCubit>(
        create: (context) => MapConfigurationCubit(mapConfiguration),
      ),
      BlocProvider<MapLayersCubit>(
        create: (context) => MapLayersCubit([]),
      ),
      BlocProvider<PanelCubit>(
        create: (context) => PanelCubit(),
      ),
      if (!useCustomMapProvider)
        BlocProvider<MapTileProviderCubit>(
          create: (context) => MapTileProviderCubit(
            mapTileProviders: mapTileProviders ?? [OSMDefaultMapTile()],
          ),
        ),
      BlocProvider<RealtimeRoutesCubit>(
        create: (context) => RealtimeRoutesCubit(
          otpEndpoint:
              "https://arequipabus.muniarequipa.gob.pe/otp/routers/default/index/graphql",
          routeTransportsCubit: routeTransportsCubit,
        ),
      ),
      BlocProvider<SurveyCubit>(
        create: (context) => SurveyCubit(
          surveyUpdate: "https://arequipabus.muniarequipa.gob.pe/Survey/response",
        ),
        lazy: false,
      ),
      ...additionalProviders
    ];
  }

  static RouterDelegate<Object> routerDelegate({
    required String appName,
    required String cityName,
    required String countryName,
    WidgetBuilder? backgroundImageBuilder,
    AsyncExecutor? asyncExecutor,
    required String urlShareApp,
    required String urlFeedback,
    required String emailContact,
    UrlSocialMedia? urlSocialMedia,
    ITrufiMapProvider? trufiMapProvider,
    Uri? shareBaseUri,
    LifecycleReactorHandler? lifecycleReactorHandler,
  }) {
    final mapCollectionSelected = trufiMapProvider ?? LeafletMapCollection();
    generateDrawer(String currentRoute) {
      return (BuildContext _) => TrufiDrawer(
            currentRoute,
            appName: appName,
            countryName: countryName,
            cityName: cityName,
            backgroundImageBuilder: backgroundImageBuilder,
            urlShareApp: urlShareApp,
            menuItems: quirquiMenuItems(defaultUrls: urlSocialMedia),
          );
    }

    return RoutemasterDelegate(
      routesBuilder: (routeContext) {
        return RouteMap(
          onUnknownRoute: (_) => const Redirect(SplashScreen.route),
          routes: {
            SplashScreen.route: (route) {
              return NoAnimationPage(
                lifecycleReactorHandler: lifecycleReactorHandler,
                child: const SplashScreen(),
              );
            },
            HomePage.route: (route) {
              return NoAnimationPage(
                child: HomePage(
                  drawerBuilder: generateDrawer(HomePage.route),
                  mapRouteProvider: mapCollectionSelected.mapRouteProvider(
                    shareBaseItineraryUri: shareBaseUri?.replace(
                      path: "/app/Home",
                    ),
                    overlapWidget: (context) {
                      return const SurveyButton();
                    },
                  ),
                  mapChooseLocationProvider:
                      mapCollectionSelected.mapChooseLocationProvider(),
                  asyncExecutor: asyncExecutor ?? AsyncExecutor(),
                ),
              );
            },
            TransportList.route: (route) {
              return NoAnimationPage(
                child: TransportList(
                  drawerBuilder: generateDrawer(TransportList.route),
                  mapTransportProvider:
                      mapCollectionSelected.mapTransportProvider(
                    shareBaseRouteUri: shareBaseUri?.replace(
                      path: "/app/TransportList",
                    ),
                  ),
                  mapRouteEditorProvider:
                      mapCollectionSelected.mapRouteEditorProvider(),
                ),
              );
            },
            SavedPlacesPage.route: (route) {
              return NoAnimationPage(
                child: SavedPlacesPage(
                  drawerBuilder: generateDrawer(SavedPlacesPage.route),
                  mapChooseLocationProvider:
                      mapCollectionSelected.mapChooseLocationProvider(),
                ),
              );
            },
            ABFeedbackPage.route: (route) => NoAnimationPage(
                  child: ABFeedbackPage(
                    urlFeedback: urlFeedback,
                    drawerBuilder: generateDrawer(ABFeedbackPage.route),
                  ),
                ),
            ABAboutPage.route: (route) => NoAnimationPage(
                  child: ABAboutPage(
                    appName: appName,
                    cityName: cityName,
                    countryName: countryName,
                    emailContact: emailContact,
                    drawerBuilder: generateDrawer(ABAboutPage.route),
                  ),
                ),
          },
        );
      },
    );
  }
}

List<List<TrufiMenuItem>> quirquiMenuItems({
  required UrlSocialMedia? defaultUrls,
}) {
  return [
    [
      ...[
        DefaultPagesMenu.homePage,
        DefaultPagesMenu.transportList,
        DefaultPagesMenu.savedPlaces,
      ].map((menuPage) => menuPage.toMenuPage()).toList(),
      MenuPageItem(
        id: ABFeedbackPage.route,
        selectedIcon: (context) => Icon(
          Icons.feedback,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        notSelectedIcon: (context) => const Icon(
          Icons.feedback,
          color: Colors.grey,
        ),
        name: (context) {
          return ABFeedbackLocalization.of(context)!.menuFeedback;
        },
      ),
      MenuPageItem(
        id: ABAboutPage.route,
        selectedIcon: (context) => Icon(
          Icons.info,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        notSelectedIcon: (context) => const Icon(
          Icons.info,
          color: Colors.grey,
        ),
        name: (context) {
          return ABAboutLocalization.of(context)!.menuAbout;
        },
      ),
    ],
    [
      if (defaultUrls != null && defaultUrls.existUrl)
        defaultSocialMedia(defaultUrls),
      ...DefaultItemsMenu.values
          .map((menuPage) => menuPage.toMenuItem())
          .toList(),
    ]
  ];
}
