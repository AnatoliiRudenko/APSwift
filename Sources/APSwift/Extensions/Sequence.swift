//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 06.04.2023.
//

import Foundation

public extension Sequence {
    
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }
    
    func asyncForEach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
    
    /// A task group automatically waits for all of its
    /// sub-tasks to complete, while also performing those
    /// tasks in parallel:
    func concurrentForEach(_ operation: @escaping (Element) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await operation(element)
                }
            }
        }
    }
    
    /// A task group automatically waits for all of its
    /// sub-tasks to complete, while also performing those
    /// tasks in parallel:
    func concurrentMap<T>(_ transform: @escaping (Element) async throws -> T) async throws -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }
        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
}
