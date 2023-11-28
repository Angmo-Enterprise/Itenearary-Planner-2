//
//  IntroPageView.swift
//  final 2
//
//  Created by James Toh on 24/11/23.
//

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
        VStack{
            Spacer()
            Image("Image\(pages[slideIndex].imageIndex)")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            Text("\(pages[slideIndex].title)")
                .font(.title2)
                .bold()
                .padding()
            
            Text("\(pages[slideIndex].description)")
                .frame(maxWidth: 300)
            Spacer()
            
            Button{
                if slideIndex == pages.count-1{
                    dismiss()

                } else {
                    slideIndex += 1
                }
            } label: {
                HStack{
                    Text("Continue")
                    Image(systemName: "chevron.right")
                }
                .padding()
            }
            Spacer()
        }
    }
}


#Preview {
    IntroPageView()
}
