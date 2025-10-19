//
//  QRCodeDetector.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import Combine
import Vision
import ARKit
import CoreImage

protocol IBarcodeDetector: AnyObject {
    func detection(on image: CIImage) async throws -> [VNBarcodeObservation]
}

final class BarcodeDetector: IBarcodeDetector {
    private lazy var request: VNDetectBarcodesRequest = {
        let request = VNDetectBarcodesRequest()
        request.symbologies = [.qr]
        return request
    }()

    func detection(on image: CIImage) async throws -> [VNBarcodeObservation] {
        let handler = VNImageRequestHandler(ciImage: image)
        try handler.perform([request])
        return request.results ?? []
    }
}
