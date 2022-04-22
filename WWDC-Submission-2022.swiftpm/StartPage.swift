import SwiftUI

struct StartPage: View {
    @Binding var currentPage: Int
    
    var body: some View {        
        ZStack {
            BGGradientView()
            
            VStack(alignment: .center) {
                Spacer()
                
                Text("Bézier Curves")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 30)
                
                Text("An interactive playground to teach you about the magic of Bézier curves!")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 50)
                
                Button {
                    print("STARTING...")
                    currentPage += 1
                    
                } label: {
                    NextButtonView()
                }
                
                Spacer()
                
            }.padding(50)
        }
    }
}
