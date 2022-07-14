//
//  SearchView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 14/07/22.
//

import Foundation
import SwiftUI

struct SearchView: View{
    @ObservedObject var obs = ServiceSearch()
    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 120)),
    ]
    var body: some View{
        ZStack{
            NavigationView{
                ScrollView(.vertical){
                    LazyVGrid(columns: columns){
                        ForEach(obs.listMovies, id: \.id){ post in
                            if post.posterPath != nil && post.backdropPath != nil{
                                NavigationLink(destination: DetailView(movie: post)){
                                    MovieView(post: post)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
            }
            .searchable(text: $obs.search)
            if obs.loading {
                LoadingView(change: obs.error)
                    .frame(width: 200, height: 200)
            }
        }
        .onSubmit(of: .search, search)
    }
    
    func search() {
        let busqueda = obs.search.applyingTransform(.stripDiacritics, reverse: false)!
//        busqueda = busqueda.stringByTrimmingCharactersInSet
        Task{
            await obs.getSearchMovies(search:busqueda)
        }
    }
    
}
