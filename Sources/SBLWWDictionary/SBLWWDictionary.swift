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
        add(element)
    }
    
    public init(_ elements: [T]) {
        self.init()
        elements.forEach { element in
            add(element)
        }
    }
    
    public init(_ node: SBLWWNode<T>) {
        self.init()
        add(node)
    }
    
    public init(_ nodes: [SBLWWNode<T>]) {
        self.init()
        nodes.forEach { node in
            add(node)
        }
    }
    
    public var resultingElements: [T] {
        resultingNodes.map { node -> T in node.element }
    }
    
    public var resultingNodes: Set<SBLWWNode<T>> {
        addRegister
            // Merge logic - element from the addRegister, which are not contained in the removalRegister at posterior timestamps
            .filter { addedElement, additionTimestamp -> Bool in
                guard let removalTimestamp = removeRegister.first(where: { removedElement, _ -> Bool in addedElement == removedElement })?.value else {
                    // Element is in resulting dict if it has never been part of the remove register
                    return true
                }
                // Element is in resulting dict if the addition is ulterior to removal (In the case where the element was added a second time)
                return additionTimestamp > removalTimestamp
            }
            // Reduce into Set
            .reduce(into: Set<SBLWWNode<T>>()) { result, registerEntry in
                let (element, timestamp) = registerEntry
                result.insert(SBLWWNode<T>(value: element, timestamp: timestamp))
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

// MARK: - Merging
extension SBLWWDictionary {
    
    // Pure func version
    public func merged(with otherSBLWWDictionary: SBLWWDictionary) -> SBLWWDictionary {
        var result = self
        result.merge(with: otherSBLWWDictionary)
        return result
    }
    
    public mutating func merge(with otherSBLWWDictionary: SBLWWDictionary) {
        otherSBLWWDictionary.addRegister.forEach { element, timestamp in
            add(SBLWWNode<T>(value: element, timestamp: timestamp))
        }
        otherSBLWWDictionary.removeRegister.forEach { element, timestamp in
            remove(SBLWWNode<T>(value: element, timestamp: timestamp))
        }
    }
}

