//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 23/04/22.
//

import SwiftUI

struct WaveForm : View {
    
    var color : Color
    var color2: Color
    var color3: Color
    var amplitude: CGFloat
    var isReversed: Bool
    
    var body: some View {
        
        TimelineView(.animation) { timeLine in
            
            Canvas { context, size in
                
                let timeNow = timeLine.date.timeIntervalSinceReferenceDate
                
                // Animate the wave based on current Time
                let angle = timeNow.remainder(dividingBy: 2)
                let offset = angle * size.width
                
                let path1 = getPath(size: size)

                context.translateBy(x: isReversed ? -offset : offset, y: 0)
                
                context.stroke(path1, with: .color(color), lineWidth: 10.0)
                
                context.translateBy(x: -size.width, y: 0)

                context.stroke(path1, with: .color(color2), lineWidth: 10.0)

                context.translateBy(x: size.width * 2, y: 0)

                context.stroke(path1, with: .color(color3), lineWidth: 10.0)
                
                
            }
            
        }
        
    }
    
    func getPath(size: CGSize) -> Path {
        let width = size.width
        let height = size.height
        let midWidth = width / 2
        let midHeight = height / 2
        var path = Path()
        path.move(to: CGPoint(x: 0, y: midHeight))
        path.addCurve(
            to: CGPoint(
                x: width,
                y: midHeight),
                control1:
                    CGPoint(x: width * 0.5, y: midHeight + amplitude),
                control2:
                    CGPoint (x: width * 0.5, y: midHeight - amplitude))
        return path
    }
    
}
