//
//  ScheduleTableBuilder.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 16.10.2025.
//

import Foundation
// TEST 
protocol IScheduleTableBuilder: AnyObject {
    func buildTable(from content: ScheduleContent) -> [DayColumn]
}

struct DayColumn {
    let dayName: String
    let lessons: [ScheduleContent.Element]
}

final class ScheduleTableBuilder: IScheduleTableBuilder {
    func buildTable(from content: ScheduleContent) -> [DayColumn] {
        guard let firstRoom = content.rooms.first else { return [] }
        let schedule = firstRoom.schedule

        return [
            DayColumn(dayName: "Понедельник", lessons: schedule.monday),
            DayColumn(dayName: "Вторник", lessons: schedule.tuesday),
            DayColumn(dayName: "Среда", lessons: schedule.wednesday),
            DayColumn(dayName: "Четверг", lessons: schedule.thursday),
            DayColumn(dayName: "Пятница", lessons: schedule.friday),
            DayColumn(dayName: "Суббота", lessons: schedule.saturday),
            DayColumn(dayName: "Воскресенье", lessons: schedule.sunday)
        ]
    }
}
