//
//  UITextView+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2021/6/25.
//

import UIKit
import JavaScriptCore

extension UITextView {

    public func loadCode(_ code: String, style: HighlightStyle = .default) {
        let bundle = Bundle(identifier: "date.leonandvane.highlight")!
        let baseURL = bundle.resourceURL!.appendingPathComponent("highlightjs")

        let jsURL = baseURL.appendingPathComponent("highlight.min.js")
        let jsContents = try! String(contentsOf: jsURL)

        let cssURL = baseURL.appendingPathComponent("styles/\(style.rawValue).min.css")
        let cssContents = try! String(contentsOf: cssURL)

        let context = JSContext()!
        context.evaluateScript(jsContents)

        guard let hljs = context.objectForKeyedSubscript("hljs") else {
            return
        }

        guard let highlightedCode = hljs.invokeMethod("highlightAuto", withArguments: [code])?.objectForKeyedSubscript("value")?.toString() else {
            return
        }

        let html = """
        <style>\(cssContents)</style>
        <pre><code class="hljs">\(highlightedCode)</code></pre>
        """

        guard let data = html.data(using: .utf8) else {
            return
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        attributedText = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
}
