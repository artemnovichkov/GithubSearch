//
//  DetailsView.swift
//  GithubSearch
//
//  Created by Artem Novichkov on 19.04.2023.
//

import SwiftUI

struct DetailsView: View {

    @State var repo: Repo
    @State var starred = false
    @State var subscribed = false

    var body: some View {
        VStack(alignment: .leading) {
            owner
            Text(repo.name)
                .font(.title)
            Text(repo.description)
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.body)
                .padding(.bottom, 6)
            info
                .padding(.bottom, 6)
            buttons
                .padding(.bottom, 6)
            List {
                HStack {
                    Image(systemName: "circle")
                        .padding(.all, 4)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                    Text("Issues")
                    Spacer()
                    Text("54")
                    Image(systemName: "chevron.right")
                }
                .frame(height: 44)
                HStack {
                    Image(systemName: "arrow.left.arrow.right")
                        .padding(.all, 4)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                    Text("Pull requests")
                    Spacer()
                    Text("20")
                    Image(systemName: "chevron.right")
                }
                .frame(height: 44)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.grouped)
            Spacer()
        }
        .padding(.horizontal)
    }

    private var owner: some View {
        HStack {
            AsyncImage(url: repo.owner.avatar_url, content: { image in
                image
                    .resizable()
            }, placeholder: {
                Color.gray
            })
            .frame(width: 44, height: 44)
            .cornerRadius(22)
            Text(repo.owner.login)
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.callout)
            Spacer()
        }
    }

    private var info: some View {
        HStack(spacing: 4) {
            Image(systemName: "star")
                .foregroundColor(Color(uiColor: .systemGray))
            Text("\(repo.stargazers_count, format: .number.notation(.compactName))")
            Text("stars")
                .foregroundColor(Color(uiColor: .systemGray))
            Spacer()
                .frame(width: 20)
            Image(systemName: "tuningfork")
                .foregroundColor(Color(uiColor: .systemGray))
            Text("\(repo.forks_count)")
            Text("forks")
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }

    private var buttons: some View {
        HStack {
            Button(action: { starred.toggle() }) {
                HStack {
                    Image(systemName: starred ? "star.fill" : "star")
                    Text(starred ? "Starred" : "Star")
                }
                .frame(maxWidth: .greatestFiniteMagnitude)
                .frame(height: 44)
                .background(Color(uiColor: .systemGray3))
            }
            .foregroundColor(Color(uiColor: .systemBackground))
            .cornerRadius(6)
            Button(action: subscribe) {
                Image(systemName: subscribed ? "bell.fill": "bell")
                    .frame(width: 44, height: 44)
                    .background(Color(uiColor: .systemGray3))
            }
            .foregroundColor(Color(uiColor: .systemBlue))
            .cornerRadius(6)
        }
    }

    private func subscribe() {
        subscribed.toggle()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(repo: .init(name: "Artem Artem Artem Artem Artem",
                                description: "Description",
                                stargazers_count: 6,
                                forks_count: 23,
                                owner: .init(login: "apple",
                                             avatar_url: URL(string: "https://picsum.photos/200")!)))
    }
}
