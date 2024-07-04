//
//  ContentView.swift
//  StarterKit
//
//  Created by Dmitry Eryshov on 31.05.2024.
//

import SwiftUI

struct SDKView: View {
    @ObservedObject var vm: SDKViewModel
    @State var isResultPresented = false
    
    var body: some View {
        GeometryReader { geom in
            NavigationStack {
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
                            ParamCell(title: "Feature Key:", placeholder: "feature key", text: $vm.params.featureKey)
                            Divider()
                            ParamCell(
                                title: "Custom Data Index:",
                                placeholder: "index",
                                text: $vm.params.customDataIndex
                            )
                            Divider()
                            ParamCell(
                                title: "Custom Data Value:",
                                placeholder: "value",
                                text: $vm.params.customDataValue
                            )
                            Divider()
                            ParamCell(
                                title: "Variable Key:",
                                placeholder: "variable key",
                                text: $vm.params.variableKey
                            )
                        }
                    }
                    Section(header: Text("Basic")) {
                        VStack {
                            ActionCell(title: "Basic", isResultPresented: $isResultPresented) { vm.basic() }
                            Divider()
                            ActionCell(title: "Remote", isResultPresented: $isResultPresented) { vm.remote() }
                            Divider()
                            ActionCell(title: "All Flags", isResultPresented: $isResultPresented) { vm.allFlags() }
                        }
                    }
                    Section(header: Text("Specific")) {
                        VStack {
                            ActionCell(title: "Feature List", isResultPresented: $isResultPresented) {
                                vm.featureList()
                            }
                            Divider()
                            ActionCell(title: "Add Data", isResultPresented: $isResultPresented) { vm.addData() }
                            Divider()
                            ActionCell(title: "Active Features", isResultPresented: $isResultPresented) {
                                vm.activeFeatures()
                            }
                            Divider()
                            ActionCell(title: "Feature Active", isResultPresented: $isResultPresented) {
                                vm.featureActive()
                            }
                            Divider()
                            ActionCell(title: "Feature Variation", isResultPresented: $isResultPresented) {
                                vm.featureVariation()
                            }
                            Divider()
                            ActionCell(title: "Feature Variable", isResultPresented: $isResultPresented) {
                                vm.featureVariable()
                            }                            
                            Divider()
                            ActionCell(title: "Remote Visitor Data", isResultPresented: $isResultPresented) {
                                vm.remoteVisitorData()
                            }
                        }
                    }
                }
                .sheet(isPresented: $isResultPresented) {
                    VStack {
                        ResultHeader(result: vm.result)
                            .padding(.top, Const.verticalPadding * 3)
                        Divider()
                        ScrollView {
                            ResultView(result: vm.result)
                                .frame(maxHeight: .infinity)
                        }
                    }
                    .presentationDetents([.height(CGFloat(250))])
                    .presentationDragIndicator(.visible)
                }
                .navigationTitle("Kameleoon Demo App")
            }
        }
    }
    
    private struct Const {
        static let verticalPadding = 10.0
        static let buttonHeight = 60.0
    }
    
    private struct ParamCell: View {
        let title: String
        let placeholder: String
        let text: Binding<String>
        
        var body: some View {
            HStack {
                Text(title)
                TextField(placeholder, text: text)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.vertical, Const.verticalPadding)
        }
    }
    
    private struct ActionCell: View {
        let title: String
        var isResultPresented: Binding<Bool>
        let action: () -> Void
        
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.vertical, Const.verticalPadding)
            .contentShape(Rectangle())
            .onTapGesture {
                action()
                isResultPresented.wrappedValue = true
            }
        }
    }
    
    private struct ResultHeader: View {
        let result: Result<(SDKViewModel.ResultState, String), Error>
        private let resultHeaderText = "Result: "
        
        var body: some View {
            switch (result) {
                case .success(let result):
                    Text(resultHeaderText + (result.0 == .calculate ? "Calculating 𝌗" : "Success ✅"))
                case .failure:
                    Text(resultHeaderText + "Failed 🚫")
            }
        }
    }
    
    private struct ResultView: View {
        let result: Result<(SDKViewModel.ResultState, String), Error>
        
        var body: some View {
            switch (result) {
                case .success(let success):
                    Text(success.1)
                        .padding(.horizontal, Const.verticalPadding)
                case .failure(let error):
                    Text(error.localizedDescription)
                        .padding(.horizontal, Const.verticalPadding)
            }
        }
    }
}

#Preview {
    SDKView(vm: SDKViewModel())
}
