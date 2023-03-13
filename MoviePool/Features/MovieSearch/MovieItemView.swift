//
//  MovieItemView.swift
//  MoviePool
//
//  Created by Anh Son Le on 14/03/2023.
//

import SwiftUI

import OMDbClient

struct MovieItemView: View {
    let movie: Movie

    var body: some View {
        AsyncImage(url: URL(string: movie.poster)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failure:
                Image(systemName: "film")
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fit)
                    .clipped()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fill)
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading) {
                Spacer()
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(movie.title)
                        .font(.system(size: 14, weight: .semibold))
                        .lineLimit(1)
                    Text(movie.year)
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .background(.thickMaterial, in: Rectangle())
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(movie: Movie(title: "Marve", year: "2019", imdbID: "tt9073746", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BODIxZmExNDEtMDk1ZC00MjJhLTg0ZjItMWU4NGQ3MmEyNGUzXkEyXkFqcGdeQXVyODc5MDgxNzE@._V1_SX300.jpg"))
            .previewLayout(.sizeThatFits)
            .frame(width: 100, height: 150)
    }
}
