import UIKit

class DatePicker: UIDatePicker {
    init() {
        super.init(frame: .zero)
        setupDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDatePicker() {
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
        }
        self.datePickerMode = .date
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        let minDateComponents = DateComponents(year: 2005, month: 1, day: 1)
        let maxDateComponents = DateComponents(year: 2024, month: 1, day: 1)
        
        let minDate = calendar.date(from: minDateComponents)
        let maxDate = calendar.date(from: maxDateComponents)
        
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
}
