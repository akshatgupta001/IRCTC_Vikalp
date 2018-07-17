//
//  TrainBtwnStnsDTO.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 12/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class TrainBtwnStnsDTO : Codable {
    //private static final long serialVersionUID = 1L;
    var sNo : Int?
    var trainNumber : String?
    var trainName : String?
    var fromStnCode : String?
    var toStnCode : String?
    var arrivalTime : String?
    var departureTime : String?
    var distance : String?
    var duration : String?
//    var runningMon : String
//    var  runningTue : String
//    var runningWed : String
//    var runningThu : String
//    var runningFri : String
//    var runningSat : String
//    var runningSun : String
//    var avlClasses : [String]
//    var trainType : String
   var departureDate : String?
   var  journeyDate : String?
//    var startingDate : Date
  //  var atasOpted : String


    
    private enum CodingKeys: String, CodingKey{
        case sNo
        case arrivalTime
        case trainNumber
        case trainName
        case fromStnCode
        case toStnCode
        case departureTime
        case distance
        case duration
        case departureDate
        case journeyDate
    }
    
    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let temp = try container.decodeIfPresent(String.self, forKey: .sNo) {sNo = Int(temp)!}
        if let temp = try container.decodeIfPresent(String.self, forKey: .trainNumber) {trainNumber = String(temp)}
        if let temp = try container.decodeIfPresent(String.self, forKey: .trainName) {trainName = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .fromStnCode) {fromStnCode = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .toStnCode) {toStnCode = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .departureTime) {departureTime = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .distance) {distance = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .duration) {duration = String(temp)}
         if let temp = try container.decodeIfPresent(String.self, forKey: .departureDate) {departureDate = String(temp)}
        if let temp = try container.decodeIfPresent(String.self, forKey: .journeyDate) {journeyDate = String(temp)}

        if let temp = try container.decodeIfPresent(String.self, forKey: .arrivalTime) {arrivalTime = String(temp)}

        
    }
    
}
