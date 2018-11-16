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
}
