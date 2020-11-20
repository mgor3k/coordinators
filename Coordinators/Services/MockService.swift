//
//  Created by Maciej Gorecki on 07/11/2020.
//

import Foundation
import Combine
import Store

// Big fat mock with made up stuff
class MockService: HomeStoreNetworking, DetailsNetworking {
    static let shared = MockService()
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
    
    func fetchData() -> [HomeModel] {
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
    
    func markAsBought(_ model: HomeModel) {
        currentState = .bought(model)
    }
}

extension MockService: LoginNetworking {
    func authenticate(username: String, password: String) -> AnyPublisher<String, Login.Error> {
        Future<String, Login.Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                DispatchQueue.main.async {
                    if username.lowercased() == "error" {
                        promise(.failure(.invalidUsername))
                    } else {
                        promise(.success("12345678"))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
