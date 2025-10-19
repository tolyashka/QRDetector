//
//  FrameProcessor.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import ARKit

protocol IFrameProcessingService: AnyObject {
    func processPixelBuffer(_ pixelBuffer: CVPixelBuffer) async -> [String]
}

final class FrameProcessingService: IFrameProcessingService {
    private let detectionService: IQRCodeDetectionService
    private let contentFilter: IContentFilter
    
    init(detectionService: IQRCodeDetectionService, contentFilter: IContentFilter) {
        self.detectionService = detectionService
        self.contentFilter = contentFilter
    }
    
    func processPixelBuffer(_ pixelBuffer: CVPixelBuffer) async -> [String] {
        let contents = await detectionService.detectQRCode(in: pixelBuffer)
        return await contentFilter.filterValidContents(contents)
    }
}
