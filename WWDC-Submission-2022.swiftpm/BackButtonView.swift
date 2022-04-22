import SwiftUI

struct BackButtonView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 50, alignment: .center)
                .foregroundColor(ColorPalette.lightGrey)
            HStack(spacing: 10) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                Text("Back")
                    .foregroundColor(.white)
            }
        }
    }
}
