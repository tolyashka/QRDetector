//
//  QRCodeScannerApp.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 13.10.2025.
//

import SwiftUI

@main
struct QRCodeScannerApp: App {
    var body: some Scene {
        WindowGroup {
            let observer = ARSessionObserver()
            let arViewContainer = ARViewContainer(sessionObservable: observer)
            let framePublisher = observer.framePublisher
            let scannerCoordinator = ScannerFactory.createScanner()

            let viewModel = ScannerFactory.createViewModel(
                coordinator: scannerCoordinator,
                framePublisher: framePublisher
            )

            ScannerView(viewModel: viewModel, arConteiner: arViewContainer)
        }
    }
}
