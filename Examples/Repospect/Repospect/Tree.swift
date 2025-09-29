//
//  Tree.swift
//  Repospect
//
//  Created by Leon Li on 2020/10/12.
//

import Foundation

struct Tree: Decodable {

    struct Node: Decodable {
        var path: String
        var mode: String
        var type: String
        var sha: String
        var url: URL
    }

    var sha: String
    var url: URL
    var tree: [Node]
    var truncated: Bool
}

extension Tree.Node: Comparable {

    static func < (lhs: Tree.Node, rhs: Tree.Node) -> Bool {
        (lhs.typeRank, lhs.path) < (rhs.typeRank, rhs.path)
    }

    var typeRank: Int {
        switch type {
        case "tree": 0
        case "blob": 1
        default: 2
        }
    }
}
