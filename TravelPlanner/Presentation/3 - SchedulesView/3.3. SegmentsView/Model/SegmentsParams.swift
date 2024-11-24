//
//  ThreadParams.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 16.11.2024.
//

struct SegmentsParams {
    var departureTimes: [DepartureTime] = [
        DepartureTime(type: .morning, value: false),
        DepartureTime(type: .afternoon, value: false),
        DepartureTime(type: .evening, value: false),
        DepartureTime(type: .night, value: false)
    ]
    var isShowTransfers: Bool?
    var isEmpty: Bool {
        var isEmptyParams: Bool = true
        for item in departureTimes where item.value {
            isEmptyParams = false
            break
        }
        return isEmptyParams && isShowTransfers == nil
    }
}
