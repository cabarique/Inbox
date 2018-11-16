//
//  PostsViewModel.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/15/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostsViewModel {
    private var disposeBag = DisposeBag()
    
    //Subjects
    let posts = BehaviorRelay<[PostModel]>(value: [])
    let favoritePost = BehaviorRelay<[PostModel]>(value: [])
    
    var api = inboxAPI
    
    init() {
        self.updatePosts()
        self.posts
            .map{ $0.filter{$0.favorite}}
            .bind(to: favoritePost)
            .disposed(by: self.disposeBag)
    }
    
    /**
     Update posts
     */
    func updatePosts() {
        self.api.rx.request(.posts)
            .map([PostModel].self)
            .subscribe{ event in
                switch event {
                case .success(let model):
                    self.posts.accept(model)
                case .error(_):
                    //todo fetch from cache
                    break
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    /**
     Update post at index
     */
    func update(post: PostModel, at index: Int) {
        var _posts = self.posts.value
        _posts[index] = post
        self.posts.accept(_posts)
    }
    
    /**
     removes all posts
     */
    func removeAll() {
        self.posts.accept([])
    }
    
    /**
     removes post at index
    */
    func remove(at index: Int) {
        var _posts = self.posts.value
        _posts.remove(at: index)
        self.posts.accept(_posts)
    }
}
