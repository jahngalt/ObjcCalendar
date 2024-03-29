import UIKit

struct Event: Codable {
    var id: Int
    var date_start: Double
    var date_finish: Double
    var name: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case id
        case date_start
        case date_finish
        case name
        case description
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date_start, forKey: .date_start)
        try container.encode(date_finish, forKey: .date_finish)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
