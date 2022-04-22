import SwiftUI

struct ContentView: View {
    @State var currentPage = 3
    
    var body: some View {
        switch currentPage {
        case 0:
            StartPage(currentPage: $currentPage)
        case 1:
            PageOne(currentPage: $currentPage)
        case 2:
            PageTwo(currentPage: $currentPage)
        case 3:
            PageThree(currentPage: $currentPage)
        case 4:
            PageFour(currentPage: $currentPage)
        case 5:
            PageFive(currentPage: $currentPage)
        default:
            StartPage(currentPage: $currentPage)
        }
    }
}

