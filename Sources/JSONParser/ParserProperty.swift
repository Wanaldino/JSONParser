import Foundation

struct ParserProperty: Hashable {
    var name: String
    var type: String
    var value: Any? = nil
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {}
}
