//
//  InfoPanel.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 13.10.2025.
//

import SwiftUI
import ARKit
import SwiftUI
import ARKit
import Combine

struct ScannerView<ViewModel: IScannerViewModel & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    
    private let arConteiner: ARViewContainer
    
    init(viewModel: ViewModel, arConteiner: ARViewContainer) {
        self.viewModel = viewModel
        self.arConteiner = arConteiner
    }

    var body: some View {
        ZStack {
            arConteiner
                .ignoresSafeArea()

            VStack {
                statusView
                Spacer()
                scanFrameView
                Spacer()

                if let schedule = viewModel.scheduleContent {
                    ScheduleTableView(schedule: schedule)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                }

                if viewModel.detectedContent != nil {
                    Button("Очистить") {
                        viewModel.resetDetection()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }

    // MARK: - Subviews
    private var statusView: some View {
        VStack(spacing: 8) {
            Text("Сканирование QR-кодов...")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
        }
        .padding()
    }

    private var scanFrameView: some View {
        ZStack {
            Rectangle()
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 250, height: 250)
                .background(Color.black.opacity(0.3))

            Text("Наведите на QR код")
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(4)
                .offset(y: 140)
        }
    }
}
