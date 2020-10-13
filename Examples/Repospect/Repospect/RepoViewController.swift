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

        searchBar.text = "arkadeleon/highlighter"
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
        treeViewController.didMove(toParent: self)

        treeViewController.view.translatesAutoresizingMaskIntoConstraints = false
        treeViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        treeViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        treeViewController.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        treeViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension RepoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        search()
    }
}
