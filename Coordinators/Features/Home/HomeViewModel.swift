//
//  Created by Maciej Gorecki on 03/11/2020.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var models: [HomeModel] = []
    @Published var isLoading = false
    
    let screenName = "Home"
    
    init() {
        fetchModels()
    }
}

private extension HomeViewModel {
    func fetchModels() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.models = [
                    .init(title: "Test1"),
                    .init(title: "Test2")
                ]
            }
        }
    }
}
