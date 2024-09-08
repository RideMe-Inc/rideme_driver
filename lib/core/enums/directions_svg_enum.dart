import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';

enum DirectionsSvgEnum {
  forkLeft(
    maneuver: 'fork-left',
    svg: SvgNameConstants.forkLeft,
  ),
  forkRight(
    maneuver: 'fork-right',
    svg: SvgNameConstants.forkRight,
  ),
  genericDirection(
    maneuver: 'generic-direction',
    svg: SvgNameConstants.genericDirection,
  ),
  merge(
    maneuver: 'merge',
    svg: SvgNameConstants.merge,
  ),
  rampLeft(
    maneuver: 'ramp-left',
    svg: SvgNameConstants.rampLeft,
  ),
  rampRight(
    maneuver: 'ramp-right',
    svg: SvgNameConstants.rampRight,
  ),
  roundaboutRight(
    maneuver: 'roundabout-right',
    svg: SvgNameConstants.roundaboutRight,
  ),
  roundaboutLeft(
    maneuver: 'roundabout-left',
    svg: SvgNameConstants.roundaboutLeft,
  ),
  straight(
    maneuver: 'straight',
    svg: SvgNameConstants.straight,
  ),
  turnRight(
    maneuver: 'turn-right',
    svg: SvgNameConstants.turnRight,
  ),
  turnLeft(
    maneuver: 'turn-left',
    svg: SvgNameConstants.turnLeft,
  ),
  turnSharpRight(
    maneuver: 'turn-sharp-right',
    svg: SvgNameConstants.turnSharpRight,
  ),
  turnSharpLeft(
    maneuver: 'turn-sharp-left',
    svg: SvgNameConstants.turnSharpLeft,
  ),
  turnSlightRight(
    maneuver: 'turn-slight-right',
    svg: SvgNameConstants.turnSlightRight,
  ),
  turnSlightLeft(
    maneuver: 'turn-slight-left',
    svg: SvgNameConstants.turnSlightLeft,
  ),
  uTurnLeft(
    maneuver: 'u-turn-left',
    svg: SvgNameConstants.uTurnLeft,
  ),
  uTurnRight(
    maneuver: 'u-turn-right',
    svg: SvgNameConstants.uTurnRight,
  );

  final String maneuver, svg;

  const DirectionsSvgEnum({required this.maneuver, required this.svg});
}
