//
//  SegmentViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 21.11.2024.
//

import Foundation

@MainActor
final class SegmentViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var segment: Segment?
    @Published var isCarrierSelected: Bool = false

    // MARK: - Public Methods

    func setup(segment: Segment) {
        self.segment = segment
    }

    func carrierDidSelect() {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "carrierDetailsButton"]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        isCarrierSelected = true
    }
}
