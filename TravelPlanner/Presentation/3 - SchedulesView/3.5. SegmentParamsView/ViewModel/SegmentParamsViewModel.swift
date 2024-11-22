//
//  SegmentParamsViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 20.11.2024.
//

import Foundation

final class SegmentParamsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var internalParams = SegmentsParams()
    @Published var isShowTransferOptions: Bool = false {
        didSet {
            if inChangingRadioButton { return }
            inChangingRadioButton = true
            isHideTransferOptions = !isShowTransferOptions
            inChangingRadioButton = false
        }
    }
    @Published var isHideTransferOptions: Bool = false {
        didSet {
            if inChangingRadioButton { return }
            inChangingRadioButton = true
            isShowTransferOptions = !isHideTransferOptions
            inChangingRadioButton = false
        }
    }
    var isEmptyParams: Bool {
        var isEmptyParams: Bool = true
        for item in internalParams.departureTimes where item.value {
            isEmptyParams = false
            break
        }
        return isEmptyParams && !isShowTransferOptions && !isHideTransferOptions
    }

    // MARK: - Private Properties

    private var inChangingRadioButton: Bool = false

    // MARK: - Public Methods

    public func setup(segmentsParams: SegmentsParams) {
        internalParams.departureTimes = segmentsParams.departureTimes
        internalParams.isShowTransfers = segmentsParams.isShowTransfers
        guard let isShowTransfers = segmentsParams.isShowTransfers else { return }
        isShowTransferOptions = isShowTransfers
        isHideTransferOptions = !isShowTransferOptions
    }

    public func applyParams(segmentsParams: inout SegmentsParams) {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "applyParamsButton"]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")

        segmentsParams.departureTimes = internalParams.departureTimes
        if !isShowTransferOptions && !isHideTransferOptions {
            segmentsParams.isShowTransfers = nil
        } else {
            segmentsParams.isShowTransfers = isShowTransferOptions
        }
    }
}
