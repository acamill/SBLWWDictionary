//
//  File.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

extension SBLWWDictionary {
    
    /// Comparison to check that they contain same nodes.
    public static func == (lhs: SBLWWDictionary<T>, rhs: SBLWWDictionary<T>) -> Bool {
        lhs.resultingNodes == rhs.resultingNodes
    }
}
