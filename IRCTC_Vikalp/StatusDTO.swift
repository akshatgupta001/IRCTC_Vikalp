//
//  File.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 06/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class StatusDTO : Codable {
    
    
    var errorFlag : Bool = false
    var errorMsg : String = ""
   //var journeyDate : NSDate
    
    private enum CodingKeys: String, CodingKey{
        case errorFlag
        case errorMsg
        //case journeyDate
    }
    
    init(){
        errorFlag = false
        errorMsg = ""
       // journeyDate = NSDate()
    }
    
    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
              if let temp = try container.decodeIfPresent(String.self, forKey: .errorMsg) {errorMsg = String(temp)}
        
        if let temp = try container.decodeIfPresent(String.self, forKey: .errorFlag) {errorFlag = Bool(temp)!}
       
//         if let temp = try container.decodeIfPresent(String.self, forKey: .journeyDate) {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM-dd-yyyy"
//            dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
//            journeyDate = dateFormatter.date(from: temp)! as NSDate
//        }
//
        }
    }

