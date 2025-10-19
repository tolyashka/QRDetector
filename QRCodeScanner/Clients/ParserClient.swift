//
//  ParserClient.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 18.10.2025.
//

import Foundation

protocol ParserClient {
    func parseData<T: Decodable>(from jsonString: String) -> T?
    func parseData<T: Decodable>(from jsonData: Data) -> T?
}


final class JSONParserClient: ParserClient {
    private lazy var decoder = JSONDecoder()
    
    func parseData<T: Decodable>(from jsonString: String) -> T? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return parseData(from: data)
    }
    
    func parseData<T: Decodable>(from jsonData: Data) -> T? {
        try? decoder.decode(T.self, from: jsonData)
    }
}

