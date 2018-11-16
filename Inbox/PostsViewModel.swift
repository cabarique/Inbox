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
    
    var api = inboxAPI
    
    init() {
        self.updatePosts()
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
