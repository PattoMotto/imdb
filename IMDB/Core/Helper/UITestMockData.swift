//Pat

import Foundation

struct UITestMockData {

    private var recentSearchManager: RecentSearchManager

    init(recentSearchManager: RecentSearchManager = RecentSearchManagerImpl()) {
        self.recentSearchManager = recentSearchManager
    }

    func process(arguments: [String]) {
        arguments.forEach {
            process(argument: $0)
        }
    }

    private func process(argument: String) {
        if argument == UITestLaunchArgument.clearRecentSearch {
            recentSearchManager.clear()
        } else if argument.hasPrefix(UITestLaunchArgument.mockRecentSearch) {
            var parameters = argument.split(separator: "#")
            parameters.remove(at: 0)
            parameters.forEach {
                recentSearchManager.save(title: String($0))
            }
        }
    }
}
