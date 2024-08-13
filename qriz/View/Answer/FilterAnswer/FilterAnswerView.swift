import SwiftUI

struct FilterAnswerView: View {


    var body: some View {
        VStack {
            FilterAnswerTitleView()
            FilterAnswermainView()
            FilterAnswerOkButton()

            
            Spacer()
        }
        .padding()
    }
}

struct CategoryButton: View {
    let title: String
    @Binding var selected: String?
    @Binding var allSelected: Set<String>
    
    var body: some View {
        Button(action: {
            if title == "전체" {
                if allSelected.contains("전체") {
                    allSelected.remove("전체")
                } else {
                    allSelected = ["전체"]
                }
            } else {
                if allSelected.contains(title) {
                    allSelected.remove(title)
                } else {
                    allSelected.insert(title)
                    allSelected.remove("전체")
                }
            }
        }) {
            Text(title)
                .font(.system(size: 12))
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(allSelected.contains(title) ? Color.white : Color(hex: "#F0F4F7"))
                .foregroundColor(allSelected.contains(title) ? Color.blue : Color.black)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(allSelected.contains(title) ? Color.blue : Color.clear, lineWidth: 1)
                )
        }
    }
}

//MARK: FilterAnswerTitle
struct FilterAnswerTitleView: View {
    var body: some View {
        VStack{
            Text("카테고리를 선택해주세요.")
                .font(.headline)
                .padding(.top, 20)
        }
    }
}
//MARK: FilterAnswermain
struct FilterAnswermainView: View {
    @State private var selectedCategory1: String? = nil
    @State private var selectedCategory2: String? = nil
    @State private var selectedCategories1: Set<String> = []
    @State private var selectedCategories2: Set<String> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("데이터 모델링의 이해")
                .font(.subheadline)
                .fontWeight(.bold)
            
            VStack {
                HStack {
                    CategoryButton(title: "전체", selected: $selectedCategory1, allSelected: $selectedCategories1)
                    CategoryButton(title: "데이터 모델의 이해", selected: $selectedCategory1, allSelected: $selectedCategories1)
                    CategoryButton(title: "엔티티", selected: $selectedCategory1, allSelected: $selectedCategories1)
                    CategoryButton(title: "속성", selected: $selectedCategory1, allSelected: $selectedCategories1)
                    Spacer()
                }
                HStack {
                    CategoryButton(title: "관계", selected: $selectedCategory1, allSelected: $selectedCategories1)
                    CategoryButton(title: "식별자", selected: $selectedCategory1, allSelected: $selectedCategories1)
                    Spacer()
                }
            }
        }
        .padding()

        // Second category section
        VStack(alignment: .leading, spacing: 10) {
            Text("데이터 모델과 성능")
                .font(.subheadline)
                .fontWeight(.bold)
            ScrollView(.horizontal, showsIndicators: false) {
                VStack{
                    HStack {
                        CategoryButton(title: "전체", selected: $selectedCategory2, allSelected: $selectedCategories2)
                        CategoryButton(title: "정규화", selected: $selectedCategory2, allSelected: $selectedCategories2)
                        CategoryButton(title: "관계와 조인의 이해", selected: $selectedCategory2, allSelected: $selectedCategories2)
                        Spacer()
                    }
                    HStack {
                        CategoryButton(title: "모델이 표현하는 트랜잭션의 이해", selected: $selectedCategory2, allSelected: $selectedCategories2)
                        CategoryButton(title: "NULL 속성의 이해", selected: $selectedCategory2, allSelected: $selectedCategories2)
                        Spacer()
                    }
                    HStack {
                        CategoryButton(title: "본질식별자 vs 인조식별자", selected: $selectedCategory2, allSelected: $selectedCategories2)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}
//MARK: FilterAnswer ok button
struct FilterAnswerOkButton: View {
    var body: some View {
        Button(action: {
            // 적용하기 버튼 액션
        }) {
            Text("적용하기")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.customButton)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
}
#Preview {
    FilterAnswerView()
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
