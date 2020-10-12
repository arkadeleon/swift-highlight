//
//  Highlighter.swift
//
//
//  Created by Leon Li on 2020/10/12.
//

import UIKit
import JavaScriptCore

open class Highlighter {

    public var style: Style

    private let hljs: JSValue

    public init?(style: Style = .default) {
        let context = JSContext()!

        let jsURL = Bundle.module.resourceURL!.appendingPathComponent("Highlight.js/highlight.pack.js")
        let jsContents = try! String(contentsOf: jsURL)
        context.evaluateScript(jsContents)

        guard let hljs = context.objectForKeyedSubscript("hljs") else {
            return nil
        }

        self.style = style
        self.hljs = hljs
    }

    open func highlight(_ text: String) -> NSAttributedString? {
        let cssURL = Bundle.module.resourceURL!.appendingPathComponent("Highlight.js/styles/\(style.rawValue).css")
        let cssContents = try! String(contentsOf: cssURL)

        guard let highlightedText = hljs.invokeMethod("highlightAuto", withArguments: [text])?.objectForKeyedSubscript("value")?.toString() else {
            return nil
        }

        let string = """
        <style>
            \(cssContents)
        </style>
        <pre><code class="hljs">
            \(highlightedText)
        </code></pre>
        """
        guard let data = string.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
}
