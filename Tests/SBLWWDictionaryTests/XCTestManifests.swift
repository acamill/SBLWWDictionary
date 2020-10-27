import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SBLWWDictionaryTests.allTests),
        testCase(SBLWWElementTests.allTests),
    ]
}
#endif
