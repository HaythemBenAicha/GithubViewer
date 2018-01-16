//
//  RepositoryCell.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/16/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    
    // MARK: - Lifecycle Methodes
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
