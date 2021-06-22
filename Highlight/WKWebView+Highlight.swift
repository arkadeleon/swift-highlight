//
//  WKWebView+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2021/6/21.
//

import WebKit
import JavaScriptCore

extension WKWebView {

    @discardableResult
    public func loadCode(_ code: String, style: HighlightStyle = .default) -> WKNavigation? {
        guard let context = JSContext() else {
            return nil
        }

        let bundle = Bundle(identifier: "date.leonandvane.highlight")!
        let baseURL = bundle.resourceURL!.appendingPathComponent("Highlight.js")

        let jsURL = baseURL.appendingPathComponent("highlight.pack.js")
        let jsContents = try! String(contentsOf: jsURL)
        context.evaluateScript(jsContents)

        guard let hljs = context.objectForKeyedSubscript("hljs") else {
            return nil
        }

        guard let highlightedCode = hljs.invokeMethod("highlightAuto", withArguments: [code])?.objectForKeyedSubscript("value")?.toString() else {
            return nil
        }

        let html = """
        <!doctype html>
        <meta charset="utf-8">
        <meta name="viewport" content="height=device-height, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" href="styles/\(style.rawValue).css">
        <pre><code class="hljs">\(highlightedCode)</code></pre>
        """

        return loadHTMLString(html, baseURL: baseURL)
    }
}
