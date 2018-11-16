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

