enum ResponseCodeAndroid {
  BILLING_RESPONSE_RESULT_OK,
  BILLING_RESPONSE_RESULT_USER_CANCELED,
  BILLING_RESPONSE_RESULT_SERVICE_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_BILLING_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_ITEM_UNAVAILABLE,
  BILLING_RESPONSE_RESULT_DEVELOPER_ERROR,
  BILLING_RESPONSE_RESULT_ERROR,
  BILLING_RESPONSE_RESULT_ITEM_ALREADY_OWNED,
  BILLING_RESPONSE_RESULT_ITEM_NOT_OWNED,
  UNKNOWN,
}

class IAPItem extends Model {
  final String? productId;
  final String? price;
  final String? currency;
  final String? localizedPrice;
  final String? title;
  final String? description;
  final String? introductoryPrice;

  final String? subscriptionPeriodNumberIOS;
  final String? subscriptionPeriodUnitIOS;
  final String? introductoryPriceNumberIOS;
  final String? introductoryPricePaymentModeIOS;
  final String? introductoryPriceNumberOfPeriodsIOS;
  final String? introductoryPriceSubscriptionPeriodIOS;
  final List<DiscountIOS>? discountsIOS;

  final String? signatureAndroid;
  final List<SubscriptionOfferAndroid>? subscriptionOffersAndroid;
  final String? subscriptionPeriodAndroid;

  final String? iconUrl;
  final String? originalJson;
  final String originalPrice;

