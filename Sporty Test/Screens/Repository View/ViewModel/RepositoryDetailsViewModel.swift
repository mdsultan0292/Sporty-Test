//
//  RepositoryDetailsViewModel.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import Foundation
import Combine
import GitHubAPI

@MainActor
final class RepositoryDetailsViewModel: ObservableObject {
    @Published private(set) var repository: GitHubFullRepository?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    let minimalRepository: GitHubMinimalRepository
    private let repositoryDetailsService: RepositoryDetailsService
    
    init(minimalRepository: GitHubMinimalRepository, repositoryDetailsService: RepositoryDetailsService) {
        self.minimalRepository = minimalRepository
        self.repositoryDetailsService = repositoryDetailsService
    }
    
    func loadRepositoryDetails() async {
        guard repository == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            repository = try await repositoryDetailsService.fetchRepositoryDetails(fullName: minimalRepository.fullName)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
