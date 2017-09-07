//
//  NewsTableViewCell.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import UIKit
import ViewModel

class NewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textLabel?.numberOfLines = 0;
        self.selectionStyle = .none
    }

    func bind(_ viewModel:NewsItemViewModel) {
        self.textLabel?.text = viewModel.title
    }
}
