//
//  File.swift
//  
//
//  Created by Wanaldino Antimonio on 24/01/2020.
//

import Foundation

@available(OSX 10.15, *)
class Parser {
    var scanner: Scanner
    var classes = [ParserProperty]()
    
    init(string: String) {
        self.scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = .whitespacesAndNewlines
    }
    
    func parse() -> ParserClass {
        print("Starting parser...")
        print("\n>>>>>>>>>>>>>>>>>>>\n")
        guard scanner.scanCharacter() == "{" else { fatalError("Bad parse") }
        let properties = scanObject()
        let object = ParserClass(name: "MainClass", properties: properties)
        print(object)
        print("\n<<<<<<<<<<<<<<<<<<<\n")
        print("End parsing 😁")
        
        return object
    }
    
    func scanObject() -> [ParserProperty] {
        var properties = [ParserProperty]()
        
        while let property = scanProperty() {
            properties.append(property)
            
            let nextExpectedCharacter = CharacterSet.init(charactersIn: ",}")
            _ = scanner.scanUpToCharacters(from: nextExpectedCharacter)
            let character = scanner.scanCharacter()
            if character == "}" { return properties }
        }
        
        return properties
    }
    
    func scanArray() -> ParserClass? {
        var classes = [ParserClass]()
        
        while scanner.scanCharacter() == "{" {
            let properties = scanObject()
            let `class` = ParserClass(properties: properties)
            classes.append(`class`)
            
            let nextExpectedCharacter = CharacterSet.init(charactersIn: ",]")
            _ = scanner.scanUpToCharacters(from: nextExpectedCharacter)
            let character = scanner.scanCharacter()
            if character == "]" { return classes.getBetter() }
        }
        
        return classes.first
    }
    
    func scanProperty() -> ParserProperty? {
        
        guard let propertyName = scanner.scanUpToString(":")?.trimmingCharacters(in: CharacterSet.init(charactersIn: "\"")) else { return nil }
        _ = scanner.scanCharacter()
        
        if let float = scanner.scanFloat() {
            return ParserProperty(name: propertyName, type: "Float", value: float)
        }
        
        if let int = scanner.scanInt() {
            return ParserProperty(name: propertyName, type: "Int", value: int)
        }
        
        if scanner.scanCharacter() == "[" {
            let `class` = scanArray()
            return ParserProperty(name: propertyName, type: "Array", value: `class`)
        } else {
            scanner.scanLocation -= 1
        }
        
        if scanner.scanCharacter() == "{" {
            let properties = scanObject()
            return ParserProperty(name: propertyName, type: "NewClass", value: properties)
        } else {
            scanner.scanLocation -= 1
        }
        
        var trimmingCharacter = CharacterSet.whitespacesAndNewlines
        trimmingCharacter.formUnion(.init(charactersIn: "\""))
        
        let nextExpectedCharacter = CharacterSet.init(charactersIn: ",}")
        if let string = scanner.scanUpToCharacters(from: nextExpectedCharacter) {
            return ParserProperty(name: propertyName, type: "String", value: string.trimmingCharacters(in: trimmingCharacter))
        } else {
            let remaining = scanner.scanCharacters(from: .init(charactersIn: scanner.string))
            fatalError("Bad parsing.\nRemaining: \(remaining!)")
        }
    }
}
