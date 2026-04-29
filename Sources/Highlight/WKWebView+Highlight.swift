//
//  WKWebView+Highlight.swift
//  Highlight
//
//  Created by Leon Li on 2021/6/21.
//

import WebKit

extension WKWebView {
    @discardableResult
    public func highlightCode(_ code: String, style: String = "default") -> WKNavigation? {
        let html = """
        <!doctype html>
        <html lang="en">
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
          <link rel="stylesheet" href="highlightjs/styles/\(style).min.css">
          <script src="highlightjs/highlight.min.js"></script>
          <script src="highlightjs-line-numbers/highlightjs-line-numbers.min.js"></script>
          <style>
            :root {
              color-scheme: light dark;
            }

            html,
            body {
              margin: 0;
              background: transparent;
            }

            body {
              -webkit-text-size-adjust: 100%;
              font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, monospace;
            }

            pre {
              margin: 0;
            }

            code {
              white-space: pre;
              font-family: inherit;
              tab-size: 4;
            }

            .hljs-ln {
              width: 100%;
              border-collapse: collapse;
            }

            .hljs-ln td.hljs-ln-numbers {
              user-select: none;
              opacity: 0.45;
              padding: 0 0.75em 0 0;
              text-align: right;
              vertical-align: top;
              border-right: 1px solid rgba(127, 127, 127, 0.25);
            }

            .hljs-ln td.hljs-ln-code {
              padding-left: 0.75em;
              padding-right: 0.75em;
            }
          </style>
          <script>
            document.addEventListener('DOMContentLoaded', () => {
              const codeBlock = document.getElementById('code-block');
              if (!codeBlock) {
                return;
              }

              hljs.highlightElement(codeBlock);
              hljs.lineNumbersBlock(codeBlock, { singleLine: true });
            });
          </script>
        </head>
        <body>
          <pre><code id="code-block">\(code.htmlEscapedForHTML)</code></pre>
        </body>
        </html>
        """

        return loadHTMLString(html, baseURL: Bundle.module.resourceURL!)
    }
}

private extension String {
    var htmlEscapedForHTML: String {
        var escaped = String()
        escaped.reserveCapacity(count)

        for character in self {
            switch character {
            case "&":
                escaped.append("&amp;")
            case "<":
                escaped.append("&lt;")
            case ">":
                escaped.append("&gt;")
            case "\"":
                escaped.append("&quot;")
            case "'":
                escaped.append("&#39;")
            default:
                escaped.append(character)
            }
        }

        return escaped
    }
}
