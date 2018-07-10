//
//  TrainsVC.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 09/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import UIKit

class TrainsVC: SubView {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        SubmitBtn.layer.cornerRadius = SubmitBtn.frame.height/2
    }

    @IBAction func toggleCheckBox(_ sender: Any) {
        if checkBox.image(for: .normal) == #imageLiteral(resourceName: "if_check-box-outline-blank_326558.png") {
            checkBox.setImage(#imageLiteral(resourceName: "if_check-box_326563.png"), for: .normal)
        }else {
            checkBox.setImage(#imageLiteral(resourceName: "if_check-box-outline-blank_326558.png"), for: .normal)
        }
    }
    

}
