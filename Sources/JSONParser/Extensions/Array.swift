//
//  Array.swift
//  
//
//  Created by Wanaldino Antimonio on 25/01/2020.
//

import Foundation

extension Array where Element == ParserClass {
    func getBetter() -> ParserClass? {
        if count == 0 { return nil }
        
        let properties = self.flatMap({ $0.properties }).removeDuplicates()
        let `class` = ParserClass(name: self.first?.name, properties: properties)
        
        return `class`
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> Self {
        var cache = Set<Element>()
        
        self.forEach { (element) in
            if !cache.contains(element) { cache.insert(element) }
        }
        
        return Array<Element>(cache)
    }
}
