//
//  AtasTrainList.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 17/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class AtasTrainListDTO : Codable{
    var maxNoOfVikalpTrains : String?
    var trainBtwnStnsList : [TrainBtwnStnsDTO]?
    private enum CodingKeys: String, CodingKey{
        case maxNoOfVikalpTrains
        case trainBtwnStnsList
    }
    
    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let temp = try container.decodeIfPresent(String.self, forKey: .maxNoOfVikalpTrains) { maxNoOfVikalpTrains = temp
        }
        
        if let temp = try container.decodeIfPresent(TrainBtwnStnsDTO.self, forKey: .trainBtwnStnsList) {trainBtwnStnsList = [temp]}
        
    }
}
