//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 22/04/22.
//

import SwiftUI

struct BGGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [ColorPalette.lightBlue, ColorPalette.darkBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        
    }
}
