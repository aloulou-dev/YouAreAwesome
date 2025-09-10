//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Malek Aloulou on 9/1/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State var imageName = ""
    @State var imageNumber = 1
    @State var messageNumber = 0
    @State var lastMessageNumber = -1
    @State var lastImageNumber = -1
    @State var lastSoundNumber = -1
    @State private var audioPlayer:AVAudioPlayer!
    @State private var soundIsOn = true
    let numberOfImages = 9
    let numberOfSounds = 5
    
    var body: some View {
        
        
        VStack {
            Spacer()
            
            Text(message)
                .font(.title)
                .fontWeight(.ultraLight)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.default, value: message)
            
            Spacer()
            
            
            
            
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height:400)
                .clipShape(.rect(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: imageName)
            
            
            
            
            
            
            
            
            
            
            Spacer()
            
            
            
            HStack {
                Text("Sound On:")
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden().onChange(of: soundIsOn) {
                        
                        if audioPlayer != nil && audioPlayer.isPlaying{
                            audioPlayer.stop()
                        }
                        
                    }
                
                Button("Show message")
                {
                    let messages = ["You Are SUPER Awesome!",
                                    "You Are Great!",
                                    "You Are The Goat!",
                                    "Fabulous? That's You!",
                                    "You Are The Coolest Person EVER!"]
                    
                    
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBound: messages.count-1)
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBound: numberOfImages)
                    imageName = "image\(lastImageNumber)"
                    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBound: numberOfSounds)
                    if soundIsOn{
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
                .tint(.purple)
            }
        }
        .padding()
    }
    func playSound(soundName: String){
        if(audioPlayer != nil && audioPlayer.isPlaying){
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else{
            print(" 😡 could not read file named \(soundName)")
            return
        }
        
        do{
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 Error \(error.localizedDescription) creating audioplayer")
            
            
        }
    }
    
    func nonRepeatingRandom(lastNumber : Int, upperBound : Int) -> Int {
        var newNumber:Int
        repeat{newNumber = Int.random(in: 0..<upperBound)
        }while newNumber == lastMessageNumber
        return newNumber
    }
}

#Preview {
    ContentView()
}
