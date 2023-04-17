//
//  public typealiases.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 07.12.2021.
//

import Foundation

public typealias Closure = () -> Void
public typealias DataClosure<T> = (T) -> Void
public typealias AsyncDataClosure<T> = () async -> T?

