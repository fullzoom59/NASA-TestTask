import RealmSwift
import Foundation

class HistoryObject: Object {
    @Persisted var id = UUID().uuidString
    @Persisted var rover: String
    @Persisted var camera: String
    @Persisted var longDate: String
    @Persisted var shortDate: String
}

class RealmService {
    private var realm: Realm?

    init() {
        do {
            try realm = Realm()
        } catch {
            print("Error initializing realm \(error.localizedDescription)")
        }
    }

    func loadObjectsFromRealm() -> [HistoryObject] {
        guard let realm else { return [] }
        let objects = realm.objects(HistoryObject.self)
        return Array(objects)
    }

    func saveToRealm(object: HistoryObject) {
        guard let realm else { return }
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saving object \(error.localizedDescription)")
        }
    }

    func removeObjectFromRealm(id: String) {
        guard let realm else { return }

        do {
            if let objectToDelete = realm.objects(HistoryObject.self).filter("id == '\(id)'").first {
                try realm.write {
                    realm.delete(objectToDelete)
                }
            }
        } catch {
            print("Error deleting object \(error)")
        }
    }
}
