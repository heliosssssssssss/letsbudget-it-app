import Foundation
import SwiftData

@Model
class Item {
    @Attribute(.unique) var id: UUID
    var name: String
    var createdDate: Date

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdDate = Date()
    }
}
