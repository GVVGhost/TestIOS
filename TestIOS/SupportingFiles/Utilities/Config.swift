//
//  Config.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation

class Config {
    static let shared = Config()
    
//    let scheme: String = "http"
//    let host: String = "192.168.31.185"
//    let port: Int = 4000
    let scheme: String? = Bundle.main.infoDictionary?["API_SCHEME"] as? String
    let host: String? = Bundle.main.infoDictionary?["API_HOST"] as? String
    let port: Int? = Bundle.main.infoDictionary?["API_PORT"] as? Int
}
