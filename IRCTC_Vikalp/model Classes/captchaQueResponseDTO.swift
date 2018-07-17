//
//  captchaQueRespponseDTO.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 06/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import Foundation
class captchaQueResponseDTO : Codable {
    public var captchaQuestion : String = String()
    public var captchaToken : String = String()
    public var captchaGenTime : CLong = CLong()
    
    
    private enum CodingKeys: String, CodingKey{
        
        case captchaQuestion
        case captchaToken
        case captchaGenTime
        
    }
    init() {
        captchaQuestion = String()
        captchaToken = String()
        captchaGenTime = CLong()
    }
    
   
    required init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let temp = try container.decodeIfPresent(String.self, forKey: .captchaQuestion) {captchaQuestion = String(temp)}
        if let temp = try container.decodeIfPresent(String.self, forKey: .captchaToken) {captchaToken = String(temp)}
        if let temp = try container.decodeIfPresent(String.self, forKey: .captchaGenTime) {captchaGenTime = CLong(temp)!}
    }
    
    
}
