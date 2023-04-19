//
//  SearchService.swift
//  GithubSearch
//
//  Created by Artem Novichkov on 19.04.2023.
//

import Foundation

// https://api.github.com/repos/OWNER/REPO
final class SearchService {

    func search(name: String) async throws -> Repo {
        let url = URL(string: "https://api.github.com/repos/" + name)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let repo = try JSONDecoder().decode(Repo.self, from: data)
        return repo
    }
}

struct Repo: Decodable, Hashable {

    let name: String
    let description: String
    let stargazers_count: Int
    let forks_count: Int
    let owner: Owner
}

struct Owner: Decodable, Hashable {

    let login: String
    let avatar_url: URL
}
