import SwiftUI
import Combine

struct PageOne: View {
    @Binding var currentPage: Int
    @EnvironmentObject var audioManager: AudioManager
    @State private var thickness: Double = 1.0
    @State private var touchPoints = [CGPoint]()
    @State private var pointColor1 = Color.blue
    @State private var pointColor2 = Color.blue
    @State private var nextStepLabelText = "Select point P0"
    @State var taskDone = false
    
    let stepsLabels = [
        "Select point P0",
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

                    HStack {
                        Text("Linear Bézier Curves")
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        WaveForm(color: .purple, color2: .pink, color3: .orange, amplitude: 0, isReversed: false)
                    }
                    .frame(height: 50)
                    
                        
                    Text("This is the simplest kind of Bézier curve, where, given 2 distinct points P0 and P1, a linear Bézier curve is simply a straight line between those two points.\n\nLets try to create a Linear Bezier Curve between points P0 & P1. To do this first tap anywhere (in the free space) below to create point P0, then tap again to create point P1. A linear bezier curve will be created joining these 2 points")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                    
//                    Text("")
//                        .foregroundColor(.white)
//                        .font(.system(size: 22))
                }
                
                //MARK: Canvas
                
                ZStack {
                    
                    Canvas { context, size in
                        
                        var path = Path()
                        if touchPoints.count > 0 {
                            path.move(to: touchPoints[0])
                            if touchPoints.count > 1 {
                                path.addLine(to: touchPoints[1])
                            }
                        }
                        print("path ",path.description)
                        context.stroke(path, with: .color(.orange), lineWidth: 5.0)
                        
                        for i in 0..<touchPoints.count {
                            let point = touchPoints[i]
                            let myPointLabel = "P\(i)"
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
                                
                            } else if touchPoints.count == 1 {
                                touchPoints.append(newPoint)
                                taskDone = true
                                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                    self.closeAnimAfterDelay()
                                }
                                nextStepLabelText = stepsLabels[2]
                            }
                            else if touchPoints.count == 2 {
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


