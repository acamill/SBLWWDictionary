//
//  File.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

extension SBLWWDictionary {
    
    /// Comparison to check that they contain same elements and timestamps.
    /// - Parameters:
    ///   - lhs: <#lhs description#>
    ///   - rhs: <#rhs description#>
    /// - Returns: <#description#>
    public static func == (lhs: SBLWWDictionary<T>, rhs: SBLWWDictionary<T>) -> Bool {
        lhs.resultingDictionnary == rhs.resultingDictionnary
    }
    
    /// Comparison to check if they have the same add/remove registers
    /// - Parameters:
    ///   - lhs: <#lhs description#>
    ///   - rhs: <#rhs description#>
    /// - Returns: <#description#>
    public static func === (lhs: SBLWWDictionary<T>, rhs: SBLWWDictionary<T>) -> Bool {
        lhs.addRegister == rhs.addRegister && lhs.removeRegister == rhs.removeRegister
    }
}
