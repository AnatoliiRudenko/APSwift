//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 09.06.2022.
//

import Foundation

public enum Environment {
    
    case debug
    case testFlight
    case prod
    
    public init() {
        if Environment.isTestFlight {
            self = .testFlight
            return
        }
        if Environment.isDebug {
            self = .debug
            return
        }
        self = .prod
    }
}

private extension Environment {
    
    static var isTest: Bool {
        isTestFlight || isDebug
    }
    
    static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
