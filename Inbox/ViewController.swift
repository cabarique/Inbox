//
//  ViewController.swift
//  Inbox
//
//  Created by Luis Cabarique on 11/15/18.
//  Copyright © 2018 cabarique inc. All rights reserved.
//

import UIKit
import Then

class ViewController: UIViewController {

    private let cellIdentifier = "inboxCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIBarButtonItem(title: "⟳", style: .plain, target: self, action: #selector(self.selectRefresh)).do { bb in
            let font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            bb.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
            self.navigationItem.rightBarButtonItem = bb
        }
        
    }
    
    @objc private func selectRefresh() {
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = "inbox 1"
        return cell
    }
    
    
}

