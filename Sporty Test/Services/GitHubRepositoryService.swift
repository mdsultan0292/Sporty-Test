//
//  GitHubRepositoryService.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import GitHubAPI

class GitHubRepositoryService: RepositoryService, RepositoryDetailsService {
    
    private let gitHubAPI: GitHubAPI
    
    init(gitHubAPI: GitHubAPI) {
        self.gitHubAPI = gitHubAPI
    }
    
    func fetchRepositories(organisation: String) async throws -> [GitHubMinimalRepository] {
        return try await gitHubAPI.repositoriesForOrganisation(organisation)
    }
    
    func fetchRepositoryDetails(fullName: String) async throws -> GitHubFullRepository {
        return try await gitHubAPI.repository(fullName)
    }
}
