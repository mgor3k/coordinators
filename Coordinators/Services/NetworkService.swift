//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation

// Big fat mock with made up stuff
class NetworkService {
    static let shared = NetworkService()
    private init() { }
    
    enum State {
        // get all current data from the 'server'
        case all
        
        // appends a new data at the end, mocks a 'server' update with new data
        case addNew
        
        // mocks fetched data with this model being bought
        case bought(HomeModel)
    }
    
    var currentState: State = .all
    
    var currentData: [HomeModel] = [
        .init(title: "Test0", isBought: false),
        .init(title: "Test1", isBought: false)
    ]
    
    func getData() -> [HomeModel] {
        defer {
            currentState = .all
        }
        
        switch currentState {
        case .all:
            return currentData
        case .addNew:
            let newModel = HomeModel(title: "Test\(currentData.count)", isBought: false)
            currentData.append(newModel)
            return currentData
        case .bought(let model):
            if let index = currentData.firstIndex(where: { $0.id == model.id }) {
                let updated = HomeModel(title: model.title, isBought: true)
                currentData.remove(at: index)
                currentData.insert(updated, at: index)
            }
            return currentData
        }
    }
}
