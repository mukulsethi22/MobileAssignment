//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var path = NavigationPath() // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if let computers = viewModel.data, !computers.isEmpty {
                    DevicesList(devices: $viewModel.data) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
//                        path.append(selectedComputer)
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                if let navigate {
                    path.append(navigate)
                }
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onDisappear() {
                viewModel.navigateDetail = nil
            }
            .onAppear {
                viewModel.fetchAPI()
                let navigate = viewModel.navigateDetail
                if (navigate != nil) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        path.append(navigate!)
                    }
                }
            }
        }
    }
}
