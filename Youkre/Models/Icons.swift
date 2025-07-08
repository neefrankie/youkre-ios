//
//  Icons.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/8.
//

struct Icons: Codable {
    var sfSymbol: String? = nil
    var predefined: String? = nil
    var latex: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case sfSymbol = "sf_symbol"
        case predefined = "symbol_name"
        case latex = "latex"
    }
}
