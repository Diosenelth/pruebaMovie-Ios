//
//  Movies.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 27/06/22.
//

import Foundation

// MARK: - PlaylistItemsModel
struct Movies: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


