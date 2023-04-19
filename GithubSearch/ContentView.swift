//
//  ContentView.swift
//  GithubSearch
//
//  Created by Artem Novichkov on 19.04.2023.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel: ContentViewModel = .init()

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                TextField("Enter repo name in format owner/repo", text: viewModel.$name)
                    .textFieldStyle(.roundedBorder)
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                else {
                    Button(action: viewModel.search, label: {
                        Text("Search")
                    })
                    .disabled(viewModel.name.isEmpty)
                }
            }
            .padding()
            .navigationTitle("Github Search")
            .navigationDestination(for: Repo.self) { repo in
                DetailsView(repo: repo)
            }
        }
    }
}

final class ContentViewModel: ObservableObject {

    @AppStorage("name") var name = ""
    @Published var path = NavigationPath()
    @Published var isLoading = false

    private lazy var searchService: SearchService = .init()

    func search() {
        isLoading = true
        Task {
            do {
                let repo = try await searchService.search(name: name)
                await MainActor.run {
                    isLoading = false
                    path.append(repo)
                }
            }
            catch {
                await MainActor.run {
                    isLoading = false
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
