//
//  ScannerCoordinator.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import ARKit
import Combine

protocol IScannerCoordinator: AnyObject {
    var contentPublisher: AnyPublisher<String, Never> { get }
    func process(pixelBuffer: CVPixelBuffer)
}

final class ScannerCoordinator: IScannerCoordinator {
    var contentPublisher: AnyPublisher<String, Never> {
        contentSubject.eraseToAnyPublisher()
    }
    
    private let contentSubject = PassthroughSubject<String, Never>()
    private let processingService: IFrameProcessingService
    
    init(processingService: IFrameProcessingService) {
        self.processingService = processingService
    }
    
    func process(pixelBuffer: CVPixelBuffer) {
        Task {
            let contents = await processingService.processPixelBuffer(pixelBuffer)
            await MainActor.run {
                for content in contents {
                    contentSubject.send(content)
                }
            }
        }
    }
}
