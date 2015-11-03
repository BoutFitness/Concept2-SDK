//
//  Subject.swift
//  Pods
//
//  Created by Jesse Curry on 11/2/15.
//
//  Big thanks to Daniel Tartaglia
//  https://gist.github.com/dtartaglia/0a71423c578f2bf3b15c
//

import Foundation

public protocol Disposable {
  func dispose()
}

public class Subject<T> {
  
  /**
    The value that is to be observered.
    All current observers will be notified when it is assigned to.
   */
  public var value: T {
    didSet {
      notify()
    }
  }
  
  init(value: T) {
    self.value = value
  }
  
  deinit {
    disposable?.dispose()
  }
  
  /**
    To observe changes in the subject, attach a block.
    When you want observation to end, call `dispose` on the returned Disposable
   */
  public func attach(observer: (T) -> Void) -> Disposable {
    let wrapped = ObserverWrapper(subject: self, function: observer)
    observers.append(wrapped)
    
    // Notify once on attachment
    wrapped.update(value)
    
    return wrapped
  }
  
  func map<U>(transform: (T) -> U) -> Subject<U> {
    let result: Subject<U> = Subject<U>(value: transform(value))
    result.disposable = self.attach { [weak result] value in
      result?.value = transform(value)
    }
    
    return result
  }
  
  private func detach(wrappedObserver: ObserverWrapper<T>) {
    observers = observers.filter { $0 !== wrappedObserver }
  }
  
  private func notify() {
    for observer in observers {
      observer.update(value)
    }
  }
  
  private var disposable: Disposable?
  private var observers: [ObserverWrapper<T>] = []
  
}

// MARK: -
private class ObserverWrapper<T>: Disposable {
  init(subject: Subject<T>, function: (T) -> Void) {
    self.subject = subject
    self.function = function
  }
  
  func update(value: T) {
    function(value)
  }
  
  func dispose() {
    subject.detach(self)
  }
  
  unowned let subject: Subject<T>
  let function: (T) -> Void
}
