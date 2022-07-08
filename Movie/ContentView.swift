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
    //@State var chan = true
    @ObservedObject var obs = Service()
    @State var page: Int = 1
    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 120)),
        //GridItem(.fixed(100)),
    ]
    
    var body: some View {
        /*LottieView(change: chan)
         .onAppear{
         Task{
         await obs.getPopularMovies(page: "1")
         }
         }*/
        NavigationView{
            ScrollView(.vertical){
                LazyVGrid(columns: columns){
                    ForEach(obs.listMovies, id: \.id){ post in
                        NavigationLink(destination: DetailView(movie: post)){
                            VStack(alignment: .center){
                                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(post.posterPath)"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110.0, alignment: .center)
                                Text(post.title)
                                    .frame(width: 110.0, height: 50.0)
                            }
                            .padding(10)
                            .onAppear{
                                let con = obs.listMovies.count - 1
                                let id = obs.listMovies[con].id
                                if id == post.id{
                                    Task{
                                        await obs.getPopularMovies()
                                    }
                                }
                            }
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
        
    }
    
    /*func change(){
     chan.toggle()
     }*/
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
