import SwiftUI

struct ConceptBookDetailView: View {
    @ObservedObject var conceptBookDetailViewModel: ConceptBookDetailViewModel
    
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                
                Spacer().frame(height: 30)
                ConceptBookDetailTitle(subjectName: conceptBookDetailViewModel.subject.name)
                ScrollView {
                    ConceptBookDetailMain(conceptBookDetailViewModel: conceptBookDetailViewModel, subjectName: conceptBookDetailViewModel.subject.name)
                }
            }
            .navigationTitle(conceptBookDetailViewModel.subject.name)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
    }
}

// MARK: - ConceptBookDetailTitle
struct ConceptBookDetailTitle: View {
    let subjectName: String
    
    var body: some View {
        VStack {
            Text(subjectName.contains("SQL") ? "2과목" : "1과목")
                .font(.system(size: 23, weight: .bold))
        }
        .padding()
    }
}
// MARK: - SelectConceptView
struct SelectConceptView: View {
    let item: SelectableBox
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(8)
                Image("Property")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(8)
            }
        }
    }
}
// MARK: - ConceptBookDetailMain
struct ConceptBookDetailMain: View {
    @ObservedObject var conceptBookDetailViewModel: ConceptBookDetailViewModel
    @State private var selectedTopic: String? = nil
    let subjectName: String
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 160, height: 200)
            
            Text(conceptBookDetailViewModel.subject.name)
                .font(.system(size: 18, weight: .bold))
            
            Spacer().frame(height: 50)
            
            // 주제 목록을 순회하며 NavigationLink 생성
            ForEach(conceptBookDetailViewModel.subject.topics, id: \.self) { topic in
                NavigationLink(
                    destination: ConceptBookMainView(conceptBookMainViewModel: ConceptBookMainViewModel(topic: topic, subjectType: subjectName)),
                    tag: topic,
                    selection: $selectedTopic
                ) {
                    SelectConceptView(item: SelectableBox(title: topic, isSelected: false)) {
                        self.selectedTopic = topic
                    }
                    .frame(height: 50)
                    .background(.white)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.vertical, 4)
                    
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}


// MARK: - Preview
struct ConceptBookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConceptBookDetailView(conceptBookDetailViewModel: ConceptBookDetailViewModel(subject: Subject(name: "데이터 모델링의 이해", topics: ["데이터모델의 이해", "엔티티", "속성", "관계", "식별자"])))
    }
}
