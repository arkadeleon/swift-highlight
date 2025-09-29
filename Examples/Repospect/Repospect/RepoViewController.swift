//
//  RepoViewController.swift
//  Repospect
//
//  Created by Leon Li on 2020/10/12.
//

import UIKit
import Combine

class RepoViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    var treeViewController: TreeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.text = "arkadeleon/swift-highlight"
        search()
    }

    private func search() {
        guard let text = searchBar.text else {
            return
        }

        let components = text.split(separator: "/")
        guard components.count == 2 else {
            return
        }

        let owner = String(components[0])
        let repo = String(components[1])

        if treeViewController != nil {
            treeViewController.willMove(toParent: nil)
            treeViewController.view.removeFromSuperview()
            treeViewController.removeFromParent()
            treeViewController = nil
        }

        treeViewController = TreeViewController(tree: .root(owner: owner, repo: repo))
        addChild(treeViewController)
        view.addSubview(treeViewController.view)
        treeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        treeViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            treeViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            treeViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            treeViewController.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            treeViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension RepoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        search()
    }
}
