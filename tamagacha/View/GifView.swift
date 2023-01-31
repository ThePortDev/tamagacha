//
//  GifView.swift
//  tamagacha
//
//  Created by Hafa Bonati on 1/31/23.
//

import SwiftUI
import SwiftyGif

struct GifView: UIViewRepresentable {
    var name: String
    
    func makeUIView(context: Context) -> UIView {
        do {
            let imageView = UIImageView(gifImage: try UIImage(gifName: name))
            // image view changes here
            return imageView
        } catch {
            return UIProgressView()
        }
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
