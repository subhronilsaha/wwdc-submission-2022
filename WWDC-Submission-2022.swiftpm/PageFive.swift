//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 22/04/22.
//

import SwiftUI

struct PageFive: View {
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack {
            BGGradientView()
            
            VStack {
                //MARK: Back Button
                HStack {
                    Button {
                        currentPage -= 1
                    } label: {
                        BackButtonView()
                    }
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Image("myphoto")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(100)
                        .animation(.linear)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Hi there! ✌🏼")
                        .foregroundColor(.yellow)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("I'm Subhronil Saha")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("And you just completed exploring my Swift Playground! 🎉")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Text("Thank you!")
                            .foregroundColor(.yellow)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Text("I hope this was a fun experience for you!")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.center)
                        
                    }
                }
                
                Spacer()
                
                
            }
            .padding(30)
        }
    }
}
