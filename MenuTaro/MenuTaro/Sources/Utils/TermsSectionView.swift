struct TermsSectionView: View {
    let section: TermsSection

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(section.title)
                .font(.headline.bold())
            ForEach(section.body, id: \.self) { paragraph in
                Text(paragraph)
                    .font(.subheadline)
            }
        }
    }
}
