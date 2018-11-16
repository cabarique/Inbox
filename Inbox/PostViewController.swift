//
//  PostViewController.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/16/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostViewController: UIViewController {
    let kTableCellIdentifier = "commentsCell"
    //MARK: IBOutlets
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var commentsTableView: UITableView!
    
    private(set) var viewModel: PostViewModel!
    private(set) var comments = BehaviorRelay<[CommentModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard (viewModel != nil) else { fatalError("call setviewModel: before presenting")}
        self.commentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableCellIdentifier)
        self.descriptionTextLabel.text = self.viewModel.post.body
        self.rxBind()
    }
    
    func set(viewModel: PostViewModel) {
        self.viewModel = viewModel
    }

    private func rxBind(){
        self.viewModel
            .userModelObservable
            .asDriver(onErrorDriveWith: Driver.never())
            .drive(onNext: { userModel in
                self.nameLabel.text = userModel.name
                self.phoneLabel.text = userModel.phone
                self.emailLabel.text = userModel.email
                self.websiteLabel.text = userModel.website
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.commentsObservable
            .bind(to: self.comments)
            .disposed(by: self.disposeBag)
        
        self.comments.bind(onNext: { _ in
            self.commentsTableView.reloadData()
        })
        .disposed(by: self.disposeBag)
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableCellIdentifier, for: indexPath)
        let comment = self.comments.value[indexPath.row]
        cell.textLabel?.text = comment.body
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
}
