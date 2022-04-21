//
//  TabBarView.swift
//  TabBarRounded
//
//  Created by Shreyas Vilaschandra Bhike on 21/04/22.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab = "monkey"
    @Binding var pages: [TabBarPage]

    
    
    init(pages: Binding<[TabBarPage]>) {
        UITabBar.appearance().isHidden = true
        self._pages = pages
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                ForEach(pages) { item in
                    AnyView(_fromValue: item.page)
                        
                        .tabItem{
                            EmptyView()
                        }.tag(item.tag)
                }
            }
            
            HStack {
                ForEach(pages) { item in
                    Button(action: {
                        self.selectedTab = item.tag
                    }) {
                        ZStack {

                            
                            Image(item.icon)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(item.color)
                                .imageScale(.large)
                                .padding(7)
                                .background(self.selectedTab == item.tag ? Color.gray : item.color )
                                
                        }
                    }
                    .frame(width: 140, height: 100)
                    
                  
                    
                }
            }
            .padding(5)
            .background(Color.gray)
            .clipShape(
                CustomShape(
                    corner: [.topRight,.topLeft], radii: 35
                    ))
            .padding()
            .offset(x: 0, y: 50)
           
        }
        
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(pages: .constant([
            
            TabBarPage(page: HomeView(),
                       
                       icon: "monkey1",
                       tag: "monkey1",
                       color: .white.opacity(0) ),
            TabBarPage(page: DetailView(),
                       
                       icon: "monkey2",
                       tag: "monkey2",
                       color:  .white.opacity(0) ),
                                     
            
            TabBarPage(page: ProfileView(),
                       icon: "monkey3",
                       tag: "monkey3",
                       color:  .white.opacity(0) )]))
    }
}

struct TabBarPage: Identifiable {
    var id = UUID()
    var page: Any
    var icon: String
    var tag: String
    var color: Color
}


struct HomeView: View {
    var body: some View {
        Text("Monkey 1")
            .font(.largeTitle)
            .padding()
    }
}


struct DetailView: View {
    var body: some View {
        Text("Monkey 2")
            .font(.largeTitle)
            .padding()
    }
}


struct ProfileView: View {
    var body: some View {
        Text("Monkey 3")
            .font(.largeTitle)
            .padding()
    }
}


struct CustomShape: Shape {
    var corner : UIRectCorner
    var radii : CGFloat

    func path(in rect : CGRect) -> Path{
        let path = UIBezierPath(
            roundedRect : rect,
            byRoundingCorners: corner,
            cornerRadii: CGSize(
            width: radii, height: radii))

        return Path(path.cgPath)
    }
}
