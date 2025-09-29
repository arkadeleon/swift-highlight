//
//  TreeViewController.swift
//  Repospect
//
//  Created by Leon Li on 2020/10/12.
//

import UIKit

class TreeViewController: UIViewController {

    enum Tree {
        case root(owner: String, repo: String)
        case node(node: Repospect.Tree.Node)
    }

    let tree: Tree
    private var nodes: [Repospect.Tree.Node] = []

    var tableView: UITableView!

    init(tree: Tree) {
        self.tree = tree
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        switch tree {
        case .root(let owner, let repo):
            Task {
                let branchsURL = URL(string: "https://api.github.com/repos/\(owner)/\(repo)/branches")!
                let (branchsData, _) = try await URLSession.shared.data(from: branchsURL)

                let branches = try JSONDecoder().decode([Branch].self, from: branchsData)
                guard let branch = branches.first else {
                    return
                }

                let treeURL = URL(string: "https://api.github.com/repos/\(owner)/\(repo)/git/trees/\(branch.commit.sha)")!
                let (treeData, _) = try await URLSession.shared.data(from: treeURL)

                let tree = try JSONDecoder().decode(Repospect.Tree.self, from: treeData)

                nodes = tree.tree.sorted()
                tableView.reloadData()
            }
        case .node(let node):
            title = node.path

            Task {
                let (data, _) = try await URLSession.shared.data(from: node.url)

                let tree = try JSONDecoder().decode(Repospect.Tree.self, from: data)

                nodes = tree.tree.sorted()
                tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
}

extension TreeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let node = nodes[indexPath.row]
        switch node.type {
        case "tree":
            cell.imageView?.image = UIImage(systemName: "folder")
            cell.textLabel?.text = node.path
            cell.accessoryType = .disclosureIndicator
        case "blob":
            cell.imageView?.image = UIImage(systemName: "doc.plaintext")
            cell.textLabel?.text = node.path
            cell.accessoryType = .none
        default:
            break
        }
        return cell
    }
}

extension TreeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = nodes[indexPath.row]
        switch node.type {
        case "tree":
            let treeViewController = TreeViewController(tree: .node(node: node))
            navigationController?.pushViewController(treeViewController, animated: true)
        case "blob":
            let blobViewController = BlobViewController(node: node)
            navigationController?.pushViewController(blobViewController, animated: true)
        default:
            break
        }
    }
}
