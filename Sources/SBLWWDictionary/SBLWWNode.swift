//
//  SBLWWElement.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

public struct SBLWWNode<T: Hashable>: Comparable {
    public let value: T
    // Used as unique ID
    public let timestamp: TimeInterval
    
    init(value: T, timestamp: TimeInterval = Date().timeIntervalSinceNow) {
        self.value = value
        self.timestamp = timestamp
    }
    
    public static func == (lhs: SBLWWNode<T>, rhs: SBLWWNode<T>) -> Bool {
        lhs.value == rhs.value
    }
    
    public static func === (lhs: SBLWWNode<T>, rhs: SBLWWNode<T>) -> Bool {
        lhs.value == rhs.value && lhs.timestamp == rhs.timestamp
    }
    
    // Compare timestamps
    public static func < (lhs: SBLWWNode<T>, rhs: SBLWWNode<T>) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}
