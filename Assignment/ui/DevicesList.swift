//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    @Binding var devices: [DeviceData]?
    let onSelect: (DeviceData) -> Void // Callback for item selection

    var body: some View {
        List(devices ?? []) { device in
            Button {
                onSelect(device)
            } label: {
                VStack(alignment: .leading) {
                    AssignmentText(text: device.name)
                    if let color = device.data?.color {
                        Text("Color: "+color)
                    }
                    if let price = device.data?.price {
                        Text("Price: $"+String(price))
                    }
                    if let capacity = device.data?.capacity {
                        Text("Capacity: "+capacity)
                    }
                    if let description = device.data?.description {
                        Text("Description: "+description)
                    }
                }
            }
        }
    }
}
