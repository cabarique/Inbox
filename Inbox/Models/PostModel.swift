//
//  PostModel.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/15/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation

struct PostModel: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    let readed: Bool = false
    let favorite: Bool = false
}
