//
//  Closure.swift
//  TaskIt
//
//  Created by Kyle Dold on 11/02/2021.
//

import Foundation

public typealias EmptyClosure = ReturnClosure<Void>
public typealias ReturnClosure<R> = () -> R
public typealias ValueClosure<T> = (_ value: T) -> Void
