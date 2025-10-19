//
//  JSONParserService.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 16.10.2025.
//

import Foundation


protocol ParserService: AnyObject {
    func parseSchedule(from jsonString: String) -> ScheduleContent?
    func parseSchedule(from jsonData: Data) -> ScheduleContent?
}

final class JSONParserService: ParserService {
    private let parserClient: any ParserClient
    
    init(parserClient: any ParserClient) {
        self.parserClient = parserClient
    }
    
    func parseSchedule(from jsonString: String) -> ScheduleContent? {
        let data: ScheduleContent? = parserClient.parseData(from: jsonString)
        return data
    }

    func parseSchedule(from jsonData: Data) -> ScheduleContent? {
        let data: ScheduleContent? = parserClient.parseData(from: jsonData)
        return data
    }
}
