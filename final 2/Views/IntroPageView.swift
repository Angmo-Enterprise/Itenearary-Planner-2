import SwiftUI

struct IntroPageView: View {
    
    @State private var slideIndex = 0
    @Environment(\.dismiss) var dismiss
    
    @State private var pages: [Page] = [
        Page(title: "Welcome to Itinerary Planner!", description: "A simple app to plan your itinerary", imageIndex: 0),
        Page(title: "Explore Destinations", description: "Discover exciting places to visit and create your travel plan", imageIndex: 1),
        Page(title: "Stay Organized", description: "Keep track of your itinerary and manage your travel details effortlessly", imageIndex: 2),
        Page(title: "Enjoy Your Journey", description: "Make the most of your travels with Itinerary Planner", imageIndex: 3),
        Page(title: "Share Your Adventures", description: "Connect with friends and share your travel experiences", imageIndex: 4),
        Page(title: "Create Lasting Memories", description: "Capture and cherish the moments from your amazing trips", imageIndex: 5)
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $slideIndex) {
                ForEach(0..<pages.count, id: \.self) { index in
                    VStack {
                        Spacer()
                        Image("Image\(pages[index].imageIndex)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .padding()
                        
                        Text("\(pages[index].title)")
                            .font(.title2)
                            .bold()
                            .padding()
                        
                        Text("\(pages[index].description)")
                            .frame(maxWidth: 300)
                        
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onTapGesture {
                if slideIndex == pages.count - 1 {
                    dismiss()
                } else {
                    slideIndex += 1
                }
            }
            
            PageControl(numberOfPages: pages.count, currentPage: slideIndex)
                .padding(.bottom, 20)
        }
    }
}

struct PageControl: View {
    var numberOfPages: Int
    var currentPage: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfPages) { page in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(page == currentPage ? .blue : .gray)
            }
        }
    }
}

struct Page1 {
    var title: String
    var description: String
    var imageIndex: Int
}

struct IntroPageView_Previews: PreviewProvider {
    static var previews: some View {
        IntroPageView()
    }
}
