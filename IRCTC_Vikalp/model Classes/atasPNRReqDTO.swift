//
//  atasPNRReqInfo.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 06/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class AtasPnrEnqReqDTO :Codable {
    
    var pnrNumber : String = ""
    var trainNumber : String = ""
    var captchaAnswer :String = ""
    var tokenKey :String = ""
    
    private enum CodingKeys: String, CodingKey{
        
        case pnrNumber
        case captchaAnswer
        case trainNumber
        case tokenKey

    }
}
