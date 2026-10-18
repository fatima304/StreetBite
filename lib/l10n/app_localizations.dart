import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
    Locale('en'),
  ];

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to your account'**
  String get signInSubtitle;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join us and start ordering your favorite food'**
  String get signUpSubtitle;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Password reset is not connected yet'**
  String get resetNotConnected;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get creatingAccount;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get termsAgreement;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms first'**
  String get acceptTerms;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Delicious food\ndelivered to'**
  String get onboardingTitle;

  /// No description provided for @onboardingAccent.
  ///
  /// In en, this message translates to:
  /// **'your doorstep'**
  String get onboardingAccent;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the best restaurants near you and enjoy your favorite meals at home.'**
  String get onboardingDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started  →'**
  String get getStarted;

  /// No description provided for @onboardingSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?  Sign In'**
  String get onboardingSignIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @sessionError.
  ///
  /// In en, this message translates to:
  /// **'Unable to check your session. Please restart the app.'**
  String get sessionError;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @firstLetterCapital.
  ///
  /// In en, this message translates to:
  /// **'First letter must be capital'**
  String get firstLetterCapital;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMin.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMin;

  /// No description provided for @confirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get confirmRequired;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @noUser.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get noUser;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password provided.'**
  String get wrongPassword;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email.'**
  String get emailInUse;

  /// No description provided for @firebaseInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address is not valid.'**
  String get firebaseInvalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak.'**
  String get weakPassword;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user account has been disabled.'**
  String get userDisabled;

  /// No description provided for @tooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get tooManyAttempts;

  /// No description provided for @incorrectCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password. Please try again.'**
  String get incorrectCredentials;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your connection and try again.'**
  String get noInternet;

  /// No description provided for @emailUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Email sign-in is unavailable right now. Please contact support.'**
  String get emailUnavailable;

  /// No description provided for @unableRequest.
  ///
  /// In en, this message translates to:
  /// **'Unable to complete your request. Please try again.'**
  String get unableRequest;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection.'**
  String get networkError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpectedError;

  /// No description provided for @homeScreen.
  ///
  /// In en, this message translates to:
  /// **'Home Screen'**
  String get homeScreen;

  /// No description provided for @nearbyVendors.
  ///
  /// In en, this message translates to:
  /// **'Nearby Vendors'**
  String get nearbyVendors;

  /// No description provided for @nearbyVendorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore 5 food spots on the map'**
  String get nearbyVendorsSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for meals or vendors'**
  String get searchHint;

  /// No description provided for @specialOffers.
  ///
  /// In en, this message translates to:
  /// **'Special Offers • Up to 50% OFF'**
  String get specialOffers;

  /// No description provided for @freshMeals.
  ///
  /// In en, this message translates to:
  /// **'Fresh meals near you'**
  String get freshMeals;

  /// No description provided for @streetFoodFavourites.
  ///
  /// In en, this message translates to:
  /// **'Street food favourites'**
  String get streetFoodFavourites;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @hotOffers.
  ///
  /// In en, this message translates to:
  /// **'Hot Offers'**
  String get hotOffers;

  /// No description provided for @popularMeals.
  ///
  /// In en, this message translates to:
  /// **'Popular Meals'**
  String get popularMeals;

  /// No description provided for @noMealsFound.
  ///
  /// In en, this message translates to:
  /// **'No meals found.'**
  String get noMealsFound;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart:'**
  String get addedToCart;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @noFavouritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favourites yet'**
  String get noFavouritesYet;

  /// No description provided for @noFavouritesDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on meals to save your favourites here.'**
  String get noFavouritesDescription;

  /// No description provided for @exploreMeals.
  ///
  /// In en, this message translates to:
  /// **'Explore Meals'**
  String get exploreMeals;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistory;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @photoSaved.
  ///
  /// In en, this message translates to:
  /// **'Photo saved on this device.'**
  String get photoSaved;

  /// No description provided for @couldNotSavePhoto.
  ///
  /// In en, this message translates to:
  /// **'Could not save photo:'**
  String get couldNotSavePhoto;

  /// No description provided for @couldNotUpdateName.
  ///
  /// In en, this message translates to:
  /// **'Could not update name:'**
  String get couldNotUpdateName;

  /// No description provided for @verifyingIdentity.
  ///
  /// In en, this message translates to:
  /// **'Verifying your identity...'**
  String get verifyingIdentity;

  /// No description provided for @unlockProfile.
  ///
  /// In en, this message translates to:
  /// **'Unlock your profile'**
  String get unlockProfile;

  /// No description provided for @biometricRequired.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is required.'**
  String get biometricRequired;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @streetBiteUser.
  ///
  /// In en, this message translates to:
  /// **'StreetBite User'**
  String get streetBiteUser;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Language: Arabic'**
  String get languageArabic;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @loadingDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Loading device information...'**
  String get loadingDeviceInfo;

  /// No description provided for @deviceDetailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Device details unavailable'**
  String get deviceDetailsUnavailable;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @exploreMealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Meals'**
  String get exploreMealsTitle;

  /// No description provided for @searchMealsHint.
  ///
  /// In en, this message translates to:
  /// **'Search meals by name'**
  String get searchMealsHint;

  /// No description provided for @popularCategories.
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get popularCategories;

  /// No description provided for @categoryMeals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get categoryMeals;

  /// No description provided for @resultsFor.
  ///
  /// In en, this message translates to:
  /// **'Results for'**
  String get resultsFor;

  /// No description provided for @noMealsSearch.
  ///
  /// In en, this message translates to:
  /// **'No meals found. Try another search.'**
  String get noMealsSearch;

  /// No description provided for @meal.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get meal;

  /// No description provided for @couldNotLoadOrders.
  ///
  /// In en, this message translates to:
  /// **'Could not load your orders. Please try again.'**
  String get couldNotLoadOrders;

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrdersYet;

  /// No description provided for @noOrdersDescription.
  ///
  /// In en, this message translates to:
  /// **'Your completed orders will appear here.'**
  String get noOrdersDescription;

  /// No description provided for @ordersCount.
  ///
  /// In en, this message translates to:
  /// **'orders'**
  String get ordersCount;

  /// No description provided for @mealDetails.
  ///
  /// In en, this message translates to:
  /// **'Meal Details'**
  String get mealDetails;

  /// No description provided for @mealNotFound.
  ///
  /// In en, this message translates to:
  /// **'Meal not found'**
  String get mealNotFound;

  /// No description provided for @freshMeal.
  ///
  /// In en, this message translates to:
  /// **'Fresh meal'**
  String get freshMeal;

  /// No description provided for @fresh.
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get fresh;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get origin;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available.'**
  String get noDescription;

  /// No description provided for @seeLess.
  ///
  /// In en, this message translates to:
  /// **'See Less'**
  String get seeLess;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @addedToCartQuantity.
  ///
  /// In en, this message translates to:
  /// **'added to cart'**
  String get addedToCartQuantity;

  /// No description provided for @yourCartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartEmpty;

  /// No description provided for @addMealsToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add some delicious meals\nand get started!'**
  String get addMealsToGetStarted;

  /// No description provided for @browseMeals.
  ///
  /// In en, this message translates to:
  /// **'Browse Meals'**
  String get browseMeals;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @placingOrder.
  ///
  /// In en, this message translates to:
  /// **'Placing Order...'**
  String get placingOrder;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully!'**
  String get orderPlacedSuccessfully;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @creditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Credit / Debit Card'**
  String get creditDebitCard;

  /// No description provided for @showAllVendors.
  ///
  /// In en, this message translates to:
  /// **'Show all vendors'**
  String get showAllVendors;

  /// No description provided for @exploreVendors.
  ///
  /// In en, this message translates to:
  /// **'Explore 5 vendors across Egypt'**
  String get exploreVendors;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @orderPrefix.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get orderPrefix;

  /// No description provided for @closeDetails.
  ///
  /// In en, this message translates to:
  /// **'Close details'**
  String get closeDetails;

  /// No description provided for @showOnMap.
  ///
  /// In en, this message translates to:
  /// **'Show on map'**
  String get showOnMap;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @toggleFavourite.
  ///
  /// In en, this message translates to:
  /// **'Toggle favourite'**
  String get toggleFavourite;

  /// No description provided for @goodFoodBrighterMood.
  ///
  /// In en, this message translates to:
  /// **'Good Food. Brighter Mood.'**
  String get goodFoodBrighterMood;

  /// No description provided for @editNameTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editNameTooltip;

  /// No description provided for @demoPreviewMessage.
  ///
  /// In en, this message translates to:
  /// **'UI preview only — connect your Bloc / Firebase'**
  String get demoPreviewMessage;

  /// No description provided for @errorMealDetailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Meal details are unavailable.'**
  String get errorMealDetailsUnavailable;

  /// No description provided for @errorCheckInternet.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get errorCheckInternet;

  /// No description provided for @errorLoadMealDetails.
  ///
  /// In en, this message translates to:
  /// **'Unable to load meal details. Please try again.'**
  String get errorLoadMealDetails;

  /// No description provided for @errorSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorSomethingWrong;

  /// No description provided for @errorLoadFavourites.
  ///
  /// In en, this message translates to:
  /// **'Could not load favourites. Check your connection and Firestore rules.'**
  String get errorLoadFavourites;

  /// No description provided for @errorUpdateFavourites.
  ///
  /// In en, this message translates to:
  /// **'Could not update favourites. Please try again.'**
  String get errorUpdateFavourites;

  /// No description provided for @errorRequestTimedOut.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again.'**
  String get errorRequestTimedOut;

  /// No description provided for @errorCouldNotConnect.
  ///
  /// In en, this message translates to:
  /// **'Could not connect. Check your internet connection.'**
  String get errorCouldNotConnect;

  /// No description provided for @errorLoadMealsNow.
  ///
  /// In en, this message translates to:
  /// **'Unable to load meals right now. Please try again.'**
  String get errorLoadMealsNow;

  /// No description provided for @errorLoadingMeals.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading meals.'**
  String get errorLoadingMeals;

  /// No description provided for @errorBiometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication was cancelled or failed.'**
  String get errorBiometricFailed;

  /// No description provided for @errorAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'Unable to authenticate. Please try again.'**
  String get errorAuthenticate;

  /// No description provided for @errorLoadMeals.
  ///
  /// In en, this message translates to:
  /// **'Could not load meals. Please try again.'**
  String get errorLoadMeals;

  /// No description provided for @errorLoadDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Unable to load device information.'**
  String get errorLoadDeviceInfo;

  /// No description provided for @errorLoadCart.
  ///
  /// In en, this message translates to:
  /// **'Could not load your cart. Please try again.'**
  String get errorLoadCart;

  /// No description provided for @errorSignInFirst.
  ///
  /// In en, this message translates to:
  /// **'Please sign in first.'**
  String get errorSignInFirst;

  /// No description provided for @vendorCityCairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get vendorCityCairo;

  /// No description provided for @vendorCityGiza.
  ///
  /// In en, this message translates to:
  /// **'Giza'**
  String get vendorCityGiza;

  /// No description provided for @vendorCityAlexandria.
  ///
  /// In en, this message translates to:
  /// **'Alexandria'**
  String get vendorCityAlexandria;

  /// No description provided for @vendorCitySuez.
  ///
  /// In en, this message translates to:
  /// **'Suez'**
  String get vendorCitySuez;

  /// No description provided for @vendorCityLuxor.
  ///
  /// In en, this message translates to:
  /// **'Luxor'**
  String get vendorCityLuxor;

  /// No description provided for @vendorCuisineEgyptian.
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get vendorCuisineEgyptian;

  /// No description provided for @vendorCuisineGrills.
  ///
  /// In en, this message translates to:
  /// **'Grills'**
  String get vendorCuisineGrills;

  /// No description provided for @vendorCuisineSeafood.
  ///
  /// In en, this message translates to:
  /// **'Seafood'**
  String get vendorCuisineSeafood;

  /// No description provided for @vendorCuisineItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get vendorCuisineItalian;

  /// No description provided for @vendorCuisineFastFood.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get vendorCuisineFastFood;

  /// No description provided for @orderStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderStatusPending;

  /// No description provided for @orderStatusPlaced.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get orderStatusPlaced;

  /// No description provided for @orderStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get orderStatusProcessing;

  /// No description provided for @orderStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get orderStatusCompleted;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @paymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment was cancelled.'**
  String get paymentCancelled;

  /// No description provided for @paymentNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment could not be confirmed. Check Stripe test dashboard before retrying.'**
  String get paymentNotConfirmed;

  /// No description provided for @paymentOrderSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed but the order could not be saved. Do not pay again; retry saving the order.'**
  String get paymentOrderSaveFailed;

  /// No description provided for @checkoutOrderFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not complete the order. Please try again.'**
  String get checkoutOrderFailed;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get paymentSuccessful;

  /// No description provided for @paymentStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Payment pending'**
  String get paymentStatusPending;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
