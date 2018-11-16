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
import Realm
import RealmSwift

class PostsViewModel {
    private var disposeBag = DisposeBag()
    
    // Get the default Realm
    let realm: Realm
    
    //Subjects
    let posts = BehaviorRelay<[PostModel]>(value: [])
    let favoritePost = BehaviorRelay<[PostModel]>(value: [])
    
    var api = inboxAPI
    
    init() {
        do{
            realm = try Realm()
        }catch {
            fatalError("Enabled to launch realm")
        }
        
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
                    try? self.realm.write {
                        model.forEach { self.realm.add($0, update: true) }
                    }
                    self.posts.accept(model)
                case .error(_):
                    let posts = Array(self.realm.objects(PostModel.self))
                    self.posts.accept(posts)
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    /**
     Update post at index
     */
    func update(post: PostModel, at index: Int) {
        try? self.realm.write {
            self.realm.add(post, update: true)
        }
        var _posts = self.posts.value
        _posts[index] = post
        self.posts.accept(_posts)
    }
    
    /**
     removes all posts
     */
    func removeAll() {
        try? self.realm.write {
            self.realm.delete(self.posts.value)
        }
        self.posts.accept([])
    }
    
    /**
     removes post at index
    */
    func remove(at index: Int) {
        try? self.realm.write {
            self.realm.delete(self.posts.value[index])
        }
        var _posts = self.posts.value
        _posts.remove(at: index)
        self.posts.accept(_posts)
    }
}
