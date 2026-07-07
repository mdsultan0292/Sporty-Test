import GitHubAPI
import MockLiveServer
import UIKit

@MainActor
final class AppCoordinator {
    private let window: UIWindow
    private let repositoryService: GitHubRepositoryService
    private let mockLiveServer: MockLiveServer
    
    init(window: UIWindow) {
        self.window = window
        let gitHubAPI = GitHubAPI(authorisationToken: nil)
        repositoryService = GitHubRepositoryService(gitHubAPI: gitHubAPI)
        mockLiveServer = MockLiveServer()
    }
    
    func start() {
        let listViewModel = RepositoriesViewModel(repositoryService: repositoryService)
        let listViewController = RepositoriesViewController(
            viewModel: listViewModel,
            makeDetailsViewController: { [repositoryService] repository in
                let detailsViewModel = RepositoryDetailsViewModel(
                    minimalRepository: repository,
                    repositoryDetailsService: repositoryService
                )
                return RepositoryViewController(viewModel: detailsViewModel)
            }
        )
        window.rootViewController = UINavigationController(rootViewController: listViewController)
        window.makeKeyAndVisible()
    }
}
