//
//  PostViewModel.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/16/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import Foundation
import RxSwift

class PostViewModel {
    private var disposeBag = DisposeBag()
    var api = inboxAPI
    
    let post: PostModel
    
    //Subjects
    fileprivate let commentsSubject = ReplaySubject<[CommentModel]>.create(bufferSize: 1)
    fileprivate let userSubject = ReplaySubject<UserModel>.create(bufferSize: 1)
    let favoriteSelected = PublishSubject<Bool>()
    
    init(post: PostModel) {
        self.post = post
        
        self.api.rx.request(.comments(post.id))
            .map([CommentModel].self).debug("**")
            .subscribe { event in
                switch event {
                case .success(let comments):
                    self.commentsSubject.onNext(comments)
                case .error(_):
                    break
                }
            }
        .disposed(by: self.disposeBag)
        
        self.api.rx.request(.user(post.userId))
            .map(UserModel.self).debug("++")
            .subscribe { event in
                switch event {
                case .success(let userModel):
                    self.userSubject.onNext(userModel)
                case .error(_):
                    break
                }
            }
            .disposed(by: self.disposeBag)
    }
    
}

extension PostViewModel {
    var commentsObservable: Observable<[CommentModel]> {
        return self.commentsSubject.asObserver()
    }
    
    var userModelObservable: Observable<UserModel> {
        return self.userSubject.asObserver()
    }
}
