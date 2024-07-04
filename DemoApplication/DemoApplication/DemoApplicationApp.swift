//
//  DemoApplicationApp.swift
//  DemoApplication
//
//  Created by Dmitry Eryshov on 07.06.2024.
//

import SwiftUI

@main
struct DemoApplicationApp: App {
    var body: some Scene {
        WindowGroup {
            SDKView(vm: SDKViewModel())
        }
    }
}
