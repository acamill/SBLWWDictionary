//
//  SBLWWElement.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

public struct SBLWWElement<T: Hashable>: Comparable {
    public let value: T
    // Used as unique ID
    public let timestamp: TimeInterval
    
    public static func == (lhs: SBLWWElement<T>, rhs: SBLWWElement<T>) -> Bool {
        lhs.value == rhs.value
    }
    
    public static func === (lhs: SBLWWElement<T>, rhs: SBLWWElement<T>) -> Bool {
        lhs.value == rhs.value && lhs.timestamp == rhs.timestamp
    }
    
    // Compare timestamps
    public static func < (lhs: SBLWWElement<T>, rhs: SBLWWElement<T>) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}
