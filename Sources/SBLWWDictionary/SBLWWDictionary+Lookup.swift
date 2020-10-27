//
//  File.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

// MARK: - Lookup
extension SBLWWDictionary {
    /// Look if an element is currently held by the dictionnary.
    /// - Parameter element: The element to look for.
    /// - Returns: The node representation of the element.
    public func lookup(_ element: T) -> SBLWWNode<T>? {
        guard let additionTimestamp = addRegister[element] else {
            // Element not in add register, so not in dict
            return nil
        }
        let node = SBLWWNode<T>(value: element, timestamp: additionTimestamp)
        guard let removalTimstamp = removeRegister[element] else {
            // Element not in remove register, so in dict
            return node
        }
        return additionTimestamp > removalTimstamp ? node : nil
    }
}
