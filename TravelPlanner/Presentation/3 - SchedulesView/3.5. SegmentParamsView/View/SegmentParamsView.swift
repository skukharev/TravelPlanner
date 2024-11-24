//
//  SegmentParamsView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 19.11.2024.
//

import SwiftUI

struct SegmentParamsView: View {
    // MARK: - Types

    private enum Constants {
        static let defaultForegroundColor: Color = .appBlack
        static let defaultElementsSpacing: CGFloat = 16
        static let timeTitleFont: Font = GlobalConstants.ypBold24
        static let timeOptionsFont: Font = GlobalConstants.ypRegular17
        static let timeOptionsTextColor: Color = .appBlack
        static let defaultListRowHeight: CGFloat = 60
        static let departureTimeListHeight: CGFloat = defaultListRowHeight * 4
        static let applySegmentsParametersButtonTitle = L10n.applySegmentParamsButtonTitle
        static let applySegmentsParametersButtonHeight: CGFloat = 60
        static let applySegmentsParametersButtonFont = GlobalConstants.ypBold17
        static let applySegmentsParametersButtonBackground: Color = .blueUniversal
        static let applySegmentsParametersButtonTextColor: Color = .white
    }

    // MARK: - Constants

    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    // MARK: - Public Properties

    @Environment(\.presentationMode)
    var presentationMode
    @Binding var params: SegmentsParams

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.defaultElementsSpacing) {
            /// Departure time label
            Text(L10n.segmentParamsTimeTitle)
                .font(Constants.timeTitleFont)
                .padding()
            /// Departure time options
            List(viewModel.internalParams.departureTimes.indices, id: \.self) { index in
                VStack {
                    HStack {
                        DepartureTimeToggleView(
                            title: viewModel.internalParams.departureTimes[index].name,
                            isOn: $viewModel.internalParams.departureTimes[index].value
                        )
                        .font(Constants.timeOptionsFont)
                        .foregroundStyle(Constants.timeOptionsTextColor)
                    }
                }
                .toggleStyle(CheckboxToggleStyle())
                .frame(height: Constants.defaultListRowHeight)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .frame(height: Constants.departureTimeListHeight)
            .padding()
            /// Show transfers option
            Text(L10n.segmentParamsShowTransfersTitle)
                .font(Constants.timeTitleFont)
                .padding()
            /// Show trasnfers radio buttons
            List {
                VStack {
                    HStack {
                        ShowTrasnfersToggleView(title: "Да", isOn: $viewModel.isShowTransferOptions)
                    }
                    .frame(height: Constants.defaultListRowHeight)
                    HStack {
                        ShowTrasnfersToggleView(title: "Нет", isOn: $viewModel.isHideTransferOptions)
                    }
                    .frame(height: Constants.defaultListRowHeight)
                }
                .toggleStyle(CheckboxToggleStyle())
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .padding()
            .safeAreaInset(edge: .bottom) {
                Button(
                    action: {
                        applyParamsButtonTap()
                    },
                    label: {
                        Text(Constants.applySegmentsParametersButtonTitle)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: Constants.applySegmentsParametersButtonHeight
                            )
                            .font(Constants.applySegmentsParametersButtonFont)
                    }
                )
                .background(Constants.applySegmentsParametersButtonBackground)
                .foregroundStyle(Constants.applySegmentsParametersButtonTextColor)
                .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
                .padding(.horizontal)
                .opacity(viewModel.isEmptyParams ? 0 : 1)
            }
        }
        .navigationBarBackButtonTitleHidden()
        .foregroundStyle(Constants.defaultForegroundColor)
        .onAppear {
            viewModel.setup(segmentsParams: params)
        }
    }

    // MARK: - Private Methods

    @StateObject private var viewModel = SegmentParamsViewModel()

    // MARK: - Private Methods

    private func applyParamsButtonTap() {
        impactMed.impactOccurred()
        viewModel.applyParams(segmentsParams: &params)
        presentationMode.wrappedValue.dismiss()
    }
}

struct SegmentParamsPreview: View {
    @State var params = SegmentsParams()

    var body: some View {
        SegmentParamsView(params: $params)
    }
}

#Preview {
    SegmentParamsPreview()
}
