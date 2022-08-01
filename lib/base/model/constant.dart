import 'package:community_material_icon/community_material_icon.dart';
import 'package:latlng/latlng.dart';
import '../app_lib.dart';

class Constants {
  //language
  static String appName = 'Flutter Demo';
  static Locale english = const Locale('en', 'US');

  static String jessica = 'Jessica Shultz';
  static String roman = 'Roman Kamushkenz';
  static double drawerWidth = 306.0;
  static bool isDarkTheme = false;
  static String darkMode =
      '[ { "elementType": "geometry", "stylers": [ { "color": "#212121" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#212121" } ] }, { "featureType": "administrative", "elementType": "geometry", "stylers": [ { "color": "#757575" } ] }, { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "administrative.land_parcel", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#181818" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "poi.park", "elementType": "labels.text.stroke", "stylers": [ { "color": "#1b1b1b" } ] }, { "featureType": "road", "elementType": "geometry.fill", "stylers": [ { "color": "#2c2c2c" } ] }, { "featureType": "road", "elementType": "labels.text.fill", "stylers": [ { "color": "#8a8a8a" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#373737" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#3c3c3c" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#4e4e4e" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "transit", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#3d3d3d" } ] } ]';
  static List<List<Object>> bottomNavItems = <List<Object>>[
    <Object>[
      CommunityMaterialIcons.shopping,
      LanguageKey.discover,
    ],
    <Object>[
      CommunityMaterialIcons.book_open_variant,
      LanguageKey.catalogue,
    ],
    <Object>[
      CommunityMaterialIcons.cart,
      LanguageKey.cart,
    ],
    <Object>[
      CommunityMaterialIcons.tag_heart,
      LanguageKey.whitelist,
    ],
    <Object>[
      // Mdi.accountCog,
      LanguageKey.account,
    ],
  ];

  static List<String> tabFruits = [
    LanguageKey.fruits,
    LanguageKey.vegetables,
    LanguageKey.moreFruits,
    LanguageKey.juicesJuices,
  ];

  static List<String> tabTour = [
    LanguageKey.deals,
    LanguageKey.discounts,
    LanguageKey.placeToVisit,
    LanguageKey.bestSellers,
  ];

  static List<String> tabWedding = [
    LanguageKey.grid,
    LanguageKey.discounts,
    LanguageKey.newArrivals,
    LanguageKey.bestSellers
  ];

  static List<String> tabActive = [
    LanguageKey.active,
    LanguageKey.upcoming,
    LanguageKey.finished,
  ];
  static List<String> profileOne = [
    LanguageKey.forYou,
    LanguageKey.account,
    LanguageKey.address,
    LanguageKey.profile,
  ];
  static List<String> profileTwo = [
    LanguageKey.account,
    LanguageKey.orderHistory,
    LanguageKey.address,
  ];
  static List<String> profileFive = [
    LanguageKey.account,
    LanguageKey.ordersCap,
    LanguageKey.address,
  ];
  static List<String> profileSix = [
    LanguageKey.profile,
    LanguageKey.account,
  ];
  static List<String> activityOne = [
    LanguageKey.following,
    LanguageKey.you,
  ];
  static List<String> activityTwo = [
    LanguageKey.home,
    LanguageKey.discoverCap,
    LanguageKey.activityCap,
  ];

  static List<String> pageFourOneSix = [
    LanguageKey.discoverCap,
    LanguageKey.trendy,
    LanguageKey.popular,
  ];
  static List<String> productEleven = [
    LanguageKey.itemDetails,
    LanguageKey.similarItems,
    LanguageKey.paymentMethods,
  ];
  static List<String> wishThree = [
    LanguageKey.active,
    LanguageKey.upcoming,
    LanguageKey.finished,
  ];

  static List<String> top = [
    "Posters",
    "Postal Cards",
    "Emblems",
    "Magazines",
    "Posters",
    "Postal Cards"
  ];

  static List<String> socialTop = [
    'Teams',
    'Priorities',
    'Current projects',
    'Completed projects',
  ];
  static List<String> secondSocialTop = [
    'Nearby',
    'Center',
    'Sightseeing',
    'Nightlife',
    'Sightseeing',
  ];

  static List<String> cartTwo = [
    LanguageKey.itemInCart,
    LanguageKey.savedItemsCap,
  ];
  static List<String> contentSix = [
    LanguageKey.overview,
    LanguageKey.lessons,
  ];

  static Map<String, String> cartFour = {
    LanguageKey.startingSubtotal: '18.40',
    LanguageKey.subtotal: '18.40',
    LanguageKey.shippingFee: '5.99',
    LanguageKey.estimatedTax: '2.00',
    LanguageKey.orderTotalCap: '26.39',
  };
  static Map<String, String> cartSix = {
    LanguageKey.startingSubtotal: '18.40',
    LanguageKey.subtotal: '18.40',
    LanguageKey.shippingFee: '5.99',
    LanguageKey.estimatedTax: '2.00',
  };
  static Map<String, String> checkoutSeven = {
    LanguageKey.startingSubtotal: '18.40',
    LanguageKey.subtotal: '18.40',
    LanguageKey.shippingFee: '5.99',
  };
  static List<String> delivery = [
    'FedEx',
    'DHL Express',
    'USPS',
    'Global Delivery Services',
    'FREE China airmail',
  ];

  static List<String> daysOfWeek = [
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
    'S',
  ];
  static List<String> daysOfWeekThreeWord = [
    'MON',
    'TUE',
    'WED',
    'THUR',
    'FRI',
    'SAT',
    'SUN',
  ];

  static List<LatLng> locations = [
    const LatLng(37.43296265331129, -122.08832357078792),
    const LatLng(37.4328448, -122.0884548),
    const LatLng(37.4324682, -122.0883582),
    const LatLng(37.4323573, -122.0884238),
    const LatLng(37.4324727, -122.0889663),
    const LatLng(37.4324727, -122.0889712),
    const LatLng(37.433414, -122.0885793),
  ];

  static String lightMode = 'light';
}
