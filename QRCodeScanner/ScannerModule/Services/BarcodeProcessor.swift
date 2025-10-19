//
//  BarcodeProcessor.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import Vision

protocol IBarcodeProcessor: AnyObject {
    func extractContent(from observations: [VNBarcodeObservation]) -> [String]
}

final class BarcodeProcessor: IBarcodeProcessor {
    func extractContent(from observations: [VNBarcodeObservation]) -> [String] {
        return observations
            .filter { $0.symbology == .qr }
            .compactMap { $0.payloadStringValue }
    }
}
