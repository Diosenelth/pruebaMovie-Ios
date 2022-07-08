//
//  DetailView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 8/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    var movie: Movie
    @ObservedObject var obs = Service()
    var body: some View {
        ScrollView(.vertical){
            VStack{
                if movie.backdropPath != nil{
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath!)"))
                }
                HStack{
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 170, alignment: .leading)
                    Text(movie.title)
                        .frame(width: 140, alignment: .center)
                }
                .padding()
                .frame(alignment: .leading)
                Spacer()
                Text(movie.overview)
                    .frame(width: 250,alignment: .center)
                Spacer()
                if $obs.movie.count > 0{
                    Link("Ir a HomePage", destination: URL(string:obs.movie[0].homepage!) ?? URL(string: "https://www.google.com")!)
                }
            }
            .padding()
        }
        .onAppear{
            Task{
                await obs.getMovie(id:"\(movie.id)")
            }
        }
    }
}

/*struct DetailView_Previews: PreviewProvider{
 static var previews: some View{
 DetailView()
 }
 }
 */
