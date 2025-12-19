import XCTest
@testable import LoopwishCore

final class LoopwishCoreTests: XCTestCase {
    func testTagline() {
        XCTAssertEqual(LoopwishCore.tagline(), "Ønsk. Del. Få. Sammen.")
    }
}
