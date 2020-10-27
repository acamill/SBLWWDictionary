//
//  SBLWWElement.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

/// Representation of an element held in a SBLWWDictionnary
public struct SBLWWNode<T: Hashable>: Comparable {
    public let element: T
    public let timestamp: TimeInterval
    
    init(value: T, timestamp: TimeInterval = Date().timeIntervalSinceNow) {
        self.element = value
        self.timestamp = timestamp
    }
}
