//
//  CommentModel.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/16/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation

struct CommentModel: Decodable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
