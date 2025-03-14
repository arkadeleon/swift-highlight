//
//  WKWebView+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2021/6/21.
//

import WebKit

extension WKWebView {

    @discardableResult
    public func loadCode(_ code: String, style: String = "default") -> WKNavigation? {
        let html = """
        <!doctype html>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" href="highlightjs/styles/\(style).min.css">
        <script src="highlightjs/highlight.min.js"></script>
        <script src="highlightjs-line-numbers/highlightjs-line-numbers.min.js"></script>
        <script>
          hljs.highlightAll();
        </script>
        <style>
          code {
            white-space: pre;
          }
        </style>
        <pre><code>\(code)</code></pre>
        """

        return loadHTMLString(html, baseURL: Bundle.module.resourceURL!)
    }
}
