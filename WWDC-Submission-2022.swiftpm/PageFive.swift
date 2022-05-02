//
//  File.swift
//  WWDC-Submission-2022
//
//  Created by Subhronil Saha on 22/04/22.
//

import SwiftUI

struct PageFive: View {
    @Binding var currentPage: Int
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        ZStack {
            BGGradientView()
            
            VStack(alignment: .leading) {
                //MARK: Back Button
                HStack {
                    Button {
                        currentPage -= 1
                    } label: {
                        BackButtonView()
                    }
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
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Hi there! ✌🏼")
                                .foregroundColor(.yellow)
                                .font(.system(size: 60))
                                .fontWeight(.bold)
                            
                            Spacer()
                                .frame(height: 20)
                            
                            Text("I'm Subhronil Saha")
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                            
                            Spacer()
                                .frame(height: 20)
                            
                            Text("I love building apps for iOS 🧑🏻‍💻📱")
                                .foregroundColor(.yellow)
                                .font(.system(size: 25))
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                        
                        
                        ZStack {
                            
                            WaveForm(color: .purple, color2: .pink, color3: .orange, amplitude: 80, isReversed: false)
                            
                            Image("myphoto")
                                .resizable()
                                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(100)
                                .animation(.linear)
                        }
                        
                    }
                    
//                    Spacer()
//                        .frame(height: 20)
//
//                    Spacer()
//                        .frame(height: 30)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("And you just completed exploring my Swift Playground app! 🎉")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack(alignment: .leading, spacing: 30) {
                        
                        Text("I hope this was a fun experience for you!")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .multilineTextAlignment(.leading)
                        
                        Text("Looking forward to a fun WWDC week this year!")
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                            .multilineTextAlignment(.leading)
                        
                        Text("Thank you & Cheers!")
                            .foregroundColor(.yellow)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                    }
                    
                    Spacer()
                    
                }
                
                Spacer()
                
            }
            .padding(30)
        }
    }
}
