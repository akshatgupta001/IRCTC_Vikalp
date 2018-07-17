//
//  TableViewCell.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 12/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var TrainName: UILabel!
    @IBOutlet weak var TrainNumber: UILabel!
    
    @IBOutlet weak var fromStnCode: UILabel!
    @IBOutlet weak var toStnCode: UILabel!
    @IBOutlet weak var journeyDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
        
        
        // Configure the view for the selected state
    }
    func commonInit(){
        checkBox.image = #imageLiteral(resourceName: "if_check-box-outline-blank_326558")
    }
}

/// select date for viaklp trains
//dd-mon-yyyy
