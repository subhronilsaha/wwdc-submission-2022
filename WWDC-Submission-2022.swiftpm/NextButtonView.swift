import SwiftUI

struct NextButtonView: View {
    @State var labelText = "START"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(ColorPalette.lightGrey)
                .frame(width: 200, height: 60, alignment: .center)
            Text(labelText)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}
