//
//  ContentValidator.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import Foundation

protocol IValidatorService {
    func isValid(_ content: String) async -> Bool
}

final class ValidatorService: IValidatorService {
    func isValid(_ content: String) async -> Bool {
        return true
    }
}
