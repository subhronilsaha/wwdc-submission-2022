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

struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}

struct PageFour: View {
    @Binding var currentPage: Int
    @EnvironmentObject var audioManager: AudioManager
    @State private var touchPoints = [CGPoint]()
    @State var allTouchPoints = [Line]()
    @State private var nextStepLabelText = "Select point P0"
    @State var taskDone = false
    @State var currentBezierMode: BezierMode = .linear
    let colorPickerArr: [Color] = [.red, .blue, .yellow, .pink, .orange, .brown, .white]
    @State var selectedColorIndex = 0
    @State var isEditingLine = false
    
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
                    // Back Button
                    Button {
                        currentPage -= 1
                    } label: {
                        BackButtonView()
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        // UNDO Button
                        Button {
                            print("Undo option selected...")
                            if allTouchPoints.count > 0 {
                                print("allTouchPoints: ", allTouchPoints, " | Last elem: ", allTouchPoints[allTouchPoints.count-1])

                                allTouchPoints.popLast()
                            }
                            
                        } label: {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.pink)
                                    .frame(width: 120, height: 50)
                                HStack(spacing: 10) {
                                    Image(systemName: "arrow.turn.up.left")
                                        .foregroundColor(.white)
                                    Text("Undo")
                                        .foregroundColor(.white)
                                }
                                .padding()
                            }
                            
                        }
                        
                        Button {
                            audioManager.toggleMusicPlayer()
                        } label: {
                            
                            HStack(spacing: 10) {
                                Text("Audio\nControls")
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                                
                                audioManager.isMusicPlaying ?
                                Image(systemName: "pause.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .foregroundColor(.white)
                                :
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                                    .foregroundColor(.white)
                            }
                            
                        }
                    }
                    
                }
                
                //MARK: Text content
                VStack(alignment: .leading, spacing: 20) {
                    Text("Drawing Time")
                        .foregroundColor(Color(ColorPalette.hexStringToUIColor(hex: "#8BBDCC")))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("You've reached the final step! Let's practice what we learnt about bezier curves here. Trace over the Swift logo outline with Bezier curves. You can use any of the three types of curves and you can also pick a color for your line! Enjoy!")
                        .foregroundColor(.white)
                        .font(.title2)
                    
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
                        for aTouchPointSet in allTouchPoints {
                            var path = Path()
                            let touchPointSet = aTouchPointSet.points
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
                            context.stroke(path, with: .color(aTouchPointSet.color), lineWidth: 5.0)
                            
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
                            
                            // Will add the start point (1st) here
                            if touchPoints.count == 0 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[1]
                                let newLine = Line(points: touchPoints, color: colorPickerArr[selectedColorIndex], lineWidth: 3.0)
                                allTouchPoints.append(newLine)
                            }
                            // Will add the 2nd point here
                            else if touchPoints.count == 1 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[2]
                                
                                if currentBezierMode == .linear {
                                    touchPoints.removeAll()
                                }
                                let cnt = allTouchPoints.count
                                if cnt > 0 {
                                    allTouchPoints[cnt-1].points.append(newPoint)
                                    allTouchPoints[cnt-1].color = colorPickerArr[selectedColorIndex]
                                }
                                
                            }
                            // Will add the 3rd point here
                            else if touchPoints.count == 2 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[3]
                                
                                if currentBezierMode == .quad {
                                    touchPoints.removeAll()
                                }
                                let cnt = allTouchPoints.count
                                if cnt > 0 {
                                    allTouchPoints[cnt-1].points.append(newPoint)
                                    allTouchPoints[cnt-1].color = colorPickerArr[selectedColorIndex]
                                }
                                
                            }
                            // Will add the 4th point here
                            else if touchPoints.count == 3 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[4]
                                
                                if currentBezierMode == .cubic {
                                    touchPoints.removeAll()
                                }
                                
                                let cnt = allTouchPoints.count
                                if cnt > 0 {
                                    allTouchPoints[cnt-1].points.append(newPoint)
                                    allTouchPoints[cnt-1].color = colorPickerArr[selectedColorIndex]
                                }
                                
                            }
                            // Will clear (but not used here)
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
                
                
                VStack(spacing: 20) {
                    
                    //MARK: Color Picker
                    HStack(spacing: 10) {
                        Text("Color Picker: ")
                            .foregroundColor(.white)
                        ForEach(0..<colorPickerArr.count) { i in
                            Button {
                                selectedColorIndex = i
                            } label: {
                                Circle()
                                    .strokeBorder((selectedColorIndex == i) ? Color.white : Color.clear, lineWidth: 2)
                                    .background(Circle().fill(colorPickerArr[i]))
                                    .frame(width: 40, height: 40)
                                    
                                    
                            }
                        }
                        
                        Spacer()
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
                                            .foregroundColor((currentBezierMode == .linear ? .green : ColorPalette.lightGrey))
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
                                            .foregroundColor((currentBezierMode == .quad ? .green : ColorPalette.lightGrey))
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
                                            .foregroundColor((currentBezierMode == .cubic ? .green : ColorPalette.lightGrey))
                                    )
                                
                            }
                            
                            Button {
                                print("Clear option selected...")
                                allTouchPoints.removeAll()
                                
                            } label: {
                                Text("Clear")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.pink)
                                    )
                                
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            print("STARTING...")
                            taskDone = true
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                self.closeAnimAfterDelay()
                            }
                            
                        } label: {
                            NextButtonView(labelText: "Next")
                        }
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
        currentPage += 1
    }
}




