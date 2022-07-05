//
//  ContentView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 22/06/22.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import SwiftyJSON


struct ContentView: View {
    @State var chan = true
    @State var moviesRes : Movies?
    @ObservedObject var obs = Service()
    
    var body: some View {
        /*LottieView(change: chan)
            .onAppear{
                Task{
                    await obs.getPopularMovies(page: "1")
                }
            }*/
        List{
            ForEach(obs.listMovies, id: \.id){ post in
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(post.posterPath)"))
                    .resizable()
                    .scaledToFit()
                Text(post.title)
            }
        }
        .onAppear{
            Task{
                await obs.getPopularMovies(page: "1")
            }
        }
    }
    
    func change(){
        chan.toggle()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
