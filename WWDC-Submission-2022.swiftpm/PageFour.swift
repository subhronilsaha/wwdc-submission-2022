//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 22/04/22.
//

import SwiftUI
import Combine

enum BezierMode {
    case linear
    case quad
    case cubic
}

struct PageFour: View {
    @Binding var currentPage: Int
    @State private var touchPoints = [CGPoint]()
    @State var allTouchPoints = [[CGPoint]]()
    @State private var nextStepLabelText = "Select point P0"
    @State var taskDone = false
    @State var currentBezierMode: BezierMode = .linear
    
    let stepsLabels = [
        "Select point P0",
        "Select control point C0",
        "Select control point C1",
        "Select point P1",
        "Tap anywhere to reset or tap Next"
    ]
    
    var body: some View {
        
        ZStack {
            BGGradientView()
            
            VStack(spacing: 30) {
                
                //MARK: Back Button
                HStack {
                    Button {
                        currentPage -= 1
                    } label: {
                        BackButtonView()
                    }
                    Spacer()
                }
                
                //MARK: Text content
                VStack(alignment: .leading, spacing: 20) {

                    Text("Drawing Time")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                }
                
                //MARK: Canvas
                ZStack {
                    
                    Image("swiftui-icon")
                        .resizable()
                        .frame(width: 400, height: 400, alignment: .center)
                        .opacity(0.3)
                    
                    //MARK: Canvas
                    
                    Canvas { context, size in
                        
                        //MARK: Create the paths (strokes)
                        for touchPointSet in allTouchPoints {
                            var path = Path()
                            switch touchPointSet.count {
                                case 2:
                                    if touchPointSet.count > 0 {
                                        path.move(to: touchPointSet[0])
                                        if touchPointSet.count > 1 {
                                            path.addLine(to: touchPointSet[1])
                                        }
                                    }
                                    
                                case 3:
                                    if touchPointSet.count > 0 {
                                        path.move(to: touchPointSet[0])
                                        if touchPointSet.count > 2 {
                                            path.addQuadCurve(to: touchPointSet[2], control: touchPointSet[1])
                                        }
                                    }
                                    
                                case 4:
                                    if touchPointSet.count > 0 {
                                        path.move(to: touchPointSet[0])
                                        if touchPointSet.count > 3 {
                                            path.addCurve(to: touchPointSet[3], control1: touchPointSet[1], control2: touchPointSet[2])
                                        }
                                    }
                                default:
                                    print("Default")
                                
                            }
                            print("path ",path.description)
                            context.stroke(path, with: .color(.orange), lineWidth: 5.0)
                            
                            //MARK: Create the point labels (P0, P1, etc.)
                            
                            for i in 0..<touchPointSet.count {
                                let point = touchPointSet[i]
                                var myPointLabel = "P0"
                                switch i {
                                case 0 :
                                    myPointLabel = "P0"
                                case 1 :
                                    if touchPointSet.count == 2 {
                                        myPointLabel = "P1"
                                    } else {
                                        myPointLabel = "C0"
                                    }
                                case 2 :
                                    if touchPointSet.count == 3 {
                                        myPointLabel = "P1"
                                    } else if touchPointSet.count == 4 {
                                        myPointLabel = "C1"
                                    }
                                case 3 :
                                    if touchPointSet.count == 4 {
                                        myPointLabel = "P1"
                                    }
                                default: myPointLabel = "P0"
                                }
                                let myText = Text(myPointLabel).foregroundColor(.white).font(.body)
                                context.draw(myText, at: point)
                            }
                        }
                                                
                    }
                    .frame(minWidth: 400, minHeight: 400)
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged({ value in
                            
                            //MARK: On change (tap or drag) on Canvas
                            
                            let newPoint = value.location
                            print("NEW TOUCH POINT: ", newPoint)
                            
                            if touchPoints.count == 0 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[1]
                                allTouchPoints.append(touchPoints)
                            }
                            else if touchPoints.count == 1 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[2]
                                
                                if currentBezierMode == .linear {
//                                    allTouchPoints.append(touchPoints)
                                    touchPoints.removeAll()
                                }
                                    let cnt = allTouchPoints.count
                                    if cnt > 0 {
                                        allTouchPoints[cnt-1].append(newPoint)
                                    }
                                
                            }
                            else if touchPoints.count == 2 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[3]
                                
                                if currentBezierMode == .quad {
//                                    allTouchPoints.append(touchPoints)
                                    touchPoints.removeAll()
                                }
                                    let cnt = allTouchPoints.count
                                    if cnt > 0 {
                                        allTouchPoints[cnt-1].append(newPoint)
                                    }
                                
                            }
                            else if touchPoints.count == 3 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[4]
                                
                                if currentBezierMode == .cubic {
//                                    allTouchPoints.append(touchPoints)
                                    touchPoints.removeAll()
                                }
                                
                                let cnt = allTouchPoints.count
                                if cnt > 0 {
                                    allTouchPoints[cnt-1].append(newPoint)
                                }
                                
                            }
                            else if touchPoints.count == 4 {
//                                allTouchPoints.append(touchPoints)
//                                touchPoints.removeAll()
//                                nextStepLabelText = stepsLabels[0]
                            }

                        })
                        .onEnded({ value in
                            
                        })
                    )
                }
                
                
                //MARK: Next Button
                HStack {
                    
                    HStack(spacing: 10) {
                        Button {
                            print("Linear bezier selected...")
                            currentBezierMode = .linear
                            
                        } label: {
                            Text("Linear")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(ColorPalette.lightGrey)
                                )
                        }
                        
                        Button {
                            print("Quad bezier selected...")
                            currentBezierMode = .quad
                            
                        } label: {
                            Text("Quadratic")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(ColorPalette.lightGrey)
                                )
                            
                        }
                        
                        Button {
                            print("Cubic bezier selected...")
                            currentBezierMode = .cubic
                            
                        } label: {
                            Text("Cubic")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(ColorPalette.lightGrey)
                                )
                            
                        }
                    }
                    
                    Spacer()
                    Button {
                        print("STARTING...")
                        currentPage += 1
                        
                    } label: {
                        NextButtonView(labelText: "Next")
                    }
                }
                
                Spacer()
                
            }
            .padding()
            
            if taskDone {
                CompletionAnimationView(labelText: "Great job!")
            }
        }
        

    }
    
    private func closeAnimAfterDelay() {
        taskDone = false
    }
}




