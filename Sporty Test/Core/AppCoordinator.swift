import GitHubAPI
import MockLiveServer
import UIKit

@MainActor
final class AppCoordinator {
    private let window: UIWindow
<<<<<<< HEAD
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
=======
    private let repositoryService: GitHubRepositoryService
>>>>>>> 118c2b1 (migrate repositories feature to MVVM using Combine)
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
<<<<<<< HEAD
>>>>>>> 67a8834 (Initial commit)
=======
        window.rootViewController = UINavigationController(rootViewController: listViewController)
>>>>>>> 118c2b1 (migrate repositories feature to MVVM using Combine)
        window.makeKeyAndVisible()
    }
}
