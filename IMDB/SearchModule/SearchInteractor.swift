//Pat

import Foundation

final class SearchInteractor {
    weak var output: SearchInteractorOutput?
}

extension SearchInteractor: SearchInteractorInput {
    func search() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now()+1) { [weak self] in
//            if self?.randomBool ?? false {
                self?.output?.success()
//            } else {
//                self?.output?.failure()
//            }
        }
    }

    func lastSearch() {
        output?.lastSearchCompleted()
    }
}


extension SearchInteractor {
    private var randomBool: Bool {
        return arc4random_uniform(2) == 0
    }
}
