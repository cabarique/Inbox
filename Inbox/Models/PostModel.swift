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
    let readed: Bool
    let favorite: Bool
    
    init(id: Int, userId: Int, title: String, body: String, favorite: Bool = false, readed: Bool = false) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.readed = readed
        self.favorite = favorite
    }
    
    enum Keys: String, CodingKey { // declaring our keys
        case id
        case userId
        case title
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let userId = try container.decode(Int.self, forKey: .userId)
        let title = try container.decode(String.self, forKey: .title)
        let body = try container.decode(String.self, forKey: .body)
        self.init(id: id, userId: userId, title: title, body: body, favorite: false, readed: false)
    }
}
