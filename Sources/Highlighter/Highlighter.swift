
import UIKit
import JavaScriptCore

open class Highlighter {

    private let hljs: JSValue

    public init?() {
        let context = JSContext()!

        let jsURL = Bundle.module.resourceURL!.appendingPathComponent("Highlight.js/highlight.pack.js")
        let jsContents = try! String(contentsOf: jsURL)
        context.evaluateScript(jsContents)

        guard let hljs = context.objectForKeyedSubscript("hljs") else {
            return nil
        }

        self.hljs = hljs
    }

    open func highlight(_ code: String) -> NSAttributedString? {
        let cssURL = Bundle.module.resourceURL!.appendingPathComponent("Highlight.js/styles/default.css")
        let cssContents = try! String(contentsOf: cssURL)

        guard let highlightedCode = hljs
                .invokeMethod("highlightAuto", withArguments: [code])?.objectForKeyedSubscript("value")?.toString() else {
            return nil
        }

        let string = """
        <style>
            \(cssContents)
        </style>
        <pre><code class="hljs">
            \(highlightedCode)
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
