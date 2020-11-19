import XCTest
@testable import Store

final class StoreTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Store().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
