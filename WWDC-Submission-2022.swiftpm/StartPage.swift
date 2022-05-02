import SwiftUI

struct StartPage: View {
    @Binding var currentPage: Int
    @EnvironmentObject var audioManager: AudioManager
    
    let colors = [
        Color(ColorPalette.hexStringToUIColor(hex: "#F2BBA7")),
//        Color(ColorPalette.hexStringToUIColor(hex: "#F38C4E")),
//        Color(ColorPalette.hexStringToUIColor(hex: "#F46D3D")),
        Color(ColorPalette.hexStringToUIColor(hex: "#F2766B")),
        Color(ColorPalette.hexStringToUIColor(hex: "#81BEA1")),
        Color(ColorPalette.hexStringToUIColor(hex: "#8BBDCC"))
    ]
    
    let bgColors = [
        Color(ColorPalette.hexStringToUIColor(hex: "#ff9966")),
        Color(ColorPalette.hexStringToUIColor(hex: "#ff5e62"))
    ]
    
    var body: some View {        
        ZStack {
            BGGradientView(
                color1: bgColors[0],//ColorPalette.lightPink1,
                color2: bgColors[1])//ColorPalette.lightPink2)
            
            VStack {
                WaveForm(color: .purple, color2: .pink, color3: colors[0], amplitude: 200, isReversed: true)
                
                WaveForm(color: colors[1], color2: colors[3], color3: .orange, amplitude: 200, isReversed: false)
                
                WaveForm(color: .purple, color2: colors[1], color3: .orange, amplitude: 200, isReversed: false)
                
                WaveForm(color: colors[2], color2: .pink, color3: .orange, amplitude: 200, isReversed: true)
            }
            
            
            VStack(alignment: .center) {
                Spacer()
                
                ZStack {
                    
                    VStack(alignment: .center) {
                        
                        Image("my-memoji-hi")
                            .resizable()
                            .frame(width: 150, height: 150, alignment: .center)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Text("Bézier Curves")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Text("An interactive playground app to teach you about the magic of Bézier curves on the SwiftUI Canvas!")
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        HStack(spacing: 10) {
                            Image("iphone-emoji")
                                .resizable()
                                .frame(width: 80, height: 100, alignment: .center)
                            
                            Text("Please view this on an iPad simulator on Xcode 13.3 in Portrait orientation. Thank you!")
                                .multilineTextAlignment(.leading)
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Button {
                            print("STARTING...")
                            currentPage += 1
                            
                        } label: {
                            NextButtonView()
                        }
                    }
                    .padding(50)
                    .background(RoundedRectangle(cornerRadius: 50).foregroundColor(Color.pink.opacity(0.7)))

                }
                
                Spacer()
                
                HStack {
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

                
            }.padding(50)
        }
    }
}
