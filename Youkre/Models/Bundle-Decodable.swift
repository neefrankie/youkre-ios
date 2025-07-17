//
//  Bundle-Decodable.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/11.
//

import Foundation

enum JSONParsingError: LocalizedError {
    case fileReadFailed(String)
    case decodingFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .fileReadFailed(let message):
            return "文件读取失败"
        case .decodingFailed(let message):
            return "JSON解析错误"
        }
    }
}

struct HTMLFile {
    let fileURL: URL
    let readAccessURL: URL
}

extension Bundle {
    var webAssetsBundle: Bundle? {
        if let webAssetsBundleURL = self.url(
            forResource: "WebAssets",
            withExtension: "bundle"
        ) {
            return Bundle(url: webAssetsBundleURL)
        }
        
        return nil
    }
    
    func jsonURL(forResource name: String, of subpath: String) -> URL? {
        return self.webAssetsBundle?.url(
            forResource: name,
            withExtension: "json",
            subdirectory: subpath
        )
    }
    
    func htmlURL(forResource name: String, of subpath: String) -> HTMLFile? {
        if let bundle = self.webAssetsBundle {
            if let fileURL = bundle.url(
                forResource: name,
                withExtension: "html",
                subdirectory: subpath
            ) {
                return HTMLFile(
                    fileURL: fileURL,
                    readAccessURL: bundle.bundleURL
                )
            }
        }
        
        return nil
    }
    
    func decode<T: Codable>(contentsOf url: URL) -> Result<T, JSONParsingError> {
        guard let data = try? Data(contentsOf: url) else {
            return .failure(.fileReadFailed("cannot load content from \(url)"))
        }
        
        let decoder = JSONDecoder()
                
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            return .failure(.decodingFailed("keyNotFound: Failed to decode \(url) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)"))
        } catch DecodingError.typeMismatch(_, let context) {
            return .failure(.decodingFailed("typeMismatch: Failed to decode \(url) from bundle due to type mismatch – \(context.debugDescription)"))
        } catch DecodingError.valueNotFound(let type, let context) {
            return .failure(.decodingFailed("valueNotFound: Failed to decode \(url) from bundle due to missing \(type) value – \(context.debugDescription)"))
        } catch DecodingError.dataCorrupted(_) {
            return .failure(.decodingFailed("dataCorrupted: Failed to decode \(url) from bundle because it appears to be invalid JSON."))
        } catch {
            return .failure(.decodingFailed("Failed to decode \(url) from bundle: \(error.localizedDescription)"))
        }
    }
    
//    func decodeBook(of project: String) async -> Result<Book, JSONParsingError> {
//        guard let fileURL = self.jsonURL(forResource: "book", of: project) else {
//            return .failure(.fileReadFailed("Failed to find book.json of \(project)"))
//        }
//        
//        print("Decode JSON file \(fileURL)")
//        
//        return self.decode(contentsOf: fileURL)
//    }
    
    func decodeToc(of project: String) async -> Result<TableOfContents, JSONParsingError> {
        guard let fileURL = self.jsonURL(forResource: "toc", of: project) else {
            return .failure(.fileReadFailed("Failed to find toc.json of \(project)"))
        }
        
        print("Parse JSON file \(fileURL)")
        
        return self.decode(contentsOf: fileURL)
    }
}

enum JSONError: Error {
    case fileNotFound(String)
    case invalidFilePath(String)
}

class JSONParser {
    static let baseURL = Bundle.main.resourceURL?.appendingPathComponent("WebAssets.bundle")
    
    static func jsonURL(forResource dir: String, _ fileName: String) -> URL? {
        return baseURL?
            .appendingPathComponent(dir)
            .appendingPathComponent(fileName)
            .appendingPathExtension("json")
    }
    
    static func htmlURL(forResource dir: String, fileName: String) -> URL? {
        return baseURL?
            .appendingPathComponent(dir)
            .appendingPathComponent(fileName)
            .appendingPathExtension("html")
    }
    
    static func parse<T: Decodable>(data: Data, as type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
    
    static func parseToc(of project: String) async throws -> TableOfContents {
        guard let fileURL = jsonURL(forResource: project, "toc")
        else {
            throw JSONError.fileNotFound("未能找到JSON文件")
        }
        print("Try to load file \(fileURL)")
        let data = try Data(contentsOf: fileURL)
        print("Loaded data \(data)")
        return try parse(data: data, as: TableOfContents.self)
    }
}
