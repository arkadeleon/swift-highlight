//
//  AttributedString+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2025/9/29.
//

import Foundation

@available(macOS 12, iOS 15, tvOS 15, watchOS 8, *)
extension AttributedString {

    public init(code: String, highlightStyle: String = "default") throws {
        try self.init(NSAttributedString(code: code, highlightStyle: highlightStyle))
    }
}
