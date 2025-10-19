//
//  QRCodeDetectionService.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import Vision

protocol IQRCodeDetectionService: AnyObject {
    func detectQRCode(in pixelBuffer: CVPixelBuffer) async -> [String]
}

final class QRCodeDetectionService: IQRCodeDetectionService {
    private let imageConverter: IImageConverter
    private let barcodeDetector: IBarcodeDetector
    private let barcodeProcessor: IBarcodeProcessor
    
    init(
        imageConverter: IImageConverter,
        barcodeDetector: IBarcodeDetector,
        barcodeProcessor: IBarcodeProcessor
    ) {
        self.imageConverter = imageConverter
        self.barcodeDetector = barcodeDetector
        self.barcodeProcessor = barcodeProcessor
    }
    
    func detectQRCode(in pixelBuffer: CVPixelBuffer) async -> [String] {
        do {
            let ciImage = imageConverter.convertToCIImage(from: pixelBuffer)
            let observations = try await barcodeDetector.detection(on: ciImage)
            return barcodeProcessor.extractContent(from: observations)
        } catch {
            return []
        }
    }
}
