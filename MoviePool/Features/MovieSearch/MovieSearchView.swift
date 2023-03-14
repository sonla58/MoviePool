//
//  MovieSearchView.swift
//  MoviePool
//
//  Created by Anh Son Le on 13/03/2023.
//

import SwiftUI

struct MovieSearchView: View {
    var viewModel: MovieSearchViewModel
    
    init(viewModel: MovieSearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 22, content: {
                ForEach(viewModel.movies) { movie in
                    MovieItemView(movie: movie)
                        .aspectRatio(2/3, contentMode: .fill)
                }
                if viewModel.shouldShowMore {
                    loadMoreView
                        .onAppear {
                            viewModel.loadMore()
                        }
                    loadMoreView
                }
            })
            .padding(.horizontal, 22)
            .padding(.vertical, 16)
        }
        .navigationTitle("Movie Search")
        .searchable(text: viewModel.$query)
    }


    // Load more view "loadMoreView" with skeleton animation in rectangle shape
    var loadMoreView: some View {
        Rectangle()
            .fill(.thickMaterial)
            .frame(maxWidth: .infinity)
            .aspectRatio(2/3, contentMode: .fill)
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView(viewModel: MovieSearchViewModel())
    }
}