  IAPItem.fromJSON(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        price = json['price'] as String?,
        currency = json['currency'] as String?,
        localizedPrice = json['localizedPrice'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        introductoryPrice = json['introductoryPrice'] as String?,
        introductoryPricePaymentModeIOS =
        json['introductoryPricePaymentModeIOS'] as String?,
        introductoryPriceNumberOfPeriodsIOS =
        json['introductoryPriceNumberOfPeriodsIOS'] as String?,
        introductoryPriceSubscriptionPeriodIOS =
        json['introductoryPriceSubscriptionPeriodIOS'] as String?,
        introductoryPriceNumberIOS =
        json['introductoryPriceNumberIOS'] as String?,
        subscriptionPeriodNumberIOS =
        json['subscriptionPeriodNumberIOS'] as String?,
        subscriptionPeriodUnitIOS =
        json['subscriptionPeriodUnitIOS'] as String?,
        subscriptionPeriodAndroid =
        json['subscriptionPeriodAndroid'] as String?,
        signatureAndroid = json['signatureAndroid'] as String?,
        iconUrl = json['iconUrl'] as String?,
        originalJson = json['originalJson'] as String?,
        originalPrice = json['originalPrice'].toString(),
        discountsIOS = _extractDiscountIOS(json['discounts']),
        subscriptionOffersAndroid =
        _extractSubscriptionOffersAndroid(json['subscriptionOffers']);

  @override
  Map<String, dynamic> toJson() => {
    'productId': productId,
    'price': price,
    'currency': currency,
    'localizedPrice': localizedPrice,
    'title': title,
    'description': description,
    'introductoryPrice': introductoryPrice,
    'introductoryPricePaymentModeIOS': introductoryPricePaymentModeIOS,
    'introductoryPriceNumberOfPeriodsIOS':
    introductoryPriceNumberOfPeriodsIOS,
    'introductoryPriceSubscriptionPeriodIOS':
    introductoryPriceSubscriptionPeriodIOS,
    'introductoryPriceNumberIOS': introductoryPriceNumberIOS,
    'subscriptionPeriodNumberIOS': subscriptionPeriodNumberIOS,
    'subscriptionPeriodUnitIOS': subscriptionPeriodUnitIOS,
    'subscriptionPeriodAndroid': subscriptionPeriodAndroid,
    'signatureAndroid': signatureAndroid,
    'iconUrl': iconUrl,
    'originalJson': originalJson,
    'originalPrice': originalPrice,
    'discounts': discountsIOS,
    'subscriptionOffers': subscriptionOffersAndroid,
  };

  static List<DiscountIOS>? _extractDiscountIOS(dynamic json) {
    List? list = json as List?;
    List<DiscountIOS>? discounts;

    if (list != null) {
      discounts = list
          .map<DiscountIOS>(
            (dynamic discount) =>
            DiscountIOS.fromJSON(discount as Map<String, dynamic>),
      )
          .toList();
    }

    return discounts;
  }

  static List<SubscriptionOfferAndroid>? _extractSubscriptionOffersAndroid(
      dynamic json) {
    List? list = json as List?;
    List<SubscriptionOfferAndroid>? offers;

    if (list != null) {
      offers = list
          .map<SubscriptionOfferAndroid>(
            (dynamic offer) => SubscriptionOfferAndroid.fromJSON(
            offer as Map<String, dynamic>),
      )
          .toList();
    }

    return offers;
  }
}

class SubscriptionOfferAndroid extends Model {
  String? offerId;
  String? basePlanId;
  String? offerToken;
  List<PricingPhaseAndroid>? pricingPhases;

  SubscriptionOfferAndroid.fromJSON(Map<String, dynamic> json)
      : offerId = json["offerId"] as String?,
        basePlanId = json["basePlanId"] as String?,
        offerToken = json["offerToken"] as String?,
        pricingPhases = _extractAndroidPricingPhase(json["pricingPhases"]);

  static List<PricingPhaseAndroid>? _extractAndroidPricingPhase(dynamic json) {
    List? list = json as List?;
    List<PricingPhaseAndroid>? phases;

    if (list != null) {
      phases = list
          .map<PricingPhaseAndroid>(
            (dynamic phase) =>
            PricingPhaseAndroid.fromJSON(phase as Map<String, dynamic>),
      )
          .toList();
    }

    return phases;
  }

  @override
  Map<String, dynamic> toJson() => {
    'offerId': offerId,
    'basePlanId': basePlanId,
    'offerToken': offerToken,
    'pricingPhases': pricingPhases,
  };
}

class PricingPhaseAndroid extends Model {
  String? price;
  String? formattedPrice;
  String? billingPeriod;
  String? currencyCode;
  int? recurrenceMode;
  int? billingCycleCount;

  PricingPhaseAndroid.fromJSON(Map<String, dynamic> json)
      : price = json["price"] as String?,
        formattedPrice = json["formattedPrice"] as String?,
        billingPeriod = json["billingPeriod"] as String?,
        currencyCode = json["currencyCode"] as String?,
        recurrenceMode = json["recurrenceMode"] as int?,
        billingCycleCount = json["billingCycleCount"] as int?;

  @override
  Map<String, dynamic> toJson() => {
    'price': price,
    'formattedPrice': formattedPrice,
    'billingPeriod': billingPeriod,
    'currencyCode': currencyCode,
    'recurrenceMode': recurrenceMode,
    'billingCycleCount': billingCycleCount,
  };
}

class DiscountIOS extends Model {
  String? identifier;
  String? type;
  String? numberOfPeriods;
  double? price;
  String? localizedPrice;
  String? paymentMode;
  String? subscriptionPeriod;

  DiscountIOS.fromJSON(Map<String, dynamic> json)
      : identifier = json['identifier'] as String?,
        type = json['type'] as String?,
        numberOfPeriods = json['numberOfPeriods'] as String?,
        price = json['price'] as double?,
        localizedPrice = json['localizedPrice'] as String?,
        paymentMode = json['paymentMode'] as String?,
        subscriptionPeriod = json['subscriptionPeriod'] as String?;

  @override
  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'type': type,
    'numberOfPeriods': numberOfPeriods,
    'price': price,
    'localizedPrice': localizedPrice,
    'paymentMode': paymentMode,
    'subscriptionPeriod': subscriptionPeriod,
  };
}

class PurchasedItem extends Model {
  final String? productId;
  final String? transactionId;
  final DateTime? transactionDate;
  final String? transactionReceipt;
  final String? purchaseToken;

  final String? dataAndroid;
  final String? signatureAndroid;
  final bool? autoRenewingAndroid;
  final bool? isAcknowledgedAndroid;
  final PurchaseState? purchaseStateAndroid;

