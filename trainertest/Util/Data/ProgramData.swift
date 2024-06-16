import Foundation

struct ProgramData: Identifiable, Decodable {
    let id = UUID()
    var name: String
    var smallInfo: String
    var info: String
    var workout: String
    var emoji: String
}
