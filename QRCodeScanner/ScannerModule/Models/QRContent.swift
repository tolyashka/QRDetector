//
//  QRContent.swift
//  QRCodeScanner
//
//  Created by Анатолий Лушников on 13.10.2025.
//

struct ScheduleContent: Decodable {
    struct Element: Decodable {
        let time: String
        let subject: String
        let type: String
        let teacher: String
        let group: String
    }

    struct Schedule: Decodable {
        let monday: [Element]
        let tuesday: [Element]
        let wednesday: [Element]
        let thursday: [Element]
        let friday: [Element]
        let saturday: [Element]
        let sunday: [Element]
    }

    struct Room: Decodable {
        let number: String
        let schedule: Schedule
    }

    let rooms: [Room]
}
