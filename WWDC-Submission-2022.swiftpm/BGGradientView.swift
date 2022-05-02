//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 22/04/22.
//

import SwiftUI

struct BGGradientView: View {
    var color1 = ColorPalette.lightBlue
    var color2 = ColorPalette.darkBlue
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        
    }
}
