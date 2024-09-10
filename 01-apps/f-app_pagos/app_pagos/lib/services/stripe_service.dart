import 'package:app_pagos/models/stripe_custom_response.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:stripe_payment/stripe_payment.dart';
//import 'package:stripe_app/models/payment_intent_response.dart';

//import 'package:stripe_app/models/stripe_custom_response.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;


  String _paymentApiUrl    = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = 'sk_test_51HIgBqKmrePqgf9DSVeUNw7GfLlNJBlwn2JWDBVdimhHCO7N2fW8vgQBWUBKYontobwkXSWXv3hTUPVtZ5PHVKXz007MjU1qPW';
  String _apiKey           = 'pk_test_51HIgBqKmrePqgf9DEW9flGs2Sy1ZKBnIYrCnw8DcMnSc5D0rvB13IETHc3mUZoPUePx4eZ50SvVFSn74RaK5WF1B00EcvZTSxb';

void init() {
  /*
    // Configura Stripe con tu clave pública
    Stripe.publishableKey = _apiKey;

    // Si usas Apple Pay, también debes configurar el identificador del comerciante y el esquema de URL
    Stripe.merchantIdentifier = 'your.merchant.identifier'; // Cambia esto si usas Apple Pay
    Stripe.urlScheme = _paymentApiUrl; // Configura el esquema de URL si lo necesitas
    */
  }

  Future <StripeCustomResponse> pagarConTarjetaExistente({
    required String amount,
    required String currency,
    required Object paymentMethod,
  }) async { 

    try {
      /*
      // Crear PaymentIntent en tu servidor (debes tener un endpoint para esto)
      final paymentIntentResponse = await _crearPaymentIntent(amount: amount, currency: currency);

      // Realizar el pago
      final paymentIntentClientSecret = paymentIntentResponse['client_secret'];

      final paymentResult = await Stripe.instance.confirmPayment(paymentIntentClientSecret: paymentIntentClientSecret);
*/
      return StripeCustomResponse(
          ok: true,
          msg: 'ok',
      );     

    } catch(e){
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future <StripeCustomResponse> pagarConNuevaTarjeta({
    required String amount,
    required String currency,
  }) async { 

    /*
    // Crear PaymentIntent en tu servidor
    final paymentIntentResponse    = await _crearPaymentIntent(amount: amount, currency: currency);
    final paymentIntentClientSecret = paymentIntentResponse['client_secret'];

   // Solicitar los detalles de la tarjeta del usuario
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(
            // Puedes agregar detalles adicionales si es necesario
          ),
        ),
      ),
    );
    */
    return StripeCustomResponse(
        ok: true,
        msg: 'test'
    );

  }

  Future pagarApplePayGooglePay({
    required String amount,
    required String currency,
  }) async { 
    return StripeCustomResponse(
        ok: true,
        msg: 'test'
    );
  }

  Future _crearPaymentIntent({
    required String amount,
    required String currency,
  }) async { 
    return StripeCustomResponse(
        ok: true,
        msg: 'test'
    );
  }

  Future _ralizarPago({
    required String amount,
    required String currency,
    required Object paymentMethod
  }) async {
    return StripeCustomResponse(
        ok: true,
        msg: 'test'
    );
  }

}
