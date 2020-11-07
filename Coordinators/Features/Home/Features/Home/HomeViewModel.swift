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
    
    func updateModel(_ model: HomeModel) {
        if let index = models.firstIndex(where: { $0.id == model.id }) {
            var temp = models
            temp.remove(at: index)
            temp.insert(model, at: index)
            models = temp
        }
    }
    
    func fetch() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isLoading = false
            self?.models = NetworkService.shared.getData()
        }
    }
}

private extension HomeViewModel {
    func initialFetch() {
        isLoading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isLoading = false
            self?.models = NetworkService.shared.getData()
        }
    }
}
