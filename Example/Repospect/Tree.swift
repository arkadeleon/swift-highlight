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
