import XCTest
@testable import SBLWWDictionary

final class SBLWWElementTests: XCTestCase {
    func testEquatable() {
        let element = SBLWWElement<String>(value: "Element", timestamp: 0)
        let identicalElement = SBLWWElement<String>(value: "Element", timestamp: 0)
        let differentElement = SBLWWElement<String>(value: "Another Element", timestamp: 0)
        
        XCTAssertEqual(element, element)
        XCTAssertEqual(element, identicalElement)
        XCTAssertNotEqual(element, differentElement)
    }
    
    func testStrictComparison() {
        let element = SBLWWElement<String>(value: "Element", timestamp: 0)
        let identicalElement = SBLWWElement<String>(value: "Element", timestamp: 0)
        let differentElement = SBLWWElement<String>(value: "Another Element", timestamp: 1)
        
        XCTAssertTrue(element === element)
        XCTAssertTrue(element === identicalElement)
        XCTAssertFalse(element === differentElement)
    }
    
    func testComparable() {
        let element = SBLWWElement<String>(value: "Element", timestamp: 0)
        let recentElement = SBLWWElement<String>(value: "Element", timestamp: 1)
        let differentElement = SBLWWElement<String>(value: "Another Element", timestamp: 1)
        
        XCTAssertGreaterThan(recentElement, element)
        XCTAssertFalse(recentElement > differentElement)
    }

    static var allTests = [
        ("testEquatable", testEquatable),
        ("testStrictComparison", testStrictComparison),
        ("testComparable", testComparable)
    ]
}
