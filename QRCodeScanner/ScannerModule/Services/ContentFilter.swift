//
//  ContentFilter.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import Foundation

protocol IContentFilter: AnyObject {
    func filterValidContents(_ contents: [String]) async -> [String]
}

final class ContentFilter: IContentFilter {
    private let validator: IValidatorService
    
    init(validator: IValidatorService) {
        self.validator = validator
    }
    
    func filterValidContents(_ contents: [String]) async -> [String] {
        var validContents: [String] = []
        for content in contents {
            if await validator.isValid(content) {
                validContents.append(content)
            }
        }
        return validContents
    }
}
