//
//  NewsCell.swift
//  News
//
//  Created by Истина on 09/05/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {


    @IBOutlet weak var newsImage: UIImageView!    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var article: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
