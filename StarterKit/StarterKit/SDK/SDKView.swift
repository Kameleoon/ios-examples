//
//  ContentView.swift
//  StarterKit
//
//  Created by Dmitry Eryshov on 31.05.2024.
//

import SwiftUI

struct SDKView: View {
    @ObservedObject var vm: SDKViewModel
    
    var body: some View {
        Form {
            Section(header: Text("SDK")) {
                VStack {
                    HStack {
                        Text("SDK Status:")
                        Spacer()
                        Text(vm.initialization ? "Initialization..."  : (vm.status ? "Ready ✅" : "Not Ready 🚫"))
                    }
                    .padding(.vertical, Const.verticalPadding)
                }
            }
            Section(header: Text("Parameters")) {
                VStack {
                    HStack {
                        Text("Feature Key:")
                        TextField("feature key", text: $vm.params.featureKey)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            
                    }
                    .padding(.vertical, Const.verticalPadding)
                }
            }
            Section {
                Button(action: {
                    vm.getVariation()
                }, label: {
                    VStack(alignment: .center, content: {
                        Text("Get Varation")
                            .foregroundColor(.white)
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                .background(Color.blue)
            }
            .frame(height: Const.buttonHeight)
            .listRowInsets(.init())
            getResultView()
        }
        .navigationTitle("Kameleoon Starter Kit")
    }
    
    func getResultView() -> some View {
        guard let result = vm.result else { return AnyView(EmptyView()) }
        
        let status, title, value: String
        switch result {
            case .success(let success):
                status = "✅"
                title = "Variation Key:"
                value = success
            case .failure(let failure):
                status = "🚫"
                title = "Error:"
                value = failure.localizedDescription
        }
        return AnyView(
            Section(
                header:
                    HStack {
                        Text("Result" )
                        Spacer()
                        Text(status)
                    },
                content: {
                    VStack {
                        HStack {
                            Text(title)
                            Spacer()
                            Text(value)
                            
                        }
                        .padding(.vertical, Const.verticalPadding)
                    }
                }
            )
        )
    }
    
    private struct Const {
        static let verticalPadding = 10.0
        static let buttonHeight = 60.0
    }
}

#Preview {
    SDKView(vm: SDKViewModel())
}
