import SwiftUI

struct ContentView: View {
    @State var currentPage = 0
    @StateObject var audioManager = AudioManager()
    var body: some View {
        ZStack {
            switch currentPage {
            case 0:
                StartPage(currentPage: $currentPage)
                    .environmentObject(audioManager)
            case 1:
                PageOne(currentPage: $currentPage)
                    .environmentObject(audioManager)
            case 2:
                PageTwo(currentPage: $currentPage)
                    .environmentObject(audioManager)
            case 3:
                PageThree(currentPage: $currentPage)
                    .environmentObject(audioManager)
            case 4:
                PageFour(currentPage: $currentPage)
                    .environmentObject(audioManager)
            case 5:
                PageFive(currentPage: $currentPage)
                    .environmentObject(audioManager)
            default:
                StartPage(currentPage: $currentPage)
                    .environmentObject(audioManager)
            }
            
        }
        .onAppear {
            audioManager.startPlayer()
        }
        
    }
    
}

