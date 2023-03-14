//
//  MovieSearchViewModel.swift
//  MoviePool
//
//  Created by Anh Son Le on 13/03/2023.
//

import SwiftUI
import Combine

import OMDbClient

struct MovieSearchViewModel {
    @State var movies: [Movie] = []
    @State var query: String = ""
    @State var shouldShowMore: Bool = false
    @State var isLoading: Bool = false
    
    private let querySubject = CurrentValueSubject<String, Never>("")
    private let currentPageIndex = CurrentValueSubject<Int, Never>(1)
    private let queryInput: AnyPublisher<(String, Int), Never>
    
    private let movieService = OMDbClient(apiKey: Bundle.main.object(forInfoDictionaryKey: "OMDB_KEY") as? String ?? "")
    @State var searchTask: AnyCancellable?
    
    init() {
        queryInput = querySubject
            .removeDuplicates()
            .combineLatest(currentPageIndex.removeDuplicates())
            .filter { !$0.0.isEmpty }
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func loadMore() {
        if !isLoading {
            currentPageIndex.send(currentPageIndex.value + 1)
        }
    }
}

extension MovieSearchViewModel {
    private func searchMovie(query: String, page: Int) -> AnyPublisher<MovieResult, Error> {
        movieService.searchMovie(byName: query, page: page)
    }
}

extension MovieSearchViewModel: View {
    var body: some View {
        MovieSearchView(viewModel: self)
            .onChange(of: query) { newValue in
                movies = []
                currentPageIndex.send(1)
                shouldShowMore = false
                querySubject.send(newValue)
            }
            .onReceive(queryInput) { (text, page) in
                if isLoading {
                    return
                } else {
                    isLoading = true
                }
                searchTask?.cancel()
                searchTask = searchMovie(query: text, page: page)
                    .receive(on: DispatchQueue.main)
                    .sink { com in
                        isLoading = false
                    } receiveValue: { result in
                        movies += result.search
                        if movies.count < Int(result.totalResults) ?? 0 && movies.count > 0 {
                            self.shouldShowMore = true
                        }
                    }
            }
    }
}

extension Movie: Identifiable {
    public var id: String {
        self.imdbID
    }
}
