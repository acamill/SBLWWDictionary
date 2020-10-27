//
//  File.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

extension SBLWWNode {
    public static func == (lhs: SBLWWNode<T>, rhs: SBLWWNode<T>) -> Bool {
        lhs.element == rhs.element
    }
    
    public static func === (lhs: SBLWWNode<T>, rhs: SBLWWNode<T>) -> Bool {
        lhs.element == rhs.element && lhs.timestamp == rhs.timestamp
    }
}
