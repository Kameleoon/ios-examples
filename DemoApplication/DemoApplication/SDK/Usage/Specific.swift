//
//  Specific.swift
//  DemoApplication
//
//  Created by Dmitry Eryshov on 03.07.2024.
//

import kameleoonClient

extension SDKViewModel {
    
    // MARK: - Active Features
    func activeFeatures() {
        let visitorActiveFeatures = kameleoonClient.getActiveFeatures()
        result = .success((.ready, "\(visitorActiveFeatures)"))
        log(result)
    }
    
    // MARK: - Add Data
    func addData() {
        guard let index = Int(params.customDataIndex) else {
            result = Result.failure(KError(error: "Custom Data Index should be integer value"))
            return
        }
        kameleoonClient.addData(CustomData(id: index, values: params.customDataValue))
        kameleoonClient.flush()
        result = .success(
            (.ready, "CustomData(index: \(index), value: \(params.customDataValue)) was added and flushed successfully")
        )
        log(result)
    }
    
    // MARK: - Feature Active
    func featureActive() {
        do {
            let active = try kameleoonClient.isFeatureActive(featureKey: params.featureKey)
            result = .success((.ready, "[Feature Key: \(params.featureKey), Active: \(active)]"))
        } catch KameleoonError.sdkNotReady {
            result = Result.failure(KameleoonError.sdkNotReady)
        } catch KameleoonError.Feature.notFound(let featureKey) {
            result = Result.failure(KameleoonError.Feature.notFound(featureKey))
        } catch {
            result = Result.failure(error)
        }
        log(result)
    }
    
    // MARK: - Feature List
    func featureList() {
        let featureList = kameleoonClient.getFeatureList().map { $0 }.joined(separator: ",\n")
        result = .success((.ready, "Feature keys: \(featureList)"))
        log(result)
    }
    
    // MARK: - Feature Variable
    func featureVariable() {
        do {
            let variable = try kameleoonClient.getFeatureVariable(
                featureKey: params.featureKey,
                variableKey: params.variableKey
            )
            let variableStr = variable != nil ? "\(variable!)" : "null"
            self.result = .success((.ready, "Variable: \(variableStr)"))
        } catch KameleoonError.sdkNotReady {
            result = Result.failure(KameleoonError.sdkNotReady)
        } catch KameleoonError.Feature.notFound(let featureKey) {
            result = Result.failure(KameleoonError.Feature.notFound(featureKey))
        } catch KameleoonError.Feature.environmentDisabled(let featureKey, let env) {
            result = Result.failure(KameleoonError.Feature.environmentDisabled(featureKey, env))
        } catch KameleoonError.Feature.variableNotFound(let featureKey, let variationKey, let variableKey) {
            result = Result.failure(
                    KameleoonError.Feature.variableNotFound(featureKey, variationKey, variableKey))
        } catch {
            self.result = Result.failure(error)
        }
        log(result)
    }
    
    // MARK: - Feature Variation
    func featureVariation() {
        do {
            let variation = try kameleoonClient.getFeatureVariationKey(featureKey: params.featureKey)
            self.result = .success((.ready, "Variation Key: \(variation)"))
        } catch KameleoonError.sdkNotReady {
            result = Result.failure(KameleoonError.sdkNotReady)
        } catch KameleoonError.Feature.notFound(let featureKey) {
            result = Result.failure(KameleoonError.Feature.notFound(featureKey))
        } catch KameleoonError.Feature.environmentDisabled(let featureKey, let env) {
            result = Result.failure(KameleoonError.Feature.environmentDisabled(featureKey, env))
        } catch {
            self.result = Result.failure(error)
        }
        log(result)
    }
    
    // MARK: - Remote Visitor Data
    func remoteVisitorData() {
        result = .success((.calculate, ""))
        kameleoonClient.getRemoteVisitorData { [weak self] resRemoteVisitorData in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch resRemoteVisitorData {
                    case .success(let remoteData):
                        let customDataString = remoteData
                            .compactMap { $0 as? CustomData }
                            .map { "CustomData(index: \($0.id), values: \($0.values))" }
                            .joined(separator: ", ")
                        self.result = .success(
                            (.ready, "CustomData: \(customDataString)")
                        )
                    case .failure(let error):
                        self.result = Result.failure(error)
                }
                log(self.result)
            }
        }
    }
}
