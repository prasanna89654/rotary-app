import 'package:equatable/equatable.dart';

import 'dg.dart';
import 'footer.dart';
import 'slider.dart';

class HomeEntities extends Equatable {
  final String? aboutRotatory;
  final List<Slider>? slider;
  final Dg? dg;
  final Footer? footer;

  const HomeEntities({this.aboutRotatory, this.slider, this.dg, this.footer});

  @override
  List<Object?> get props => [aboutRotatory, slider, dg, footer];
}
