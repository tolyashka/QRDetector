//
//  ScheduleTableView.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 17.10.2025.
//

import SwiftUI

struct ScheduleTableView: View {
    let schedule: ScheduleContent
    private let builder = ScheduleTableBuilder()

    var body: some View {
        let table = builder.buildTable(from: schedule)

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(table, id: \.dayName) { day in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(day.dayName)
                            .font(.headline)

                        if day.lessons.isEmpty {
                            Text("Нет занятий")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        } else {
                            ForEach(day.lessons, id: \.time) { lesson in
                                VStack(alignment: .leading) {
                                    Text("\(lesson.time) — \(lesson.subject)")
                                        .font(.subheadline)
                                    Text("\(lesson.teacher) (\(lesson.group))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding()
    }
}
