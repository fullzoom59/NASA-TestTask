import Foundation

class HistoryViewModel {
    private let realmService = RealmService()
    public var historyObjects = [HistoryObject]()
    
    func loadObjects() {
        self.historyObjects = realmService.loadObjectsFromRealm()
    }
    
    func removeObject(id: String, at index: Int) {
        self.realmService.removeObjectFromRealm(id: id)
        self.historyObjects.remove(at: index)
    }
}
