//
//  Blob.swift
//  Repospect
//
//  Created by Leon Li on 2020/10/12.
//

import Foundation

struct Blob: Decodable {
    var sha: String
    var node_id: String
    var size: Int
    var url: URL
    var content: String
    var encoding: String
}
