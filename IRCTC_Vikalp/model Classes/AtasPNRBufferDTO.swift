//
//  AtasPNRBuffer.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 17/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class AtasPNRBufferDTO : Codable{
    
    
    var fromStaion : String = ""
    var toStation : String = ""
    
    var trainNumber : String = ""
    var trainName : String = ""
    var pnrNumber : String = ""
    var journeyClass : String = ""
    var Otp : String = ""
    var OtpCount : String = ""
    var utilJourneyDate : String = ""
    var mobileNumber : String = ""
    
    
    
  
    
    private enum CodingKeys: String, CodingKey{
        case fromStaion
       case toStation

        case trainNumber
        case trainName
        case pnrNumber
       case journeyClass
        case Otp
        case OtpCount
        case utilJourneyDate
        case mobileNumber
      
        
    }
    
    
    
    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let temp = try container.decodeIfPresent(String.self, forKey: .fromStaion) {fromStaion = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .toStation) {toStation = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .trainName) {trainName = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .trainNumber) {trainNumber = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .journeyClass) {journeyClass = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .Otp) {Otp = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .OtpCount) {OtpCount = String(temp)}
        if let temp = try container.decodeIfPresent(String.self, forKey: .utilJourneyDate) {utilJourneyDate = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .mobileNumber) {mobileNumber = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .pnrNumber) {pnrNumber = String(temp)}
        
        //         if let temp = try container.decodeIfPresent(String.self, forKey: .journeyDate) {
        //            let dateFormatter = DateFormatter()
        //            dateFormatter.dateFormat = "MM-dd-yyyy"
        //            dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        //            journeyDate = dateFormatter.date(from: temp)! as NSDate
        //        }
        //
    }
}
