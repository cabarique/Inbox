//
//  InboxAPI.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/15/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation
import Moya

var inboxAPI = MoyaProvider<inboxEndPoints>(plugins: [CachePolicyPlugin()])
private let kURL = "https://jsonplaceholder.typicode.com/"

enum inboxEndPoints {
    case posts
    case post(Int)
    case comments(Int)
    case user(Int)
}

extension inboxEndPoints: TargetType {
    var baseURL: URL {
        return URL(string: kURL)!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        case .post(let id):
            return "posts/\(id)"
        case .comments:
            return "comments"
        case .user(let id):
            return "users/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "".data(using: String.Encoding.utf8)!
        }
        
    }
    
    var task: Task {
        switch self {
        case .posts,
             .post,
             .user:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .comments(let id):
            return .requestParameters(parameters: ["postId": id], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}


protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

final class CachePolicyPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}

extension inboxEndPoints: CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy {
        return .returnCacheDataElseLoad
    }
}
