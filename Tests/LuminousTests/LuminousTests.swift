import XCTest
@testable import Luminous

final class LuminousTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Luminous().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
