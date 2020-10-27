//
//  SBLWWDictionary.swift
//
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

public struct SBLWWDictionary<T: Hashable> {
    
    private var addRegister: [T: TimeInterval]
    private var removeRegister: [T: TimeInterval]
    
    public init() {
        addRegister = [:]
        removeRegister = [:]
    }
    
    public init(_ element: T) {
        self.init()
        addRegister[element] = Date().timeIntervalSinceNow
    }
    
    // MARK: - Add/Update
    
    public mutating func add(_ element: T) {
        add(SBLWWNode(value: element))
    }
    
    public mutating func add(_ node: SBLWWNode<T>) {
        guard let additionTimestamp = addRegister[node.value] else {
            //
            addRegister[node.value] = node.timestamp
            return
        }
        // Update
        addRegister[node.value] = max(additionTimestamp, node.timestamp)
    }
    
    // MARK: - Remove/Update
    
    public mutating func remove(_ element: T) {
        remove(SBLWWNode(value: element))
    }

    
    public mutating func remove(_ node: SBLWWNode<T>) {
            guard let existingNode = lookup(node.value) else {
            removeRegister[node.value] = node.timestamp
            return
        }
        // Update
        removeRegister[node.value] = max(existingNode.timestamp, node.timestamp)
    }
    
    // MARK: - Features
    
    public var resultingElements: [T] {
        resultingDictionnary.map { node -> T in node.value }
    }
    
    public var resultingDictionnary: [SBLWWNode<T>] {
        addRegister
            .filter { addedElement, additionTimestamp -> Bool in
                guard let removalTimestamp = removeRegister.first(where: { removedElement, _ -> Bool in addedElement == removedElement })?.value else {
                    // Element is in resulting dict if it has never been part of the remove register
                    return true
                }
                // Element is in resulting dict if the addition is ulterior to removal (In the case where the element was added a second time)
                return additionTimestamp > removalTimestamp
            }
            .map { element, timestamp -> SBLWWNode<T> in
                SBLWWNode<T>(value: element, timestamp: timestamp)
            }
    }
    
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
