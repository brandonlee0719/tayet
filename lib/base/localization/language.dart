import '../app_lib.dart';

// import '../../chat_ui/base/localization/language_key.dart' as chat;
// import '../../bitcoin_ui/base/localization/language_key.dart' as bitcoin;
class Language {
  static String orderReturn = 'order_return';
  static Map<String, String> mapEn = {
    //Photo Stories
    LanguageKey.photoStories: "Photo Stories",
    LanguageKey.searchForPhotos: "Search for photos",
    LanguageKey.amazingItems: "Amazing Items",
    LanguageKey.follow: "Follow",
    LanguageKey.uploadedBy: "Uploaded by ",
    LanguageKey.topDeal: "Top Deals For You",
    LanguageKey.action: "Action",
    LanguageKey.usDollar: "%s \$US",
    LanguageKey.discountOff: "% OFF",
    LanguageKey.discover: "Discover",
    LanguageKey.catalogue: "Catalogue",
    LanguageKey.cart: "Cart",
    LanguageKey.account: "Account",
    LanguageKey.whitelist: "Whitelist",
    LanguageKey.discountCoupons: "Discount Coupons",
    LanguageKey.offeredUp: "Offered up to 30% off for retweet with demand",

    //Home Decoration item
    LanguageKey.homeDecoration: "Home Decoration Item",
    LanguageKey.itemInStock: "Item in stock",
    LanguageKey.selectSize: "Select size",
    LanguageKey.small: "Small",
    LanguageKey.medium: "Medium",
    LanguageKey.big: "Big",
    LanguageKey.huge: "Huge",
    LanguageKey.replace: "Replace",
    LanguageKey.more: "More",
    LanguageKey.variants: "Variants",
    LanguageKey.selectColor: "Select color",

    //sign up sign in
    LanguageKey.myStore: "Mystore",
    LanguageKey.prototype: "Prototype shopping apps faster",
    LanguageKey.usingEmail: "USING E-MAIL",
    LanguageKey.signIn: "SIGN IN",
    LanguageKey.register: "REGISTER",
    LanguageKey.startScreen: "Start screen",
    LanguageKey.uFlutter: "uFlutter",
    LanguageKey.prototypeShopping: "Prototype shopping apps faster",
    LanguageKey.iAmRegistered: "I am registered",
    LanguageKey.facebook: "Sign in with Facebook",
    LanguageKey.twitter: "Authorize via Twitter",
    LanguageKey.google: "Jump in with Google+",
    LanguageKey.createAcc: "Create account",
    LanguageKey.confirmPassword: "Confirm password",
    LanguageKey.forgotMyPass: "i forgot my pass",
    LanguageKey.facebookF: "Facebook",
    LanguageKey.twitterT: "Twitter",
    LanguageKey.yourName: "Your name",
    LanguageKey.useSocial: "or use social",
    LanguageKey.confirmEmail: "Confirm e-mail address",
    LanguageKey.email: "E-mail",
    LanguageKey.typeYour: "Type your",
    LanguageKey.resetPassword: "reset my password",
    LanguageKey.login: "Login",

    //home
    LanguageKey.goShopping: "Go shopping for...",
    LanguageKey.show: "SHOW",
    LanguageKey.viewAll: "VIEW ALL",

    //flower
    LanguageKey.popularGoods: 'Popular Goods',
    LanguageKey.deals: 'DEALS',
    LanguageKey.discounts: 'DISCOUNTS',
    LanguageKey.newArrivals: 'NEW ARRIVALS',
    LanguageKey.grid: 'GRID',
    LanguageKey.bestSellers: 'BEST SELLERS',

    //new arrival
    LanguageKey.newArrivalsNoCap: 'New Arrivals',
    LanguageKey.ms: 'MS',
    LanguageKey.filter: 'FILTER',
    LanguageKey.newestFirst: 'Newest first',
    LanguageKey.listenToMusic: 'listen to the music',

    //chair
    LanguageKey.help: 'HELP',
    LanguageKey.all: 'ALL',

    //food
    LanguageKey.itemDesc: 'Item Description',
    LanguageKey.addToCart: 'ADD TO CART',
    LanguageKey.totalBill: 'Total bill for %s items',

    //rolex
    LanguageKey.itemDetails: 'Item details',
    LanguageKey.buyNow: 'BUY NOW',
    LanguageKey.watch: 'WATCH',

    //saved items
    LanguageKey.savedItems: 'Saved items',
    LanguageKey.myDefault: 'My default wishlist',
    LanguageKey.edit: 'EDIT',

    //edit mode
    LanguageKey.editMode: 'Edit mode',
    LanguageKey.cancel: 'CANCEL',
    LanguageKey.moveTo: 'MOVE TO',
    LanguageKey.foodToOrder: 'Food to order',
    LanguageKey.active: 'active',
    LanguageKey.upcoming: 'upcoming',
    LanguageKey.finished: 'finished',

    //search flow
    LanguageKey.whatAreYou: 'What are you looking for?',
    LanguageKey.yourRecent: 'Your recent searches still empty',
    LanguageKey.mostSearched: 'Most Searched',
    LanguageKey.clear: 'CLEAR',
    LanguageKey.itemFound: '64 items found',

    //filter
    LanguageKey.filtering: 'Filtering',
    LanguageKey.category: 'Category',
    LanguageKey.narrow: 'Narrow your results',
    LanguageKey.rating: 'Rating',
    LanguageKey.andAbove: '%s and above',
    LanguageKey.colors: 'Colors',
    LanguageKey.anyColor: 'Any color',
    LanguageKey.shipping: 'Shipping',
    LanguageKey.allDelivery: 'All delivery methods',
    LanguageKey.priceRange: 'Price range',
    LanguageKey.anyPrice: 'Any price',
    LanguageKey.fromTo: 'from %s to %s',
    LanguageKey.displayOnlyResults: 'Display only results',
    LanguageKey.showDiscounts: 'Show discounts',
    LanguageKey.yourOption: 'Your option name',
    LanguageKey.itemConditions: 'Item conditions',
    LanguageKey.usedVintage: 'Used, Vintage, Oldschool',
    LanguageKey.reset: 'RESET',
    LanguageKey.save: 'SAVE',

    //color
    LanguageKey.apply: 'APPLY',
    LanguageKey.hide: 'HIDE',

    //price range
    LanguageKey.itemsFound: 'Items found',
    LanguageKey.minPrice: 'Min. price',
    LanguageKey.maxPrice: 'Max. price',
    LanguageKey.raised: 'RAISED',

    //rating
    LanguageKey.from: 'from',
    LanguageKey.pts: '%s pts.',

    //six
    LanguageKey.todayTop: 'TODAY’S TOP',

    //pick the tour
    LanguageKey.pickTheTour: 'Pick the tour',
    LanguageKey.placeToVisit: 'PLACES TO VISIT',

    //fruits
    LanguageKey.fruits: 'FRUITS',
    LanguageKey.vegetables: 'VEGETABLES',
    LanguageKey.moreFruits: 'MORE FRUITS',
    LanguageKey.juicesJuices: 'JUICES JUICES',

    //profile one
    LanguageKey.forYou: 'FOR YOU',
    LanguageKey.address: 'ADDRESS',
    LanguageKey.profile: 'PROFILE',

    //profile two
    LanguageKey.orders: 'Orders',
    LanguageKey.purchases: 'Purchases',
    LanguageKey.orderHistory: 'ORDER HISTORY',

    //profile four
    LanguageKey.noOrders:
        'No orders history tracked\nIt’s high time to buy something',
    LanguageKey.goShoppingNow: 'GO SHOPPING!',

    //profile five
    LanguageKey.ordersCap: 'ORDERS',
    LanguageKey.profileLow: 'Profile',

    //profile six
    LanguageKey.accountInformation: 'Account Information',
    LanguageKey.languageKeyboard: 'Languages and keyboard',
    LanguageKey.purchaseHistory: 'Purchases history',
    LanguageKey.yourBalance: 'Your balance & financial',

    //profile seven
    LanguageKey.contactInformation: 'Contact information',
    LanguageKey.captionContact: 'Caption for contact information',
    LanguageKey.notificationSetting: 'Notification settings',
    LanguageKey.captionNotification: 'Caption for notification settings',
    LanguageKey.parametersCaption: 'Parameters caption',
    LanguageKey.yourBalances: 'Your balance',
    LanguageKey.captionYourBalances: 'Your balance and caption',
    LanguageKey.oneMoreItem: 'One more item',
    LanguageKey.putYourCaptionHere: 'Put your caption here',

    //profile eight
    LanguageKey.homeAddress: 'Home address',
    LanguageKey.personalInformation: 'Personal information',
    LanguageKey.firstName: 'First name',
    LanguageKey.lastName: 'Last name',
    LanguageKey.defaultName: 'Default name',
    LanguageKey.zip: 'Zip',
    LanguageKey.city: 'City',
    LanguageKey.state: 'State',
    LanguageKey.financialInformation: 'Financial information',
    LanguageKey.yourCategory: 'Your category',
    LanguageKey.saveChanges: 'Save changes',

    //profile nine
    LanguageKey.categoryOption: 'Category caption',
    LanguageKey.password: 'Password',
    LanguageKey.yourBilling:
        'Your billing address is the same as shipping.\nThis could be managed somewhere',
    LanguageKey.shippingAddress: 'Shipping address',
    LanguageKey.billingAddress: 'Billing address',
    LanguageKey.add: 'ADD',

    //profile ten
    LanguageKey.myAccount: 'My account',
    LanguageKey.orderReturn: 'Orders & Returns',
    LanguageKey.addressBook: 'Address book',
    LanguageKey.myLocation: 'My location',
    LanguageKey.unitedState: 'United States (USD)',
    LanguageKey.myShopping: 'My shopping preference',
    LanguageKey.women: 'Women',
    LanguageKey.men: 'Men',
    LanguageKey.mySetting: 'My settings',
    LanguageKey.pushNotification: 'Push notifications',
    LanguageKey.detailPassword: 'Details & Password',

    //Activity one
    LanguageKey.activity: 'Activity',
    LanguageKey.following: 'FOLLOWING',
    LanguageKey.you: 'YOU',

    //activity two
    LanguageKey.thingHappen: 'things happened',
    LanguageKey.discoverCap: 'DISCOVER',
    LanguageKey.home: 'HOME',
    LanguageKey.activityCap: 'ACTIVITY',
    LanguageKey.notifications: 'Notifications',

    //discover 416
    LanguageKey.topPicks: 'Top picks for you',
    LanguageKey.recommend: 'Recommended to read',
    LanguageKey.trendy: 'TRENDY',
    LanguageKey.popular: 'POPULAR',
    LanguageKey.browse: 'Browse',

    //discover 417
    LanguageKey.yourTop: 'Yours top picks',
    LanguageKey.suggestion: 'Suggestions',

    //social one
    LanguageKey.like: 'Like',
    LanguageKey.comment: 'Comment',
    LanguageKey.share: 'Share',
    LanguageKey.searchMoreCard: 'Search more cards',
    LanguageKey.facebookCard: 'Facebook cards',
    LanguageKey.social: 'Social',
    LanguageKey.tasks: 'Tasks',
    LanguageKey.travel: 'Travel',

    //social two
    LanguageKey.mansoryCard: 'Masonry cards',

    //social three
    LanguageKey.twitterCard: 'Twitter cards',

    //social five
    LanguageKey.completedProject: 'Completed Projects',
    LanguageKey.addCard: 'ADD A CARD...',
    LanguageKey.currentProject: 'Current Projects',
    LanguageKey.trelloCard: 'Trello cards',

    //social six
    LanguageKey.trelloVariant: 'Trello variant',
    LanguageKey.priorities: 'Priorities',

    //social seven
    LanguageKey.trelloMasonry: 'Priorities',
    LanguageKey.finishedProject: 'Finished Projects',
    LanguageKey.searchTask: 'Search for tasks...',

    //social eight
    LanguageKey.experiences: 'Experiences',
    LanguageKey.scrollsHorizontally: 'Scrolls horizontally',
    LanguageKey.airbnbCard: 'Airbnb cards',

    //social nine
    LanguageKey.bodyCards: 'Body cards',
    LanguageKey.scrollableHorizontally: 'SCROLLABLE HORIZONTALLY',
    LanguageKey.fullWidthCards: 'FULL WIDTH CARDS',
    LanguageKey.masonryGrid: 'MASONRY GRID',
    LanguageKey.cards: 'Cards',

    //cart one
    LanguageKey.yourDontHave: 'You don’t have any items in your\ncart. Go ',
    LanguageKey.shopping: 'shopping',
    LanguageKey.shoppingCart: 'Shopping cart',

    //cart two
    LanguageKey.itemInCart: 'ITEMS IN CART',
    LanguageKey.savedItemsCap: 'SAVED ITEMS',

    //cart three
    LanguageKey.yourCart: 'Your cart',
    LanguageKey.size: 'Size',
    LanguageKey.color: 'Color',
    LanguageKey.quantity: 'Quantity',
    LanguageKey.getPromo: 'Got a promo code?',
    LanguageKey.orderTotal: 'Order total',
    LanguageKey.deliveryTaxes: 'Delivery and other taxes included',
    LanguageKey.applePay: 'APPLE PAY',
    LanguageKey.checkout: 'CHECKOUT',

    //cart four
    LanguageKey.startingSubtotal: 'Starting Subtotal',
    LanguageKey.subtotal: 'Subtotal',
    LanguageKey.shippingFee: 'Shipping Fee',
    LanguageKey.estimatedTax: 'Estimated Tax',
    LanguageKey.orderTotalCap: 'ORDER TOTAL',
    LanguageKey.proceedCheckout: 'Proceed to checkout',
    LanguageKey.usDollarCap: 'US\$',

    //cart five
    LanguageKey.usDollarAround: '\$US',
    LanguageKey.saveForLater: 'SAVE FOR LATER',
    LanguageKey.deliveryIncluded: 'Delivery included',

    //cart six
    LanguageKey.buyLater: 'BUY LATER',
    LanguageKey.bonAppetit: 'Bon appetit!',

    //cart seven
    LanguageKey.thanksPurchase: 'Thanks for purchase',
    LanguageKey.amount: 'Amount',

    //checkout one
    LanguageKey.payment: 'Payment',
    LanguageKey.review: 'Review',
    LanguageKey.addressInput: 'Address input',
    LanguageKey.financialInfo: 'Financial info',
    LanguageKey.checkTheOrder: 'Check the order',
    LanguageKey.whereShip: 'Where should we ship?',
    LanguageKey.addressLineOne: 'Address line 1',
    LanguageKey.addressLineTwo: 'Address line 2 (optional)',
    LanguageKey.createAccount: 'Create an account to continue',
    LanguageKey.signInFacebook: 'SIGN IN WITH FACEBOOK',
    LanguageKey.authorizeViaTwitter: 'AUTHORIZE VIA TWITTER',
    LanguageKey.jumpInGoogle: 'JUMP IN WITH GOOGLE+',
    LanguageKey.signUpEmail: 'SIGN UP WITH E-MAIL',
    LanguageKey.registerAgree: 'By registering you are agree to our ',
    LanguageKey.termService: 'Terms of Service',
    LanguageKey.and: ' and ',
    LanguageKey.privacyPolicy: 'Privacy Policy',
    LanguageKey.continues: 'Continue',
    LanguageKey.checkoutLow: 'Checkout',

    //checkout two
    LanguageKey.yourPaymentInfo: 'Your payment information',
    LanguageKey.ccNo: 'Credit Card Number',
    LanguageKey.expiration: 'Expiration',
    LanguageKey.cvcCode: 'CVC code',
    LanguageKey.billingAddressSameShipping: 'Billing address same as shipping',
    LanguageKey.whatBillingAddress: 'What’s your billing address?',
    LanguageKey.submit: 'SUBMIT',

    //checkout three
    LanguageKey.orderReview: 'Order review',
    LanguageKey.selectedPayment: 'Selected Payment Method',
    LanguageKey.yourDelivery: 'Your Delivery Method',
    LanguageKey.yourPurchase: 'You’re about to purchase',
    LanguageKey.creditCard: 'CREDIT CARD',
    LanguageKey.selectedDelivery: 'Select delivery',

    //checkout five
    LanguageKey.nextPayment: 'Next step is Payment',
    LanguageKey.emailAddress: 'E-mail address',
    LanguageKey.or: 'or',
    LanguageKey.withTwitter: 'WITH TWITTER',
    LanguageKey.withGoogle: 'WITH GOOGLE',

    //checkout six
    LanguageKey.creditCardNumber: 'Credit card number',
    LanguageKey.expires: 'Expires',
    LanguageKey.reviewYourOrder: 'Review Your Order',

    //checkout seven
    LanguageKey.youArePurchased: 'You are purchasing this items',
    LanguageKey.confirmOrder: 'Confirm Your Order',

    //checkout eight
    LanguageKey.orderSuccessful: 'Order successful!',
    LanguageKey.thankYouOrder:
        'Thanks for your order!\nTo be delivered within 24 hours',
    LanguageKey.checkOffer: 'Check these offers also',

    //content screen
    LanguageKey.welcomeTitle: 'Welcome to the app',
    LanguageKey.posts: 'POSTS',
    LanguageKey.articles: 'ARTICLES',
    LanguageKey.stories: 'STORIES',
    LanguageKey.actionSpace: 'A C T I O N',
    LanguageKey.relatedAlbums: 'Related albums',
    LanguageKey.takeSeat: 'Take your seat',
    LanguageKey.watchTrailer: 'Watch the trailer',
    LanguageKey.survivalCourses: 'Survival courses',
    LanguageKey.overview: 'OVERVIEW',
    LanguageKey.lessons: 'LESSONS',
    LanguageKey.enhanceSkills: 'Enhance your skills',
    LanguageKey.how: 'HOW?',
    LanguageKey.materialDesign:
        'Material Design provides responsive layouts based on the following column structures. Layouts using 4-column, 8-column, and 12-column grids.',
    LanguageKey.whatWillYouGet: 'What will you get',
    LanguageKey.videoLessons: '20 video lessons',
    LanguageKey.freeUpdates: 'Free updates for members',
    LanguageKey.secretTechniques: '7 secret techniques',
    LanguageKey.beatStreet: 'How to beat the street',
    LanguageKey.moneyback: 'Moneyback guaranteed!',
    LanguageKey.trustedBank: 'Trusted Bank of Nikolay',

    //discover 419
    LanguageKey.popularNow: 'Popular Now',
    LanguageKey.onRise: 'On the Rise',
    LanguageKey.popularArticle: 'POPULAR ARTICLES',
    LanguageKey.searchRightHere: 'Search right here...',
    LanguageKey.forYouLower: 'For You',

    //discover 420
    LanguageKey.bestYou: 'What’s best for you?',
    LanguageKey.narrowInterest:
        'Please narrow your interests so we can specify the best suggestions for you',

    //discover 421
    LanguageKey.interest: 'Got the interest in?',

    //discover 418
    LanguageKey.trendingTopics: 'Trending topics',

    //calendar
    LanguageKey.reminder: 'Reminder',
    LanguageKey.planner: 'Planner',

    //map
    LanguageKey.bikers: 'Bikers on map',
    LanguageKey.contactDrivers: 'Contacting drivers...',
    LanguageKey.cancelRide: 'Cancel ride',
    LanguageKey.to: 'to',
    LanguageKey.yourLocation: 'Your location',
    LanguageKey.car: 'CAR',
    LanguageKey.train: 'TRAIN',
    LanguageKey.walk: 'WALK',
    LanguageKey.departAt: 'Depart at %s',
    LanguageKey.options: 'OPTIONS',
    LanguageKey.recommendedRoute: 'Recommended route',
    LanguageKey.every: 'Every %s min',
    LanguageKey.fromST: 'from %s st',
    LanguageKey.min: '%s min',
    LanguageKey.moreSubway: 'More by subway',
    LanguageKey.otherOptions: 'Other options',
    LanguageKey.tomorrow: 'TOMORROW · %s',
    LanguageKey.peopleVisited: '%s people visited',

    //category
    LanguageKey.horizontalScrollBlock: 'Horizontal Scroll Block',
    LanguageKey.yourTopPick: 'Your Top Picks',
    LanguageKey.newArrival: 'New arrivals',
    LanguageKey.seeBuyingOption: 'See All Buying Options',

    //product
    LanguageKey.usersReviews: 'Users reviews',
    LanguageKey.addCart: 'Add to cart',
    LanguageKey.nutritionFacts: 'Nutrition facts',
    LanguageKey.sourceFiles: 'Source files',
    LanguageKey.additional: 'Additional',
    LanguageKey.similarItems: 'Similar items',
    LanguageKey.paymentMethods: 'Payment methods',
    LanguageKey.saveLater: 'save for later',
    LanguageKey.watchVideo: 'Watch on video',
    LanguageKey.selectColorSize: 'Select color and size',
    LanguageKey.moreInfo: 'More item information',
    LanguageKey.freeDelivery: 'Free delivery and moneyback',
    LanguageKey.sizeMeasurement: 'Sizes and measurement',
    LanguageKey.toWishlist: 'to wishlist',
    LanguageKey.onVideo: 'on video',
    LanguageKey.amountKG: 'Amount, kg.',
    LanguageKey.alsoBought: 'Also bought together',
    LanguageKey.chooseToppings: 'Choose toppings',
    LanguageKey.selectDelivery: 'Select delivery',
    LanguageKey.confirm: 'confirm',
    LanguageKey.delivery: 'Delivery',
    LanguageKey.accept: 'accept',

    //wish
    LanguageKey.youDontHave: 'You don’t have any items saved',
    LanguageKey.checkedItems: 'Checked Items',
    LanguageKey.whishlistMove: 'Wishlist to move to',
    LanguageKey.moveItems: 'move items',
    LanguageKey.listEmpty: 'This list is empty',
    LanguageKey.itemMovedSuccessful: 'Items moved successful!',
    LanguageKey.emptyState: 'Empty state',
    LanguageKey.mySecondList: 'My second list',
    LanguageKey.fruitOfTheDay: 'Fruits for every day',
    LanguageKey.gifts: 'Gifts',
    LanguageKey.selected: 'Selected',
    LanguageKey.tabToSelect: 'Tap to select',
    LanguageKey.rename: 'rename',
    LanguageKey.moveOrDelete: 'Move or delete mode',
    LanguageKey.moveNoItems: 'move %s items',
    LanguageKey.renameList: 'Rename list',
    LanguageKey.typeNewName: 'Type new list name',
    LanguageKey.positive: 'positive',
    LanguageKey.compareMode: 'Compare mode',

    //promo
    LanguageKey.enterPromoCode: 'Enter promo code',
    LanguageKey.inviteFriend: 'Invite friends',
    LanguageKey.copy: 'copy',
    LanguageKey.textInvite: 'Text Invites',
    LanguageKey.moreOption: 'more options',
    LanguageKey.giveCardVoucher: 'Gift Cards & Vouchers',
    LanguageKey.buyGiftCard: 'buy gift voucher',
    LanguageKey.addGiftCard: 'add gift card',
    LanguageKey.promoCode: 'Promo Codes',
    LanguageKey.freeGift: 'Free Gift',
    LanguageKey.skipThis: 'skip this',

    //common
    LanguageKey.itemPressed: 'Item has been pressed',
    LanguageKey.noData: 'No data',

    //============chat ui===============
    //common
    // chat.LanguageKey.search: "Search",
    // chat.LanguageKey.itemPressed: 'Item has been pressed',
    // chat.LanguageKey.action: "Action",

    // //splash
    // chat.LanguageKey.chatShare: "Chat. Share. Connect.\nAnywhere. Anytime.",
    // chat.LanguageKey.next: "Next",
    // chat.LanguageKey.skip: "Skip",

    // //login
    // chat.LanguageKey.login: "Log In",
    // chat.LanguageKey.username: "Username",
    // chat.LanguageKey.password: "Password",
    // chat.LanguageKey.createAccount: "Create account",

    // //register
    // chat.LanguageKey.register: "Register",
    // chat.LanguageKey.confirmPassword: "Confirm Password",

    // //menu
    // chat.LanguageKey.home: "Home",
    // chat.LanguageKey.profile: "Profile",
    // chat.LanguageKey.contacts: "Contacts",
    // chat.LanguageKey.groups: "Groups",
    // chat.LanguageKey.chats: "Chats",
    // chat.LanguageKey.settings: "Settings",
    // chat.LanguageKey.logout: "Log Out",

    // //fingerprint
    // chat.LanguageKey.unlock: "Unlock",
    // chat.LanguageKey.fingerprintScan: "Fingerprint Scan",
    // chat.LanguageKey.pleasePress: "Please press your thumb unlock\nand access app",
    // chat.LanguageKey.cancelScan: "Cancel Scan",

    // //profile
    // chat.LanguageKey.followers: "Followers",
    // chat.LanguageKey.messages: "Messages",
    // chat.LanguageKey.images: "Images",

    // //messages
    // chat.LanguageKey.friends: "Friends",
    // chat.LanguageKey.viewAll: "View All",

    // //chat room
    // chat.LanguageKey.chatRoom: "Chat Room",
    // chat.LanguageKey.peopleNearYou: "People Near You",
    // chat.LanguageKey.viewMore: "View More",
    // chat.LanguageKey.chatRooms: "Chat Rooms",

    // //contact
    // chat.LanguageKey.all: "All",
    // chat.LanguageKey.favorites: "Favorites",
    // chat.LanguageKey.typeMessage: "Type a Message",

    // //chat
    // chat.LanguageKey.notifications: "Notifications",
    // chat.LanguageKey.follow: "Follow",
    // chat.LanguageKey.addFriend: "Add Friend",
    // chat.LanguageKey.reply: "Reply",

    // //video call
    // chat.LanguageKey.videoCall: "Video Call",
    // chat.LanguageKey.accept: "Accept",
    // chat.LanguageKey.reject: "Reject",

    // //chat group
    // chat.LanguageKey.chatGroups: 'Chat Groups',
    // chat.LanguageKey.chat: 'Chat',

    // //settings
    // chat.LanguageKey.visibility: 'Visibility',
    // chat.LanguageKey.alerts: 'Alerts',
    // chat.LanguageKey.cloudSync: 'Cloud Sync',
    // chat.LanguageKey.statisticReports: 'Statistic Reports',
    // chat.LanguageKey.privacy: 'Privacy',
    // chat.LanguageKey.security: 'Security',
    // //======================================

    // //============bitcoin ui===============
    // //common
    // bitcoin.LanguageKey.itemPressed: 'Item has been pressed',
    // bitcoin.LanguageKey.action: 'Action',

    // //splash
    // bitcoin.LanguageKey.tracking:
    // "Tracking Bitcoin and 5,000\nother crypto coin",
    // bitcoin.LanguageKey.skip: "Skip",
    // bitcoin.LanguageKey.createPortfolio:
    // "Create portfolio, custom alerts,\nconnect exchange & wallet",
    // bitcoin.LanguageKey.tradeCrypto: "Trade Crypto, Smartly with",
    // bitcoin.LanguageKey.algo: "AI Algo Trading",

    // //market
    // bitcoin.LanguageKey.market: "Market",
    // bitcoin.LanguageKey.rank: "Rank",
    // bitcoin.LanguageKey.price: "Price",
    // bitcoin.LanguageKey.capVol: "Cap/Vol",
    // bitcoin.LanguageKey.usd: "USD",
    // bitcoin.LanguageKey.searchCrypto: "Search Cryotocurrencies",
    // bitcoin.LanguageKey.portfolio: "Portfolio",
    // bitcoin.LanguageKey.alert: "Alert",
    // bitcoin.LanguageKey.news: "News",
    // bitcoin.LanguageKey.setting: "Setting",
    // bitcoin.LanguageKey.byPrice: "By Price",
    // bitcoin.LanguageKey.byVolume: "By Price",
    // bitcoin.LanguageKey.byDominance: "By Dominance",
    // bitcoin.LanguageKey.alphabitically: "Alphabitically",
    //======================================
  };
}
