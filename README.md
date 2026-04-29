# Swift Highlight

`Swift Highlight` is a small Swift package for syntax highlighting code on Apple platforms.

It uses `highlight.js` under the hood and gives you simple APIs for:

- `NSAttributedString`
- `AttributedString`
- `WKWebView`

## Screenshots

| Light | Dark |
| --- | --- |
| ![Light mode screenshot](Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%20Light.png) | ![Dark mode screenshot](Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%20Dark.png) |

## Features

- Highlight code with very little setup
- Auto-detect language with `highlight.js`
- Use bundled `highlight.js` themes
- Show line numbers in `WKWebView`

## Installation

Add the package to your Swift Package Manager dependencies:

```swift
.package(url: "https://github.com/arkadeleon/swift-highlight.git", branch: "master")
```

Then add `Highlight` to your target dependencies.

## Usage

Import the package:

```swift
import Highlight
```

### NSAttributedString

```swift
let code = """
struct User {
    let name: String
}
"""

let attributedString = try NSAttributedString(
    code: code,
    highlightStyle: "github"
)
```

### AttributedString

`AttributedString` support is available on newer OS versions.

```swift
let attributedString = try AttributedString(
    code: code,
    highlightStyle: "github"
)
```

### WKWebView

```swift
import WebKit

let webView = WKWebView()
webView.highlightCode(code, style: "github")
```

You can also use different themes for light and dark mode:

```swift
webView.highlightCode(
    code,
    lightStyle: "github",
    darkStyle: "atom-one-dark"
)
```

## Themes

This package includes many `highlight.js` CSS themes.

Use the theme file name without `.min.css`. For example:

- `default`
- `github`
- `atom-one-dark`
- `monokai`

## Notes

- `NSAttributedString` and `AttributedString` use HTML generated from `highlight.js`.
- `WKWebView` renders highlighted code directly in a web view and adds line numbers.
- `AttributedString` requires `macOS 12`, `iOS 15`, `tvOS 15`, or `watchOS 8`.

## License

MIT. See [LICENSE](LICENSE).
