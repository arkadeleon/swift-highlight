//
//  Branch.swift
//  Repospect
//
//  Created by Leon Li on 2020/10/12.
//

struct Branch: Decodable {

    struct Commit: Decodable {
        var sha: String
        var url: String
    }

    var name: String
    var commit: Commit
    var protected: Bool
}
