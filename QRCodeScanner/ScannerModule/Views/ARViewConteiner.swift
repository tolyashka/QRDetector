//
//  ARViewConteiner.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 13.10.2025.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ARViewContainer {
    class Coordinator: NSObject, ARSessionDelegate {
        weak var sessionObservable: ARSessionObserver?

        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            sessionObservable?.send(frame.capturedImage)
        }
    }
    
    @ObservedObject var sessionObservable: ARSessionObserver

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        guard ARWorldTrackingConfiguration.isSupported else { return arView }

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]

        arView.session.delegate = context.coordinator
        context.coordinator.sessionObservable = sessionObservable
        arView.session.run(configuration)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
