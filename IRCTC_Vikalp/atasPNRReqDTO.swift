//
//  atasPNRReqInfo.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 06/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class atasPnrEnqReqDTO :Codable {
    
    var pnrNumber : String = String()
    var trainNumber : String = String()
    var captchaAnswer :String = String()
    var tokenKey :String = String()
    
    
    private enum CodingKeys: String, CodingKey{
        
        case pnrNumber
        case captchaAnswer
        case trainNumber
        case tokenKey

    }
}
