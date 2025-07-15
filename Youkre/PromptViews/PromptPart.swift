//
//  PromptPart.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/10.
//

enum PromptPart: Codable, Hashable {
    case text(String)
    case latex(String)
    
    private enum CodingKeys: String, CodingKey {
        case type, value
    }
    
    private enum PartType: String, Codable {
        case text, latex
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .text(let value):
            try container.encode(PartType.text, forKey: .type)
            try container.encode(value, forKey: .value)
        case .latex(let value):
            try container.encode(PartType.latex, forKey: .type)
            try container.encode(value, forKey: .value)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(PartType.self, forKey: .type)
        let value = try container.decode(String.self, forKey: .value)
        switch type {
        case .text:
            self = .text(value)
        case .latex:
            self = .latex(value)
        }
    }
}
