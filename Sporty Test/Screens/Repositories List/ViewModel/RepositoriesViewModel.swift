//
//  RepositoriesViewModel.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import Foundation
import GitHubAPI
import MockLiveServer

@MainActor
final class RepositoriesViewModel {

    @Published private(set) var repositories: [GitHubMinimalRepository] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    let repositoryService: RepositoryService
    
    init(repositoryService: RepositoryService) {
        self.repositoryService = repositoryService
    }
    
    func loadRepositories() async {
        
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            repositories = try await repositoryService.fetchRepositories(organisation:"swiftlang")
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
    }

    func repository(_ index: Int) -> GitHubMinimalRepository? {
        guard repositories.indices.contains(index) else {
            return nil
        }
        return repositories[index]
    }
}
