//
//  Bundle-Decodable.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/11.
//

import Foundation

enum JSONError: LocalizedError {
    case fileReadFailed(String)
    case decodingFailed(String)
    case convertDataFailed
    
    var errorDescription: String? {
        switch self {
        case .fileReadFailed(let message):
            print(message)
            return "文件读取失败"
        case .decodingFailed(let message):
            print(message)
            return "JSON解析错误"
        case .convertDataFailed:
            return "无法转换为Data"
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
    
    var dbPath: String? {
        self.webAssetsBundle?.path(forResource: "db_v1", ofType: "sqlite3", inDirectory: "db")
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
    
    func decode<T: Codable>(contentsOf url: URL) -> Result<T, JSONError> {
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
    
    func decodeToc(of project: String) async -> Result<TableOfContents, JSONError> {
        guard let fileURL = self.jsonURL(forResource: "toc", of: project) else {
            return .failure(.fileReadFailed("Failed to find toc.json of \(project)"))
        }
        
        print("Parse JSON file \(fileURL)")
        
        return self.decode(contentsOf: fileURL)
    }
}

class JSONParser {
    static func parse<T: Decodable>(data: Data, as type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
    
    static func decode<T: Codable>(data: Data) -> Result<T, JSONError> {
        let decoder = JSONDecoder()
                
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
            
        } catch DecodingError.keyNotFound(let key, let context) {
            return .failure(.decodingFailed("keyNotFound: missing key '\(key.stringValue)' – \(context.debugDescription)"))
        } catch DecodingError.typeMismatch(_, let context) {
            return .failure(.decodingFailed("typeMismatch: type mismatch – \(context.debugDescription)"))
        } catch DecodingError.valueNotFound(let type, let context) {
            return .failure(.decodingFailed("valueNotFound: \(type) value – \(context.debugDescription)"))
        } catch DecodingError.dataCorrupted(_) {
            return .failure(.decodingFailed("dataCorrupted: Failed to decode because it appears to be invalid JSON."))
        } catch {
            return .failure(.decodingFailed("Failed to decode: \(error.localizedDescription)"))
        }
    }
}
