part of 'pagar_bloc.dart';

@immutable
class PagarState {
  final double montoPagar;
  final String moneda; // CAD,USD
  final bool tarjetaActiva;
  final TarjetaCredito? tarjeta;

  String get montoPagarString => '${ (this.montoPagar * 100).floor() }';


static final TarjetaCredito tarjetaDefaul = TarjetaCredito(
    cardNumberHidden: '4242',
    cardNumber: '4242424242424242',
    brand: 'visa',
    cvv: '213',
    expiracyDate: '01/25',
    cardHolderName: 'Tarjeta default',
  );

  PagarState({
    this.montoPagar = 375.55, 
    this.moneda = 'USD', 
    this.tarjetaActiva =false, 
    TarjetaCredito? tarjeta, // Parámetro opcional
  }) : this.tarjeta = tarjeta ?? tarjetaDefaul; // Asignación de valor predeterminado



  PagarState copyWith({
    double?         montoPagar,
    String?         moneda, // CAD,USD
    bool?           tarjetaActiva,
    TarjetaCredito? tarjeta
  }) => PagarState(
    montoPagar    : montoPagar ?? this.montoPagar, 
    moneda        : moneda ?? this.moneda, // CAD,USD
    tarjetaActiva : tarjetaActiva ?? this.tarjetaActiva,
    tarjeta       : tarjeta ?? tarjeta
  );

  @override
  String toString() {
    print('tarjetaActiva $tarjetaActiva');
    return super.toString();
  }



}


