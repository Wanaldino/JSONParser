import Foundation

struct ParserClass {
    var name: String// = UUID().description
    var properties: [ParserProperty]
    
    init(name: String? = nil, properties: [ParserProperty]) {
        self.name = name ?? UUID().description
        self.properties = properties
    }
}
