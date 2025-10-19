//
//  ARSessionObserver.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 16.10.2025.
//

import Combine
import ARKit

fileprivate struct Configurator {
    static let delay = 300
    
    private init() { }
}

protocol ARSessionObservable: ObservableObject {
    var framePublisher: AnyPublisher<CVPixelBuffer, Never> { get }
    
    func send(_ frame: CVPixelBuffer)
}

final class ARSessionObserver {
    private let frameSubject = PassthroughSubject<CVPixelBuffer, Never>()
}

extension ARSessionObserver: ARSessionObservable {
    var framePublisher: AnyPublisher<CVPixelBuffer, Never> {
        frameSubject
            .throttle(for: .milliseconds(Configurator.delay),
                      scheduler: DispatchQueue.main, latest: true)
            .eraseToAnyPublisher()
    }
    
    func send(_ frame: CVPixelBuffer) {
        frameSubject.send(frame)
    }
}

