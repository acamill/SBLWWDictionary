//
//  File.swift
//  
//
//  Created by Alexandre Camilleri on 27/10/2020.
//

import XCTest
@testable import SBLWWDictionary

extension SBLWWDictionaryTests {
    
    func testMerge() {
        // Given
        let partialResultA = SBLWWDictionary<String>([nodeA, nodeB])
        let partialResultB = SBLWWDictionary<String>([nodeC, nodeD])
        let expectedResult = SBLWWDictionary<String>([nodeB, nodeC, nodeA,  nodeD])

        // When
        let result = partialResultA.merged(with: partialResultB)

        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    // A <=> A + A
    func testMergeIdempotence() {
        // Given
        let dictA = SBLWWDictionary<String>([nodeA])
        
        // When
        let dictB = dictA.merged(with: dictA)
        
        // Then
        XCTAssertEqual(dictA, dictB)
    }
    
    // A + B <=> B + A
    func testMergeCommutativity() {
        // Given
        let dictA = SBLWWDictionary<String>([nodeA])
        let dictB = SBLWWDictionary<String>([nodeB])
        
        // When
        let merge = dictA.merged(with: dictB)
        let mergeAlt = dictB.merged(with: dictA)
        
        // Then
        XCTAssertEqual(merge, mergeAlt)
    }
    
    // (A + B) + C <=> (B + C) + A
    func testMergeAssociativity() {
        // Given
        let dictA = SBLWWDictionary<String>([nodeA])
        let dictB = SBLWWDictionary<String>([nodeB])
        let dictC = SBLWWDictionary<String>([nodeC])
    
        // When
        let merge = dictA.merged(with: dictB).merged(with: dictC)
        let mergeAlt = dictB.merged(with: dictC).merged(with: dictA)
        
        // Then
        XCTAssertEqual(merge, mergeAlt)
    }
}



