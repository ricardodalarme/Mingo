import 'package:app/features/slips/data/data_sources/remote/queries/generated/JarSlips.graphql.dart';
import 'package:app/features/slips/data/models/drawn_slip.dart';

extension DrawnSlipMapper on QueryJarSlipsslips {
  DrawnSlip toModel() => DrawnSlip(id: id, body: body);
}
