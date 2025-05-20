import GitHubAPI
import MockLiveServer
import UIKit

@MainActor
final class AppCoordinator {
    private let window: UIWindow
<<<<<<< HEAD
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
=======
    private let gitHubAPI: GitHubAPI
    private let mockLiveServer: MockLiveServer

    init(window: UIWindow) {
        self.window = window
        gitHubAPI = GitHubAPI(authorisationToken: nil)
        mockLiveServer = MockLiveServer()
    }

    func start() {
        window.rootViewController = UINavigationController(
            rootViewController: RepositoriesViewController(
                gitHubAPI: gitHubAPI,
                mockLiveServer: mockLiveServer
            )
        )
>>>>>>> 67a8834 (Initial commit)
        window.makeKeyAndVisible()
    }
}
