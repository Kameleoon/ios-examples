//
//  StarterKitApp.swift
//  StarterKit
//
//  Created by Dmitry Eryshov on 31.05.2024.
//

import SwiftUI

@main
struct StarterKitApp: App {
    var body: some Scene {
        WindowGroup {
            SDKView(vm: SDKViewModel())
        }
    }
}
