//
//  WorkoutState.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

enum WorkoutState:Int {
  case WaitToBegin = 0
  case WorkoutRow
  case CountdownPause
  case IntervalRest
  case IntervalWorkTime
  case IntervalWorkDistance
  case IntervalRestEndToWorkTime
  case IntervalRestEndToWorkDistance
  case IntervalWorkTimeToRest
  case IntervalWorkDistanceToRest
  case WorkoutEnd
  case Terminate
  case WorkoutLogged
  case Rearm
}
