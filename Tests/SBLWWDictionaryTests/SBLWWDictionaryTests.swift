import XCTest
@testable import SBLWWDictionary

final class SBLWWDictionaryTests: XCTestCase {
    
    let nodeAOlder = SBLWWNode<String>(value: "a", timestamp: 0)
    let nodeA = SBLWWNode<String>(value: "a", timestamp: 1)
    let nodeANewer = SBLWWNode<String>(value: "a", timestamp: 2)
    let nodeBOlder = SBLWWNode<String>(value: "b", timestamp: 0)
    let nodeB = SBLWWNode<String>(value: "b", timestamp: 1)
    let nodeBNewer = SBLWWNode<String>(value: "b", timestamp: 2)
    
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
        XCTAssert(resultA === resultB)
    }
    
    static var allTests = [
        ("testAddition", testAddition),
        ("testRemoval", testRemoval),
        ("testAddIdempotence", testAddIdempotence),
        ("testRemoveIdempotence", testRemoveIdempotence),
        ("testUpdate", testUpdate),
        ("testUpdateInvalid", testUpdateInvalid),
        ("testCommutativity", testCommutativity),
    ]
}
