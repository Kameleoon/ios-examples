//
//  Params.swift
//  StarterKit
//
//  Created by Dmitry Eryshov on 03.06.2024.
//

import Foundation

struct Params: Codable {
    
    private struct Const {
        static let paramsKey = "paramsKey"
    }
    
    private static let userDefaults = UserDefaults.standard

    var featureKey: String = ""
    
    init() {
        guard let data = Params.userDefaults.value(forKey: Const.paramsKey) as? Data,
              let decoded = try? JSONDecoder().decode(Params.self, from: data)
        else { return }
        
        self = decoded
    }
    

    func save() {
        guard let encoded = try? JSONEncoder().encode(self) else { return }
        Params.userDefaults.set(encoded, forKey: Const.paramsKey)
    }
}
