
import SwiftUI
import Combine

struct PageThree: View {
    @Binding var currentPage: Int
    @EnvironmentObject var audioManager: AudioManager
    @State private var thickness: Double = 1.0
    @State private var touchPoints = [CGPoint]()
    @State private var pointColor1 = Color.blue
    @State private var controlPointColor2 = Color.green
    @State private var pointColor2 = Color.blue
    @State private var nextStepLabelText = "Select point P0"
    @State var taskDone = false
    
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
                
                //MARK: Text content
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack(spacing: 20) {
                        Text("Cubic Bézier Curves")
                            .foregroundColor(Color(ColorPalette.hexStringToUIColor(hex: "#81BEA1")))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                                                
                        WaveForm(color: .purple, color2: .pink, color3: .orange, amplitude: 50, isReversed: false)
                    }
                    .frame(height: 40)
                        
                    Text("A smooth curve is created between two points with the help of two control points\n\nLets try to create a Cubic Bezier Curve between two points P0 & P1 in the free space below. You can try the following:\n1. Tap to create a point P0.\n2. Select control points C1 & C2.\n3. Select point P1.")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                
                }
                
                //MARK: Canvas
                ZStack {
                    Canvas { context, size in
                        var path = Path()
                        if touchPoints.count > 0 {
                            path.move(to: touchPoints[0])
                            if touchPoints.count > 3 {
                                path.addCurve(to: touchPoints[3], control1: touchPoints[1], control2: touchPoints[2])
                                
                                var path1 = Path()
                                path1.move(to: touchPoints[0])
                                path1.addLine(to: touchPoints[1])
                                context.stroke(path1, with: .color(.red), lineWidth: 1.0)
                                
                                var path2 = Path()
                                path2.move(to: touchPoints[1])
                                path2.addLine(to: touchPoints[2])
                                context.stroke(path2, with: .color(.red), lineWidth: 1.0)
                                
                                var path3 = Path()
                                path3.move(to: touchPoints[2])
                                path3.addLine(to: touchPoints[3])
                                context.stroke(path3, with: .color(.red), lineWidth: 1.0)
                                
                            }
                        }
                        print("path ",path.description)
                        context.stroke(path, with: .color(.orange), lineWidth: 5.0)
                        
                        for i in 0..<touchPoints.count {
                            let point = touchPoints[i]
                            var myPointLabel = "P0"
                            switch i {
                            case 0 : myPointLabel = "P0"
                            case 1 : myPointLabel = "C0"
                            case 2 : myPointLabel = "C1"
                            case 3 : myPointLabel = "P1"
                            default: myPointLabel = "P0"
                            }
                            var myText = Text(myPointLabel).foregroundColor(.white).font(.largeTitle)
                            context.draw(myText, at: point)
                        }
                                                
                    }
                    .frame(minWidth: 400, minHeight: 400)
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged({ value in
                            let newPoint = value.location
                            print("NEW TOUCH POINT: ", newPoint)
                            
                            if touchPoints.count == 0 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[1]
                                
                            }
                            else if touchPoints.count == 1 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[2]
                            }
                            else if touchPoints.count == 2 {
                                touchPoints.append(newPoint)
                                nextStepLabelText = stepsLabels[3]
                            }
                            else if touchPoints.count == 3 {
                                touchPoints.append(newPoint)
                                taskDone = true
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                    self.closeAnimAfterDelay()
                                }
                                nextStepLabelText = stepsLabels[4]
                            }
                            else if touchPoints.count == 4 {
                                touchPoints.removeAll()
                                nextStepLabelText = stepsLabels[0]
                            }

                        })
                        .onEnded({ value in
                            
                        })
                    )
                }
                
                
                //MARK: Next Button
                HStack {
                    Text(nextStepLabelText)
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
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




