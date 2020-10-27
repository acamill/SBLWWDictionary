//
//  SBLWWDictionary.swift
//
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import Foundation

public struct SBLWWDictionary<T: Hashable>: Equatable {
    
    private (set) var addRegister: [T: TimeInterval]
    private (set) var removeRegister: [T: TimeInterval]
    
    public init() {
        addRegister = [:]
        removeRegister = [:]
    }
    
    public init(_ element: T) {
        self.init()
        addRegister[element] = Date().timeIntervalSinceNow
    }
    
    public init(_ node: SBLWWNode<T>) {
        self.init()
        addRegister[node.element] = node.timestamp
    }
    
    public var resultingElements: [T] {
        resultingDictionnary.map { node -> T in node.element }
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
}

// MARK: - Add/Remove/Update
extension SBLWWDictionary {
    
    public mutating func add(_ element: T) {
        add(SBLWWNode(value: element))
    }
    
    public mutating func add(_ node: SBLWWNode<T>) {
        guard let additionTimestamp = addRegister[node.element] else {
            //
            addRegister[node.element] = node.timestamp
            return
        }
        // Update
        addRegister[node.element] = max(additionTimestamp, node.timestamp)
    }

    public mutating func remove(_ element: T) {
        remove(SBLWWNode(value: element))
    }

    
    public mutating func remove(_ node: SBLWWNode<T>) {
            guard let existingNode = lookup(node.element) else {
            removeRegister[node.element] = node.timestamp
            return
        }
        // Update
        removeRegister[node.element] = max(existingNode.timestamp, node.timestamp)
    }
}
