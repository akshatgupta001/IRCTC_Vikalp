//
//  SubView.swift
//  screens
//
//  Created by Akshat Gupta on 14/06/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import UIKit


class SubView: UIViewController {
    private let label = UILabel()
    
   public func setTitle(title : String){
        self.label.text = title.uppercased()
        self.label.sizeToFit()
    
    
    
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0/255.0, green: 150/255.0, blue: 177/255.0, alpha: 1)


        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        addBar()
        self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let cris = UIImageView(image: #imageLiteral(resourceName: "cris_logo_blue"))
        cris.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let logo = UIView()
        logo.backgroundColor = UIColor.white
        logo.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        logo.layer.cornerRadius = logo.frame.size.width/2
        logo.clipsToBounds = true
        
        logo.addSubview(cris)
        cris.center = logo.center
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logo)
        
       
        
        let irctc = UIImageView(image: #imageLiteral(resourceName: "irctc_logo_white_bg"))
        irctc.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let logo1 = UIView()
        logo1.backgroundColor = UIColor.white
        logo1.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        logo1.layer.cornerRadius = logo.frame.size.width/2
        logo1.clipsToBounds = true
        logo1.addSubview(irctc)
        irctc.center = logo1.center
        
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo1)
        
       // navigationItem.leftBarButtonItems =  [UIBarButtonItem(customView: irctc)]
        
        self.navigationItem.leftItemsSupplementBackButton = true

    }
    func dis(){
        print("123")
        

    }
    
    func addBar(){
        if self.navigationController == nil {
            return
        }
        self.label.textAlignment = .center
        label.textColor = UIColor.white
      
        label.text = "OPT VIKALP"
        
        label.sizeToFit()
        
        label.textAlignment = NSTextAlignment.center
        
        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = label
    }
  

}
