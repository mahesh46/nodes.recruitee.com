//
//  DetailViewController.swift
//  nodesAgency
//
//  Created by Administrator on 04/05/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

struct Detail {
    var nameText : String?
    var titleText : String?
    var ratingText: String?
}
class DetailViewController: UIViewController {
    var detail : Detail?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.nameLabel.text = detail?.nameText
        self.titleLabel.text = detail?.titleText
        self.ratingLabel.text = detail?.ratingText
        self.title  = "Description"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
