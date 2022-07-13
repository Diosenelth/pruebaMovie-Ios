//
//  ContentView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 22/06/22.
//

import SwiftUI


struct ContentView: View {
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
                                MovieView(post: post, obs: obs)
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
                    .frame(width: 200, height: 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
