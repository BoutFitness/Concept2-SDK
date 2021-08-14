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

/**
 Wraps a variable to allow notifications upon value changes.
 */
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
  
  /**
   Returns true if there are currently observers.
   */
  public var isObserved:Bool { get { return observers.count > 0 } }
  
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
  public func attach(observer: @escaping (T) -> Void) -> Disposable {
    let wrapped = ObserverWrapper(subject: self, function: observer)
    observers.append(wrapped)
    
    // Notify once on attachment
      wrapped.update(value: value)
    
    return wrapped
  }
  
  func map<U>(transform: @escaping (T) -> U) -> Subject<U> {
    let result: Subject<U> = Subject<U>(value: transform(value))
    result.disposable = self.attach { [weak result] value in
      result?.value = transform(value)
    }
    
    return result
  }
  
  fileprivate func detach(wrappedObserver: ObserverWrapper<T>) {
    observers = observers.filter { $0 !== wrappedObserver }
  }
  
  private func notify() {
    for observer in observers {
        observer.update(value: value)
    }
  }
  
  private var disposable: Disposable?
  private var observers: [ObserverWrapper<T>] = []
  
}

// MARK: -
private class ObserverWrapper<T>: Disposable {
  init(subject: Subject<T>, function: @escaping (T) -> Void) {
    self.subject = subject
    self.function = function
  }
  
  func update(value: T) {
    function(value)
  }
  
  func dispose() {
      subject.detach(wrappedObserver: self)
  }
  
  unowned let subject: Subject<T>
  let function: (T) -> Void
}
