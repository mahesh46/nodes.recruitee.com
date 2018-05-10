//
//  ResultTableViewCell.swift
//  nodesAgency
//
//  Created by Administrator on 04/05/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var resultCellImage: UIImageView!
    
    @IBOutlet weak var resultTitleCell: UILabel!
    
    @IBOutlet weak var resultDescriptionCell: UILabel!
    
    @IBOutlet weak var resultIdCell: UILabel!
    
    @IBOutlet weak var resultLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func likeButtonAction(_ sender: Any) {
        
        let datamanager = DataManager.sharedInstance
        if   datamanager.isLiked(id: self.tag)  {
            datamanager.deleteLike(id: self.tag)
            self.resultLikeButton.backgroundColor = UIColor.gray
        } else {
            let img = resultCellImage.image
            let data = UIImagePNGRepresentation(img!) as NSData?
            datamanager.saveLike(id: self.tag, title: self.resultTitleCell.text!, image : data! )
            self.resultLikeButton.backgroundColor = UIColor.blue
        }
    }
    
}
