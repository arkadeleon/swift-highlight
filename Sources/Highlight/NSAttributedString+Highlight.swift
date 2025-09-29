//
//  NSAttributedString+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2021/6/25.
//

import Foundation
import JavaScriptCore

extension NSAttributedString {

    public convenience init(code: String, highlightStyle: String = "default") throws {
        let baseURL = Bundle.module.resourceURL!.appendingPathComponent("highlightjs")

        let jsURL = baseURL.appendingPathComponent("highlight.min.js")
        let jsContents = try String(contentsOf: jsURL)

        let cssURL = baseURL.appendingPathComponent("styles/\(highlightStyle).min.css")
        let cssContents = try String(contentsOf: cssURL)

        let context = JSContext()!
        context.evaluateScript(jsContents)

        guard let hljs = context.objectForKeyedSubscript("hljs") else {
            throw HighlightError.hljsObjectNotFound
        }

        guard let result = hljs.invokeMethod("highlightAuto", withArguments: [code]),
              let highlightedCode = result.objectForKeyedSubscript("value")?.toString() else {
            throw HighlightError.highlightAutoFailed
        }

        let html = """
        <style>\(cssContents)</style>
        <pre><code class="hljs">\(highlightedCode)</code></pre>
        """

        guard let data = html.data(using: .utf8) else {
            throw HighlightError.invalidEncoding
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        try self.init(data: data, options: options, documentAttributes: nil)
    }
}
