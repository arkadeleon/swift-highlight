//
//  BlobViewController.swift
//  Repospect
//
//  Created by Leon Li on 2020/10/12.
//

import UIKit
import WebKit
import Highlight

class BlobViewController: UIViewController {

    let node: Tree.Node

    var webView: WKWebView!

    init(node: Tree.Node) {
        self.node = node
        super.init(nibName: nil, bundle: nil)
        self.title = node.path
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)

        let task = URLSession.shared.dataTask(with: node.url) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard let blob = try? JSONDecoder().decode(Blob.self, from: data) else {
                return
            }
            guard let decodedData = Data(base64Encoded: blob.content, options: [.ignoreUnknownCharacters]) else {
                return
            }
            guard let decodedString = String(data: decodedData, encoding: .utf8) else {
                return
            }
            DispatchQueue.main.async {
                self.webView.loadCode(decodedString)
            }
        }
        task.resume()
    }
}
