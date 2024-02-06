import Foundation

class DateViewModel {
    private let longDateFormatter = DateFormatter()
    private let shortDateFormatter = DateFormatter()
    
    init() {
        longDateFormatter.dateFormat = "MMMM d, yyyy"
        shortDateFormatter.dateFormat = "yyyy-M-d"
    }
    
    // Example: June 6, 2019
    func formatDateForLongFormat(date: Date) -> String{
        return longDateFormatter.string(from: date)
    }
    
    // Example: 2019-6-6
    func formatDateForShortFormat(date: Date) -> String {
        return shortDateFormatter.string(from: date)
    }
}

