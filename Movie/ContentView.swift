//
//  ContentView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 22/06/22.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
    //@State var chan = true
    @ObservedObject var obs = Service()
    @State var page: Int = 1
    @State var countList: Int = 0
    
    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 120)),
    ]
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView(.vertical){
                    LazyVGrid(columns: columns){
                        ForEach(obs.listMovies, id: \.id){ post in
                            NavigationLink(destination: DetailView(movie: post)){
                                peli(post: post, obs: obs)
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
            }
            .onAppear{
                Task{
                    await obs.getPopularMovies()
                }
            }
            
            if obs.loading{
                LoadingView(change: obs.error)
            }
        }
    }
    
}

struct peli: View{
    var post: Movie
    var obs: Service
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(post.posterPath)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110.0, alignment: .center)
                HStack{
                    ZStack(alignment: .leading){
                        Circle()
                            .stroke(lineWidth: 3)
                            .opacity(0.3)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30, alignment: .trailing)
                        Circle()
                            .trim(from: 0.0, to: post.voteAverage / 10)
                            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.green)
                            .rotationEffect(Angle(degrees: 270.0))
                        Text(" \(String(format: "%.1f",post.voteAverage))")
                    }
                    .fixedSize()
                    .frame(alignment: .topTrailing)
                    Text(post.title)
                        .frame(width: 80.0, height: 50.0)
                }
            }
        }
        .padding(10)
        .onAppear{
            let con = obs.listMovies.count - 1
            let id = obs.listMovies[con].id
            if id == post.id{
                Task{
                    await obs.getPopularMovies()
                }
                obs.loading = true
                obs.error = false
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
