//
//  PropertyTemplate.swift
//  
//
//  Created by Wanaldino Antimonio on 24/01/2020.
//

import Foundation

class PropertyTemplate {
    var value: String
    
    init(name: String, type: String, value: Any) {
        switch type {
        case "String" where value as? String == "null":
                self.value = String(format: "%@: UnknownClass", name)
        case "Int", "Float", "String":
            self.value = String(format: "%@: %@", name, type)
        case "Array":
            let className = name.capitalized
            self.value = String(format: "%@: [%@]", name, className)
        case "NewClass":
            let className = name.capitalized
            self.value = String(format: "%@: %@", name, className)
        default:
            fatalError("Something went wrong on - \n\tName: \(name)\n\tType: \(type)\n\tValue: \(value)")
        }
    }
}
