//
//  searchBarView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import SwiftUI

struct searchBarView: View {
    
    
    @Binding var searchText:String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.appTheme.secondaryTextColor : Color.appTheme.accent)
            TextField("Search by name or symbol...",text: $searchText)
                .foregroundColor(Color.appTheme.accent)
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x:10)
                    .foregroundColor(Color.appTheme.accent)
                    .opacity(searchText.isEmpty ? 0 : 1)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    
                    }
                ,alignment: .trailing
                )
        }.font(.headline)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.appTheme.background)
                    .shadow(color: Color.appTheme.accent.opacity(0.15), radius: 10,x:0,y:0)
            )
            .padding()
    }
}

struct searchBarView_Previews: PreviewProvider {
    static var previews: some View {
        searchBarView(searchText: .constant(""))
    }
}
