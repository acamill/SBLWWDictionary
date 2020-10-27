//
//  File.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

extension SBLWWNode {
    /// Compares Timestamps
    /// - Parameters:
    ///   - lhs: <#lhs description#>
    ///   - rhs: <#rhs description#>
    /// - Returns: <#description#>
    public static func < (lhs: SBLWWNode<T>, rhs: SBLWWNode<T>) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}
