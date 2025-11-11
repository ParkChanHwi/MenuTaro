import SwiftUI

struct CardFrontView: View {
    let food: FoodCard
    
    var body: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width
            let cardHeight = geo.size.height
            
            // 피그마 기준 (280 x 480)
            let baseWidth: CGFloat = 280
            let baseHeight: CGFloat = 480
            
            // 스케일 비율
            let scaleX = cardWidth / baseWidth
            let scaleY = cardHeight / baseHeight
            
            ZStack {
                // 카드 배경
                Image("cardfront")
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                
                // 카테고리
                Text(food.category.rawValue)
                    .font(.system(size: 18 * scaleY, weight: .semibold))
                    .foregroundColor(.white)
                    .position(
                        x: cardWidth / 2,
                        y: 70 * scaleY
                    )
                Spacer()
                // 음식 이미지
                Image(food.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150 , height: 150 )
                    .clipShape(RoundedRectangle(cornerRadius: 12 * scaleX))
                    .shadow(radius: 5 * scaleX)
                    .position(
                        x: cardWidth / 2,
                        y: (90 + 100) * scaleY // 이미지 중심 y좌표 (상단여백+반높이)
                    )
                
                // 메뉴 이름
                Text(food.name)
                    .font(.system(size: 20 * scaleY, weight: .bold))
                    .foregroundColor(.white)
                    .position(
                        x: cardWidth / 2,
                        y: 345 * scaleY
                    )
            }
        }
        .frame(width: 280, height: 480) // 기본 크기
    }
}

#Preview {
    let sample = AppSeedData.foodCards.first?.makeModel() ?? FoodCard(
        foodId: UUID(),
        name: "치즈 떡볶이",
        details: "매콤한 떡볶이에 치즈를 듬뿍 얹은 메뉴",
        category: .korean,
        image: "Tteokbokki"
    )
    
    CardFrontView(food: sample)
}

