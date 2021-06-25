//
//  HighlightTests.swift
//  HighlightTests
//
//  Created by Leon Li on 2021/6/25.
//

import XCTest
@testable import Highlight

class HighlightTests: XCTestCase {

    let code = """
    struct Highlight {
        var code = "Hello, World!"
    }

    """

    func testTextView() {
        let textView = UITextView()
        textView.loadCode(code)
        XCTAssert(textView.text == code)
    }

    static var allTests = [
        ("testTextView", testTextView),
    ]
}
