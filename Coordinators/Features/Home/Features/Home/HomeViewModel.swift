//
//  Created by Maciej Gorecki on 03/11/2020.
//

import Foundation

protocol HomeDelegate: class {
    func didSelect(model: HomeModel)
}

class HomeViewModel: ObservableObject {
    @Published var models: [HomeModel] = []
    @Published var isLoading = false
    
    let screenName = "Home"
    
    private weak var delegate: HomeDelegate?
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
        initialFetch()
    }
    
    func didSelectModel(at index: Int) {
        let selectedModel = models[index]
        delegate?.didSelect(model: selectedModel)
    }
    
    func fetch() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isLoading = false
//            DispatchQueue.main.async {
                self?.models.append(.init(title: "Test\(self?.models.count ?? 0)"))
//            }
        }
    }
}

private extension HomeViewModel {
    func initialFetch() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.models = [
                    .init(title: "Test0"),
                    .init(title: "Test1")
                ]
            }
        }
    }
}
