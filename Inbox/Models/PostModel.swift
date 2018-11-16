//
//  PostModel.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/15/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class PostModel: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var readed: Bool = false
    @objc dynamic var favorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, userId: Int, title: String, body: String, favorite: Bool = false, readed: Bool = false) {
        self.init()
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.readed = readed
        self.favorite = favorite
    }
    
    private enum Keys: String, CodingKey { // declaring our keys
        case id
        case userId
        case title
        case body
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let userId = try container.decode(Int.self, forKey: .userId)
        let title = try container.decode(String.self, forKey: .title)
        let body = try container.decode(String.self, forKey: .body)
        self.init(id: id, userId: userId, title: title, body: body, favorite: false, readed: false)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
