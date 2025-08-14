struct AppFont: ViewModifier {
    var size: CGFloat
    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: .regular))
    }
}
extension View {
    func appFont(_ size: CGFloat) -> some View {
        self.modifier(AppFont(size: size))
    }
}
