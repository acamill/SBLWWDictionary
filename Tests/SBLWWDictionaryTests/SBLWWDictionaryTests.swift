import XCTest
@testable import SBLWWDictionary

final class SBLWWDictionaryTests: XCTestCase {
    
    let nodeAOlder = SBLWWNode<String>(value: "a", timestamp: 0)
    let nodeA = SBLWWNode<String>(value: "a", timestamp: 1)
    let nodeANewer = SBLWWNode<String>(value: "a", timestamp: 2)
    let nodeB = SBLWWNode<String>(value: "b", timestamp: 1)
    let nodeC = SBLWWNode<String>(value: "c", timestamp: 1)
    let nodeD = SBLWWNode<String>(value: "d", timestamp: 1)
    
    func testEquatable() {
        XCTAssertEqual(SBLWWDictionary<String>([nodeA, nodeB]), SBLWWDictionary<String>([nodeA, nodeB]))
        XCTAssertNotEqual(SBLWWDictionary<String>([nodeA, nodeB]), SBLWWDictionary<String>([nodeA, nodeD]))
    }
    
    func testCommutable() {
        XCTAssertEqual(SBLWWDictionary<String>([nodeA, nodeB]), SBLWWDictionary<String>([nodeB, nodeA]))
    }
    
    func testAddition() {
        // Given
        let expectedResult = SBLWWDictionary<String>(nodeA)
        
        // When
        var result = SBLWWDictionary<String>()
        result.add(nodeA)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testRemoval() {
        // Given
        let expectedResult = SBLWWDictionary<String>()
        
        // When
        var result = SBLWWDictionary<String>(nodeA)
        result.remove(nodeA)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    /// The result doesn’t change if you apply the same operation several times.
    func testAddIdempotence() {
        // Given
        let expectedResult = SBLWWDictionary<String>(nodeA)
        
        // When
        var result = SBLWWDictionary<String>()
        result.add(nodeA)
        result.add(nodeA)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    /// The result doesn’t change if you apply the same operation several times.
    func testRemoveIdempotence() {
        // Given
        let expectedResult = SBLWWDictionary<String>()
        
        // When
        var result = SBLWWDictionary<String>(nodeA)
        result.remove(nodeA)
        result.remove(nodeA)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testUpdate() {
        // Given
        let expectedResult = SBLWWDictionary<String>(nodeANewer)
        
        // When
        var result = SBLWWDictionary<String>(nodeA)
        result.add(nodeANewer)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testUpdateInvalid() {
        // Given
        let expectedResult = SBLWWDictionary<String>(nodeA)
        
        // When
        var result = SBLWWDictionary<String>(nodeA)
        result.add(nodeAOlder)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testCommutativity() {
        // Given
        var resultA = SBLWWDictionary<String>()
        var resultB = SBLWWDictionary<String>()
        
        // When
        resultA.add(nodeAOlder)
        resultA.remove(nodeA)
        resultA.add(nodeB)
        resultA.add(nodeA)
        
        resultB.add(nodeB)
        resultB.add(nodeAOlder)
        resultB.add(nodeA)
        resultB.remove(nodeA)
        
        // Then
        XCTAssertEqual(resultA, resultB)
    }
    
    static var allTests = [
        ("testEquatable", testEquatable),
        ("testCommutable", testCommutable),
        ("testAddition", testAddition),
        ("testRemoval", testRemoval),
        ("testAddIdempotence", testAddIdempotence),
        ("testRemoveIdempotence", testRemoveIdempotence),
        ("testUpdate", testUpdate),
        ("testUpdateInvalid", testUpdateInvalid),
        ("testCommutativity", testCommutativity),
        ("testMerge", testMerge),
        ("testMergeIdempotence", testMergeIdempotence),
        ("testMergeCommutativity", testMergeCommutativity),
        ("testMergeAssociativity", testMergeAssociativity),
    ]
}