  final DateTime? originalTransactionDateIOS;
  final String? originalTransactionIdentifierIOS;
  final TransactionState? transactionStateIOS;

  PurchasedItem.fromJSON(Map<String, dynamic> json)
      : productId = json['productId'] as String?,
        transactionId = json['transactionId'] as String?,
        transactionDate = _extractDate(json['transactionDate']),
        transactionReceipt = json['transactionReceipt'] as String?,
        purchaseToken = json['purchaseToken'] as String?,
        dataAndroid = json['dataAndroid'] as String?,
        signatureAndroid = json['signatureAndroid'] as String?,
        isAcknowledgedAndroid = json['isAcknowledgedAndroid'] as bool?,
        autoRenewingAndroid = json['autoRenewingAndroid'] as bool?,
        purchaseStateAndroid =
        _decodePurchaseStateAndroid(json['purchaseStateAndroid'] as int?),
        originalTransactionDateIOS =
        _extractDate(json['originalTransactionDateIOS']),
        originalTransactionIdentifierIOS =
        json['originalTransactionIdentifierIOS'] as String?,
        transactionStateIOS =
        _decodeTransactionStateIOS(json['transactionStateIOS'] as int?);

  static DateTime? _extractDate(dynamic timestamp) {
    if (timestamp == null) return null;

    int _toInt() => double.parse(timestamp.toString()).toInt();
    return DateTime.fromMillisecondsSinceEpoch(_toInt());
  }

  @override
  Map<String, dynamic> toJson() => {
    'productId': productId,
    'transactionId': transactionId,
    'transactionDate': transactionDate?.millisecondsSinceEpoch,
    'transactionReceipt': transactionReceipt,
    'purchaseToken': purchaseToken,
    'dataAndroid': dataAndroid,
    'signatureAndroid': signatureAndroid,
    'isAcknowledgedAndroid': isAcknowledgedAndroid,
    'autoRenewingAndroid': autoRenewingAndroid,
    'purchaseStateAndroid': purchaseStateAndroid?.index,
    'originalTransactionDateIOS':
    originalTransactionDateIOS?.millisecondsSinceEpoch,
    'originalTransactionIdentifierIOS': originalTransactionIdentifierIOS,
    'transactionStateIOS': transactionStateIOS?.index,
  };
}

class PurchaseResult extends Model {
  final int? responseCode;
  final String? debugMessage;
  final String? code;
  final String? message;

  PurchaseResult({
    this.responseCode,
    this.debugMessage,
    this.code,
    this.message,
  });

  PurchaseResult.fromJSON(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as int?,
        debugMessage = json['debugMessage'] as String?,
        code = json['code'] as String?,
        message = json['message'] as String?;

  @override
  Map<String, dynamic> toJson() => {
    'responseCode': responseCode,
    'debugMessage': debugMessage,
    'code': code,
    'message': message,
  };
}

class ConnectionResult extends Model {
  final bool? connected;

  ConnectionResult({
    this.connected,
  });

  ConnectionResult.fromJSON(Map<String, dynamic> json)
      : connected = json['connected'] as bool?;

  @override
  Map<String, dynamic> toJson() => {'connected': connected};
}

enum TransactionState {
  purchasing,

  purchased,

  failed,

  restored,

  deferred,
}

TransactionState? _decodeTransactionStateIOS(int? rawValue) {
  switch (rawValue) {
    case 0:
      return TransactionState.purchasing;
    case 1:
      return TransactionState.purchased;
    case 2:
      return TransactionState.failed;
    case 3:
      return TransactionState.restored;
    case 4:
      return TransactionState.deferred;
    default:
      return null;
  }
}

enum PurchaseState {
  pending,

  purchased,

  unspecified,
}

PurchaseState? _decodePurchaseStateAndroid(int? rawValue) {
  switch (rawValue) {
    case 0:
      return PurchaseState.unspecified;
    case 1:
      return PurchaseState.purchased;
    case 2:
      return PurchaseState.pending;
    default:
      return null;
  }
}

abstract class Model {
  Map<String, dynamic> toJson();
  String toString() => toJson().toString();
}