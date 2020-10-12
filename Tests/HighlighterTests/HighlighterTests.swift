import XCTest
@testable import Highlighter

final class HighlighterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let highlighter = Highlighter()!
        let code = """
        struct Highlighter {
            var text = "Hello, World!"
        }
        """
        let highlightedCode = highlighter.highlight(code)
        let renderer = UIGraphicsImageRenderer(size: highlightedCode?.size() ?? .zero)
        let image = renderer.image { (context) in
            highlightedCode?.draw(at: .zero)
        }
        XCTAssertEqual(image.size, CGSize(width: 216.5, height: 60))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
