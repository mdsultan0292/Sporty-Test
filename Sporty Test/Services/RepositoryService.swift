//
//  RepositoryService.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import GitHubAPI

protocol RepositoryService {
    func fetchRepositories(organisation: String) async throws -> [GitHubMinimalRepository]
}
