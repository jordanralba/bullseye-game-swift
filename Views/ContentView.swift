//
//  ContentView.swift
//  Bullseye Game
//
//  Created by Jordan on 1/25/24.
//

import SwiftUI



struct ContentView: View {
    
    @State private var alertIsVisible: Bool = false
    @State private var leaderboardIsVisible: Bool = false
    @State private var sliderValue: Double = 0.0
    @State private var username: String = "Guest"
    @State private var game: Game = Game()
    
    @FocusState private var usernameFieldIsVisible: Bool = false


    var body: some View {
        VStack{
            HStack{
                Text("Welcome \(username)!")
                TextField("Welcome ", text:)
                Button(action:{
                    self.usernameFieldIsVisible = true
                    print(self.usernameFieldIsVisible)
                }){
                    Text("Leaderboard")
                        .foregroundColor(Color.white)
                }
                .alert(isPresented: $usernameFieldIsVisible,
                       content:{
                    return Alert(title: Text("Your Current Name Is"), message: Text(String(username)), dismissButton: .default(Text("Close")))
                })
                    .buttonStyle(.bordered)
                    .background(Color(red:0.502, green: 0.56, blue: 0.973))
                    .buttonBorderShape(.roundedRectangle)
                    .border(Color.white, width: 3)
                    .cornerRadius(12)
            }
            Text("Put The Bullseye As Close As You Can To")
                .bold()
                .font(.footnote)
            Text("\(game.target)")
                .fontWeight(.black)
                .font(.largeTitle)
                .kerning(-1.0)
                .lineSpacing(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1.0...100.0)
                Text("100")
            }
            Button(action:{
                self.alertIsVisible = true
                print(self.alertIsVisible)
                game.target = Int.random(in:1...100)            }){
                Text("Hit Me")
                    .foregroundColor(Color.white)
            }
            .alert(isPresented: $alertIsVisible,
                   content:{
                var roundedValue: Int = Int(self.sliderValue.rounded())
                var points: Int = game.points(sliderValue: roundedValue)
                return Alert(title: Text("Stopped On"), message: Text("\(roundedValue)" + "\n You Scored \(points) points!"), dismissButton: .default(Text("Start A New Round"), action: {
                    let leadBoard: [Int] = []
                    let scoreAmount = game.leaderboard.count - 1
                    if game.leaderboard.isEmpty{
                        game.leaderboard.append([username: points])
                        return
                        
                    }
                    for scoreIndex in 0...scoreAmount {
                        let name = username
                        print(name)
                        let score = game.leaderboard[scoreAmount - scoreIndex]
                        print(score)
                        //print(score[0])
                        let difference = points - game.leaderboard[scoreAmount - scoreIndex]
                        switch(difference/difference){
                        case -1: if leadBoard[scoreIndex] != 0 {
                            game.leaderboard.insert([username: points], at: scoreIndex)
                            game.leaderboard.removeLast()
                        }
                            break
                        default:
                            continue
                        }
                    }
                }))
            })
                .buttonStyle(.bordered)
                .background(Color(red:0.502, green: 0.56, blue: 0.973))
                .buttonBorderShape(.roundedRectangle)
                .border(Color.white, width: 3)
                .cornerRadius(12)
            Button(action:{
                self.leaderboardIsVisible = true
                print(self.leaderboardIsVisible)
            }){
                Text("Leaderboard")
                    .foregroundColor(Color.white)
            }
            .alert(isPresented: $leaderboardIsVisible,
                   content:{
                var highscore = game.leaderboard.first?.values
                print(highscore)
                return Alert(title: Text("Your Best Score Is"), message: Text("Test"), dismissButton: .default(Text("Close")))
            })
                .buttonStyle(.bordered)
                .background(Color(red:0.502, green: 0.56, blue: 0.973))
                .buttonBorderShape(.roundedRectangle)
                .border(Color.white, width: 3)
                .cornerRadius(12)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
