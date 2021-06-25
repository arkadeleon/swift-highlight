//
//  WKWebView+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2021/6/21.
//

import WebKit

extension WKWebView {

    @discardableResult
    public func loadCode(_ code: String, style: HighlightStyle = .default) -> WKNavigation? {
        let bundle = Bundle(identifier: "date.leonandvane.highlight")!
        let baseURL = bundle.resourceURL!.appendingPathComponent("highlightjs")

        let html = """
        <!doctype html>
        <meta charset="utf-8">
        <meta name="viewport" content="height=device-height, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" href="styles/\(style.rawValue).min.css">
        <script src="highlight.min.js"></script>
        <script>hljs.highlightAll();</script>
        <pre><code>\(code)</code></pre>
        """

        return loadHTMLString(html, baseURL: baseURL)
    }
}
