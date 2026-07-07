//
//  RepositoryDetailsService.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import GitHubAPI

protocol RepositoryDetailsService {
    func fetchRepositoryDetails(fullName: String) async throws -> GitHubFullRepository
}
