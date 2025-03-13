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

    func testAttributedString() throws {
        let attributedString = try NSAttributedString(code: code)!
        XCTAssert(attributedString.string == code)
    }
}
