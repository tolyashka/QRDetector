//
//  ImageConverter.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 14.10.2025.
//

import CoreImage

protocol IImageConverter: AnyObject {
    func convertToCIImage(from pixelBuffer: CVPixelBuffer) -> CIImage
}

final class ImageConverter: IImageConverter {
    func convertToCIImage(from pixelBuffer: CVPixelBuffer) -> CIImage {
        return CIImage(cvPixelBuffer: pixelBuffer)
    }
}
