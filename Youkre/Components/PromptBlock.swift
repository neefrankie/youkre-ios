//
//  PromptBlock.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/7/14.
//

// [
//  { "type": "text", "value": "Welcome" },
//  { "type": "latex", "value": "x^2 + y^2 = z^2" },
//  { "type": "image", "value": "cat" },
//  { "type": "table", "table": { "data": ["A", "B", "C"], rows: 2, cols: null } },
//  { "type": "bullet", "value": "Item 1" },
//  { "type": "newline" }
// ]
enum PromptBlock: Codable, Hashable {
    case text(String)
    case latex(String)
    case image(String)
    case table(GridTable)
    case bullet(String)
    case newline
    
    private enum CodingKeys: String, CodingKey {
        case kind
        case value
        case table
    }
    
    private enum BlockType: String, Codable {
        case text
        case latex
        case image
        case table
        case bullet
        case newline
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .text(let value):
            try container.encode(BlockType.text, forKey: .kind)
            try container.encode(value, forKey: .value)
        
        case .latex(let value):
            try container.encode(BlockType.latex, forKey: .kind)
            try container.encode(value, forKey: .value)
            
        case .image(let value):
            try container.encode(BlockType.image, forKey: .kind)
            try container.encode(value, forKey: .value)
            
        case .table(let table):
            try container.encode(BlockType.table, forKey: .kind)
            try container.encode(table, forKey: .table)
            
        case .bullet(let value):
            try container.encode(BlockType.bullet, forKey: .kind)
            try container.encode(value, forKey: .value)
            
        case .newline:
            try container.encode(BlockType.newline, forKey: .kind)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(BlockType.self, forKey: .kind)
        
        switch type {
        case .text:
            let value = try container.decode(String.self, forKey: .value)
            self = .text(value)
            
        case .latex:
            let value = try container.decode(String.self, forKey: .value)
            self = .latex(value)
            
        case .image:
            let name = try container.decode(String.self, forKey: .value)
            self = .image(name)
            
        case .table:
            let table = try container.decode(GridTable.self, forKey: .table)
            self = .table(table)
            
        case .bullet:
            let value = try container.decode(String.self, forKey: .value)
            self = .bullet(value)
            
        case .newline:
            self = .newline
        }
    }
}
