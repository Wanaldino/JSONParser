import Foundation

let baseClass: ParserClass!

if #available(OSX 10.15, *) {
    let parser = Parser(string: json)
    baseClass = parser.parse()
} else {
    print("Required OSX version 10.15 or superior :)")
    baseClass = ParserClass(name: nil, properties: [])
}

var allClases = baseClass.properties.compactMap { (property) -> ParserClass? in
    if var parseClass = property.value as? ParserClass {
        parseClass.name = property.name.capitalized
        return parseClass
    } else if let properties = property.value as? [ParserProperty] {
        let parseClass = ParserClass(name: property.name.capitalized, properties: properties)
        return parseClass
    } else if property.type == "Array" {
        return ParserClass(name: property.name.capitalized, properties: [])
    } else {
        return nil
    }
}
allClases.insert(baseClass, at: 0)



func createTampletes(for parseClass: ParserClass) {
    let template = ClassTemplate(with: parseClass)
    
    var url = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    url.appendPathComponent(parseClass.name)
    url.appendPathExtension(".swift")
    try? template.value.write(to: url, atomically: true, encoding: .utf8)
}

allClases.forEach(createTampletes)
