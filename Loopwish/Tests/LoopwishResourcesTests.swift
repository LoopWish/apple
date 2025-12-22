import XCTest
import LoopwishResources

final class LoopwishResourcesTests: XCTestCase {
    func testLoadsTaglineFromTokens() {
        XCTAssertEqual(LoopwishDesign.tagline(), "Ønsk. Del. Få. Sammen.")
    }

    func testResolvesSemanticHex() {
        XCTAssertEqual(LoopwishDesign.hex(.textPrimary, theme: .light), "#2C3E50")
        XCTAssertEqual(LoopwishDesign.hex(.actionPrimaryBackground, theme: .light), "#5DADE2")
    }
}
