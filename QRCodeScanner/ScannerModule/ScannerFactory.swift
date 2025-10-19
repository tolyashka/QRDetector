//
//  ScannerFactory.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import Foundation
import Combine
import ARKit

struct ScannerFactory {
    private static let parserClient = JSONParserClient()
    
    static func createScanner() -> IScannerCoordinator {
        let imageConverter = ImageConverter()
        let barcodeDetector = BarcodeDetector()
        let barcodeProcessor = BarcodeProcessor()

        let detectionService = QRCodeDetectionService(
            imageConverter: imageConverter,
            barcodeDetector: barcodeDetector,
            barcodeProcessor: barcodeProcessor
        )

        let validator = ValidatorService()
        let contentFilter = ContentFilter(validator: validator)
        let frameProcessingService = FrameProcessingService(
            detectionService: detectionService,
            contentFilter: contentFilter
        )

        return ScannerCoordinator(processingService: frameProcessingService)
    }
    
    static func createViewModel(
        coordinator: IScannerCoordinator,
        framePublisher: AnyPublisher<CVPixelBuffer, Never>
    ) -> ScannerViewModel {
        let parserService = JSONParserService(parserClient: parserClient)

        return ScannerViewModel(
            scannerCoordinator: coordinator,
            jsonParser: parserService,
            framePublisher: framePublisher
        )
    }
}
