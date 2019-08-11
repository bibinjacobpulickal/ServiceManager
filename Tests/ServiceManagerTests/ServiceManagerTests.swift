import XCTest
@testable import ServiceManager

final class ServiceManagerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ServiceManager().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
