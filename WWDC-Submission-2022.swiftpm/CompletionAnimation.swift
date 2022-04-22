import SwiftUI

struct CompletionAnimationView: View {
    @State var circleColorChanged = false
    @State var heartColorChanged = false
    @State var heartSizeChanged = false
    @State var labelText = "Congratulations!"
    
    let labelTexts = ["Awesome!", "Great!", "Cool!"]
    
    var body: some View {
              
        ZStack {
            Color.black
                .opacity(0.2)
                .blur(radius: 100)
            
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(circleColorChanged ? Color(.systemGray5) : .green)
                        .animation(.default)
                    
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(heartColorChanged ? .green : .white)
                        .font(.system(size: 100))
                        .scaleEffect(heartSizeChanged ? 2.0 : 1.0)
                        .animation(.default)
                }.onAppear {
                    circleColorChanged = true
                    heartSizeChanged = true
                    heartColorChanged = true
                }
                
                Spacer()
                    .frame(height: 20)
                
                Text(labelTexts[Int.random(in: 0..<labelTexts.count)])
                    .foregroundColor(.indigo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .background(
                        .regularMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                    )
            }
            .padding()
        }
            
        
        
        
    }
}
