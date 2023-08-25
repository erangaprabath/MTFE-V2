//
//  SettingsView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-25.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youTube = URL(string: "sett")!
    let mylinkedin = URL(string: "https://www.linkedin.com/in/eranga-prabath-a35906199")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let modelCreator = URL(string: "https://quicktype.io")!
    let myGitHubUrl = URL(string: "https://github.com/erangaprabath")!
    var body: some View {
        NavigationView {
            List{
                appDetails
                CoinGecko
                Dev
            }
            .accentColor(.blue)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView{
    private var appDetails:some View{
        Section(header: Text("application")) {
            VStack(alignment: .leading){
                Image("1671692610539")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This App Is Not Using For SCAM. It's Just Build For Learn About MVVM Architecture By Me (Inspired and idea from SwiftFul Thinking)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.appTheme.accent)
                
            }
            .padding(.vertical)
           
            Link(destination: modelCreator) {
                Text("Model Created By 𝌭")
            }
         
        }
    }
    private var CoinGecko:some View{
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("CoinGecko Providing Free Testable API For Developers To Test Crypto Data (Limitaion 10-30 API call per min)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.appTheme.accent)
                
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🦎",destination: coinGeckoURL)
        }

    }
    private var Dev:some View{
        Section(header: Text("Developer")) {
            VStack(alignment: .leading){
                HStack {
                    Image("bfd5d892-21d7-47e1-8738-d164b50c78dc 2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack(alignment:.leading){
                        Text("Eranga Prabath")
                        Text("Associate Mobile Dev (iOS)")
                        Text("MiHCM")

                        Spacer()
                    }.padding(.vertical)
                        .font(.callout)
                        .foregroundColor(Color.appTheme.accent)
                }
                Text("This App Developed by Eranga Prabath. I Used 100% Swift For Develop This App")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.appTheme.accent)
                
            }
            .padding(.vertical)
            Link(destination: myGitHubUrl) {
             Text("GitHub 👨🏻‍💻")
            }
            Link("Linkedin 🌎",destination: mylinkedin)
        }

    }

}
