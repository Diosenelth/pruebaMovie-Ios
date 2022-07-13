//
//  LoadingView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 13/07/22.
//

import Foundation
import SwiftUI

struct LoadingView: View{
    var change: Bool
    var body: some View{
        VStack{
            LottieView(change: change)
        }
    }
}
