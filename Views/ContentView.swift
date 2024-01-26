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
    
    @State private var usernameFieldIsVisible: Bool = false


    var body: some View {
        VStack{
            HStack{
                Text("Welcome \(username)!")
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
                }){
                Text("Hit Me")
                    .foregroundColor(Color.white)
            }
            .alert(isPresented: $alertIsVisible,
                   content:{
                var roundedValue: Int = Int(self.sliderValue.rounded())
                var points: Int = game.points(sliderValue: roundedValue)
                
                return Alert(title: Text("Stopped On"), message: Text("\(roundedValue)" + "\n You Scored \(points) points!"), dismissButton: .default(Text("Start A New Round"), action: {
                    game.target = Int.random(in:1...100)
                    if game.leaderboard.count < 5{
                        game.leaderboard.append((username, points))
                        game.leaderboard.sort(by:{$0.highscore > $1.highscore})
                        return
                    }
                    print("Hello")
                    for scoreIndex in 0...4 {
                        let name = username
                        print(name)
                        let score = game.leaderboard[4 - scoreIndex].highscore
                        print(score)
                        //print(score[0])
                        let difference = points - score //game.leaderboard[scoreAmount - scoreIndex].values
                        switch(difference/difference){
                        case -1:
                            game.leaderboard.insert((username, points), at: scoreIndex)
                            game.leaderboard.removeLast()
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
                let highscore = game.leaderboard.first!
                let score = highscore.highscore
                let player = highscore.name
                return Alert(title: Text(String(score)), message:Text("\(player) Has The Highest Score") .fontWeight(.black), dismissButton: .default(Text("Close")))
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
