//
//  UserModel.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/16/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation

struct UserModel: Decodable {
    let id: Int
    let name: String
    let username: String
    let phone: String
    let website: String
    let email: String
}
