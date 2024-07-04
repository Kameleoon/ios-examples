//
//  Basic.swift
//  DemoApplication
//
//  Created by Dmitry Eryshov on 03.07.2024.
//

import kameleoonClient

extension SDKViewModel {
    
    // MARK: - Basic
    func basic() {
        guard let index = Int(params.customDataIndex) else {
            result = Result.failure(KError(error: "Custom Data Index should be integer value"))
            return
        }
        do {
            kameleoonClient.addData(CustomData(id: index, values: params.customDataValue))
            let variation = try kameleoonClient.getFeatureVariationKey(featureKey: params.featureKey)
            result = Result.success((.ready, "Variation Key: \(variation)"))
        } catch KameleoonError.sdkNotReady {
            result = Result.failure(KameleoonError.sdkNotReady)
        } catch KameleoonError.Feature.notFound(let featureKey) {
            result = Result.failure(KameleoonError.Feature.notFound(featureKey))
        } catch KameleoonError.Feature.environmentDisabled(let featureKey, let env) {
            result = Result.failure(KameleoonError.Feature.environmentDisabled(featureKey, env))
        } catch {
            result = Result.failure(error)
        }
        log(result)
    }
    
    // MARK: - Remote Data
    func remote() {
        result = .success((.calculate, ""))
        kameleoonClient.getRemoteVisitorData { [weak self] resRemoteVisitorData in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                switch resRemoteVisitorData {
                    case .success(let remoteData):
                        do {
                            let variable = try self.kameleoonClient.getFeatureVariable(
                                featureKey: self.params.featureKey,
                                variableKey: self.params.variableKey
                            )
                            let customDataString = remoteData
                                .compactMap { $0 as? CustomData }
                                .map { "CustomData(index: \($0.id), values: \($0.values))"}
                                .joined(separator: ", ")
                            let variableStr = variable != nil ? "\(variable!)" : "null"
                            self.result = .success(
                                (.ready, "Variable: \(variableStr), CustomData: \(customDataString)")
                            )
                        } catch KameleoonError.sdkNotReady {
                            result = Result.failure(KameleoonError.sdkNotReady)
                        } catch KameleoonError.Feature.notFound(let featureKey) {
                            result = Result.failure(KameleoonError.Feature.notFound(featureKey))
                        } catch KameleoonError.Feature.environmentDisabled(let featureKey, let env) {
                            result = Result.failure(KameleoonError.Feature.environmentDisabled(featureKey, env))
                        } catch KameleoonError.Feature.variableNotFound(
                                let featureKey, let variationKey, let variableKey) {
                            result = Result.failure(
                                    KameleoonError.Feature.variableNotFound(featureKey, variationKey, variableKey))
                        } catch {
                            self.result = Result.failure(error)
                        }
                    case .failure(let error):
                        self.result = Result.failure(error)
                }
                log(self.result)
            }
        }
    }
    
    // MARK: - All Flags
    func allFlags() {
        do {
            let visitorFeatures = try kameleoonClient.getFeatureList()
                .map { "[Feature Key: \($0), Active: \(try kameleoonClient.isFeatureActive(featureKey: $0))]"}
                .joined(separator: ",\n")
            result = .success((.ready, visitorFeatures))
        } catch KameleoonError.sdkNotReady {
            result = Result.failure(KameleoonError.sdkNotReady)
        } catch {
            self.result = Result.failure(error)
        }
        log(result)
    }
}

