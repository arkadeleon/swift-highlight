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
        let baseURL = Bundle.module.resourceURL!

        let html = """
        <!doctype html>
        <meta charset="utf-8">
        <meta name="viewport" content="height=device-height, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" href="highlightjs/styles/\(style.rawValue).min.css">
        <script src="highlightjs/highlight.min.js"></script>
        <script src="highlightjs-line-numbers/highlightjs-line-numbers.min.js"></script>
        <script>
            hljs.highlightAll();
            hljs.initLineNumbersOnLoad();
        </script>
        <style>
            td.hljs-ln-numbers {
                -webkit-touch-callout: none;
                -webkit-user-select: none;
                -khtml-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;

                text-align: center;
                color: #ccc;
                border-right: 1px solid #ccc;
                vertical-align: top;
                padding-right: 5px;
            }
            td.hljs-ln-code {
                padding-left: 10px;
            }
            code {
                white-space: pre-wrap;
                overflow: auto;
            }
        </style>
        <pre><code>\(code)</code></pre>
        """

        return loadHTMLString(html, baseURL: baseURL)
    }
}
