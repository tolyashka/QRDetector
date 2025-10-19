//
//  ScannerViewModel.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 13.10.2025.
//

import ARKit
import Combine

protocol IScannerViewModel: ObservableObject {
    var detectedContent: String? { get }
    var scheduleContent: ScheduleContent? { get }
    
    func processPixelBuffer(_ pixelBuffer: CVPixelBuffer)
    func resetDetection()
}


final class ScannerViewModel: IScannerViewModel {
    @Published private(set) var detectedContent: String?
    @Published private(set) var scheduleContent: ScheduleContent?
    
    private let scannerCoordinator: IScannerCoordinator
    private let jsonParser: ParserService
    private var cancellables = Set<AnyCancellable>()
    private let framePublisher: AnyPublisher<CVPixelBuffer, Never>
    
    init(
        scannerCoordinator: IScannerCoordinator,
        jsonParser: ParserService,
        framePublisher: AnyPublisher<CVPixelBuffer, Never>
    ) {
        self.scannerCoordinator = scannerCoordinator
        self.jsonParser = jsonParser
        self.framePublisher = framePublisher
        setupBindings()
    }
    
    func processPixelBuffer(_ pixelBuffer: CVPixelBuffer) {
        scannerCoordinator.process(pixelBuffer: pixelBuffer)
    }
    
    func resetDetection() {
        detectedContent = nil
        scheduleContent = nil
    }
    
    private func setupBindings() {
        scannerCoordinator.contentPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] content in
                self?.detectedContent = content
                self?.scheduleContent = self?.jsonParser.parseSchedule(from: content)
            }
            .store(in: &cancellables)
        
        framePublisher
            .sink { [weak self] pixelBuffer in
                self?.processPixelBuffer(pixelBuffer)
            }
            .store(in: &cancellables)
    }
}
