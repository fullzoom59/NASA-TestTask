import Foundation

enum RoverType {
    case curiosity
    case opportunity
    case spirit
    
    var endpoint: String {
        switch self {
        case .curiosity:
            return "curiosity/photos"
        case .opportunity:
            return "opportunity/photos"
        case .spirit:
            return "spirit/photos"
        }
    }
}
