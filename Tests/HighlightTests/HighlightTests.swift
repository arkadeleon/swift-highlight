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

    @available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
    func testAttributedString() throws {
        let attributedString = try AttributedString(code: code)
        XCTAssert(String(attributedString.characters) == code)
    }

    func testNSAttributedString() throws {
        let attributedString = try NSAttributedString(code: code)
        XCTAssert(attributedString.string == code)
    }
}
