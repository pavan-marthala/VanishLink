import 'package:flutter/material.dart';
import 'sized_context.dart';
import 'dimens.dart';

bool checkDesktopSize(final BuildContext context) {
  return context.widthPx > Dimens.largeDeviceBreakPoint;
}

bool checkMediumDeviceSize(final BuildContext context) {
  return context.widthPx > Dimens.mediumDeviceBreakPoint;
}

bool checkSmallDeviceSize(final BuildContext context) {
  return context.widthPx < Dimens.smallDeviceBreakPoint;
}

bool checkVerySmallDeviceSize(final BuildContext context) {
  return context.widthPx < Dimens.verySmallDeviceBreakPoint;
}
