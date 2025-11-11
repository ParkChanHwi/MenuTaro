//
//  Created by mac mini on 10/5/23.
//

import Foundation

struct FoodCardSeed {
    let name: String
    let details: String
    let category: FoodCard.FoodCategory
    let image: String

    func makeModel() -> FoodCard {
        FoodCard(
            foodId: UUID(),
            name: name,
            details: details,
            category: category,
            image: image
        )
    }
}

enum AppSeedData {
    static let foodCards: [FoodCardSeed] = [
        FoodCardSeed(name: "짜장면", details: "춘장이 듬뿍 올라간 정통 중식면", category: .chinese, image: "Jjajangmyeon"),
        FoodCardSeed(name: "라볶이", details: "떡볶이와 라면 사리의 든든한 조합", category: .korean, image: "Rabokki"),
        FoodCardSeed(name: "쫄면", details: "매콤달콤한 양념에 비벼 먹는 별미", category: .korean, image: "Jjolmyeon"),
        FoodCardSeed(name: "김밥", details: "간편하게 즐기는 국민 간식", category: .korean, image: "kimbap"),
        FoodCardSeed(name: "떡볶이", details: "고추장 양념이 매력적인 길거리 대표 메뉴", category: .korean, image: "Tteokbokki"),
        FoodCardSeed(name: "짬뽕", details: "불맛 가득한 얼큰한 해물 국물", category: .chinese, image: "Jjamppong"),
        FoodCardSeed(name: "마라탕", details: "화끈하게 즐기는 마라의 매력", category: .chinese, image: "Maratang"),
        FoodCardSeed(name: "탕수육", details: "겉은 바삭 속은 촉촉한 중식 튀김", category: .chinese, image: "Tangsuyuk"),
        FoodCardSeed(name: "마라샹궈", details: "풍성한 재료와 향신료의 조화", category: .chinese, image: "Malaxiangguo"),
        FoodCardSeed(name: "꿔바로우", details: "새콤달콤 소스가 매력적인 튀김 요리", category: .chinese, image: "Guobaorou"),
        FoodCardSeed(name: "포테이토 피자", details: "고소한 감자와 치즈의 풍부한 맛", category: .western, image: "PotatoPizza"),
        FoodCardSeed(name: "쉬림프 피자", details: "탱글한 새우가 듬뿍 들어간 피자", category: .western, image: "ShirimpPizza"),
        FoodCardSeed(name: "샌드위치", details: "든든하고 간편한 한 끼 식사", category: .western, image: "Sandwich"),
        FoodCardSeed(name: "콤비네이션 피자", details: "다양한 토핑을 한 번에 즐기는 피자", category: .western, image: "CombinationPizza"),
        FoodCardSeed(name: "요거트", details: "새콤달콤한 디저트 한 스푼", category: .etc, image: "Yogurt"),
        FoodCardSeed(name: "페퍼로니 피자", details: "짭짤한 페퍼로니가 어우러진 정통 피자", category: .western, image: "PeperoniPizza"),
        FoodCardSeed(name: "불고기 피자", details: "달콤한 불고기를 올린 한국식 피자", category: .western, image: "BulgogiPizza"),
        FoodCardSeed(name: "포케", details: "신선한 재료를 가득 담은 하와이안 볼", category: .etc, image: "Poke"),
        FoodCardSeed(name: "샐러드", details: "가볍게 즐기는 프레시 야채", category: .etc, image: "Salad"),
        FoodCardSeed(name: "고르곤졸라 피자", details: "꿀과 함께 즐기는 진한 치즈 풍미", category: .western, image: "GorgonzolaPizza"),
        FoodCardSeed(name: "토마토 스파게티", details: "상큼한 토마토 소스가 돋보이는 파스타", category: .western, image: "TomatoSpaghetti"),
        FoodCardSeed(name: "햄버거", details: "육즙 가득 패티와 신선한 야채", category: .western, image: "Hamburger"),
        FoodCardSeed(name: "크림 리조또", details: "부드러운 크림과 밥알의 조화", category: .western, image: "CreamRisotto"),
        FoodCardSeed(name: "로제 리조또", details: "토마토와 크림의 조화로운 리조또", category: .western, image: "RoseRisotto"),
        FoodCardSeed(name: "필라프", details: "향긋하게 볶아낸 밥요리", category: .western, image: "Pilaf"),
        FoodCardSeed(name: "로제 파스타", details: "토마토와 크림이 어우러진 파스타", category: .western, image: "RosePasta"),
        FoodCardSeed(name: "부리토", details: "풍성한 속재료를 또띠아에 감싼 한 끼", category: .western, image: "Burrito"),
        FoodCardSeed(name: "쌀국수", details: "담백한 육수에 쫄깃한 면", category: .etc, image: "Ricenoodles"),
        FoodCardSeed(name: "분짜", details: "상큼한 소스와 고기가 어우러진 베트남 요리", category: .etc, image: "Buncha"),
        FoodCardSeed(name: "카레 & 난", details: "인도식 커리와 고소한 난의 조합", category: .etc, image: "Curry&Nann")
    ]
}
