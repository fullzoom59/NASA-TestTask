import Foundation

protocol FilterStrategy {
    func filter(object: [Photo], rover: String, camera: String) -> [Photo]
}

class HomeFilterStrategy: FilterStrategy {
    // Если и rover, и camera равны "All", то выбираются все данные )
    // Если rover равен "All", но camera не равен "All", фильтрация происходит только по camera.
    // Если camera равен "All", но rover не равен "All", фильтрация происходит только по rover.
    // Если ни rover, ни camera не равны "All", фильтрация происходит и по rover, и по camera
    
    func filter(object: [Photo], rover: String, camera: String) -> [Photo] {
        object.filter { filterName in
            let matchesRover = rover == "All" || filterName.rover?.name == rover
            let matchesCamera = camera == "All" || filterName.camera?.fullName == camera
            return matchesRover && matchesCamera
        }
    }
}
