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
    var body: some View {
        ScrollView(.vertical){
            VStack{
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)"))
                HStack{
                    WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 170, alignment: .leading)
                    Text(movie.title)
                        .frame(width: 130, height: 100, alignment: .center)
                }
                .padding()
                .frame(alignment: .leading)
                Spacer()
                Text(movie.overview)
                    .frame(width: 250, height: 200, alignment: .center)
            }
            .padding()
        }
    }
}

/*struct DetailView_Previews: PreviewProvider{
    static var previews: some View{
        DetailView()
    }
}
*/
