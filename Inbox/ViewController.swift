//
//  ViewController.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/15/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import UIKit
import Then
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let cellIdentifier = "inboxCell"
    
    let viewModel = PostsViewModel()
    private var toogleFavorite = false {
        didSet{
            posts = toogleFavorite ? viewModel.favoritePost.value : viewModel.posts.value
        }
    }
    private var posts: [PostModel] = []
    
    //MARK: IBOutlets
    @IBOutlet weak var postsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIBarButtonItem(title: "⟳", style: .plain, target: self, action: #selector(self.selectRefresh)).do { bb in
            let font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            bb.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
            self.navigationItem.rightBarButtonItem = bb
        }
        self.rxBind()
    }
    
    @objc private func selectRefresh() {
        
    }
    
    private func rxBind(){
        self.viewModel.posts
            .subscribe(onNext: { posts in
                self.posts = self.toogleFavorite ? self.viewModel.favoritePost.value : posts
                self.postsTableView.reloadData()
        })
        .disposed(by: self.disposeBag)
    }
    
    @IBAction func tooglePostFavorites(_ sender: UISegmentedControl) {
        self.toogleFavorite = sender.selectedSegmentIndex == 0 ? false : true
        self.postsTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        let post = self.posts[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.attributedText = getTableText(for: post, at: indexPath.row)
        return cell
    }
    
    private func getTableText(for model: PostModel, at row: Int) -> NSMutableAttributedString{
        let unreadedAccesory = "•"
        let favoriteAccesory = "⭐"
        let attribute: NSMutableAttributedString
        if model.favorite {
            let text = favoriteAccesory + " " + model.title
            let range = (text as NSString).range(of: favoriteAccesory)
            attribute = NSMutableAttributedString(string: text)
            attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 25), range: range)
        }else if !model.favorite && !model.readed && row <= 20{
            let text = unreadedAccesory + " " + model.title
            let range = (text as NSString).range(of: unreadedAccesory)
            attribute = NSMutableAttributedString(string: text)
            attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: range)
            attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 25), range: range)
        }else{
            attribute = NSMutableAttributedString(string: model.title)
        }
        
        return attribute
    }
}

