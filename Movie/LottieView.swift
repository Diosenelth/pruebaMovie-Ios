//
//  LottieView.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 22/06/22.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    var name = "laa"
    var loopMode: LottieLoopMode = .loop
    let animationView = AnimationView()
    var change:Bool
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        if change {
            let animation = Animation.named("error")
            context.coordinator.parent.animationView.animation = animation
            context.coordinator.parent.animationView.play()
            //context.coordinator.parent.animationView.pause()
        }else{
            let animation = Animation.named("see")
            context.coordinator.parent.animationView.animation = animation
            context.coordinator.parent.animationView.play()
            //context.coordinator.parent.animationView.play()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: LottieView
        
        init(_ parent: LottieView) {
            self.parent = parent
        }
    }
}
