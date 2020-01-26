//
//  ClassTemplate.swift
//  
//
//  Created by Wanaldino Antimonio on 24/01/2020.
//

import Foundation

let classTemplate = """
//
//  %@.swift
//
//
//  Created by Wanaldino Antimonio on 24/01/2020.
//

class %@ {
    %@
}

extension %@: Codable {}

"""

class ClassTemplate {
    var value: String!
    
    init(with parserClass: ParserClass) {
        self.value = String(format: classTemplate, parserClass.name, parserClass.name, getPropertiesStrings(for: parserClass), parserClass.name)
    }
    
    func getPropertiesStrings(for parserClass: ParserClass) -> String {
        var propertiesString = ""
        for propery in parserClass.properties {
            let propertyString = PropertyTemplate(name: propery.name, type: propery.type, value: propery.value)
            propertiesString.append(propertyString.value)
            propertiesString.append("\n\t")
        }
        return propertiesString
    }
}
