//
//  AtasTrainEnqRespDTO.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 17/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class AtasTrainEnqRespDTO : Codable {
    var  atasPnrBuffer : AtasPNRBufferDTO?
    var atasTrainList : AtasTrainListDTO?

    private enum CodingKeys: String, CodingKey{
        case atasPnrBuffer
        case atasTrainList
    }

    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let temp = try container.decodeIfPresent(AtasPNRBufferDTO.self, forKey: .atasPnrBuffer) { atasPnrBuffer = temp
        }
       
        if let temp = try container.decodeIfPresent(AtasTrainListDTO.self, forKey: .atasTrainList) {atasTrainList = temp}

    }
}
