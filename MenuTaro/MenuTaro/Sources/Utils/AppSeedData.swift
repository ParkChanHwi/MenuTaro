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
        FoodCardSeed(name: "카레 & 난", details: "인도식 커리와 고소한 난의 조합", category: .etc, image: "Curry&Nann"),
        FoodCardSeed(name: "타코", details: "티키타코", category: .western, image: "Taco"),
        FoodCardSeed(name: "가츠동", details: "바삭한 돈카츠와 달콤한 소스의 덮밥", category: .japanese, image: "KatsuDong"),
        FoodCardSeed(name: "곱창", details: "쫄깃한 곱창을 구워낸 별미", category: .korean, image: "Gobchang"),
        FoodCardSeed(name: "김치찜", details: "잘 익은 김치와 돼지고기의 푸짐한 찜", category: .korean, image: "KimchiJJim"),
        FoodCardSeed(name: "냉면", details: "시원한 육수와 쫄깃한 면발", category: .korean, image: "Coolmyeon"),
        FoodCardSeed(name: "돼지국밥", details: "담백한 돼지 육수 가득한 한 그릇", category: .korean, image: "PorkSoup"),
        FoodCardSeed(name: "구운치킨", details: "담백하게 구워낸 치킨의 정석", category: .korean, image: "GuwoonChicken"),
        FoodCardSeed(name: "보쌈", details: "수육과 김치의 든든한 조합", category: .korean, image: "BoSSAM"),
        FoodCardSeed(name: "라멘", details: "진한 국물의 일본식 면 요리", category: .japanese, image: "Ramen"),
        FoodCardSeed(name: "비빔밥", details: "다양한 나물과 고추장의 조화", category: .korean, image: "Bibimbap"),
        FoodCardSeed(name: "순대국밥", details: "순대와 뽀얀 국물의 따뜻한 한 끼", category: .korean, image: "SundaiSoup"),
        FoodCardSeed(name: "시즈닝 치킨", details: "시즈닝 가루가 어우러진 바삭한 치킨", category: .korean, image: "SeasoningChicken"),
        FoodCardSeed(name: "양념치킨", details: "달콤매콤 양념이 매력적인 치킨", category: .korean, image: "YangnyeomChicken"),
        FoodCardSeed(name: "죽", details: "속을 달래주는 부드러운 한 그릇", category: .korean, image: "Jook"),
        FoodCardSeed(name: "닭발", details: "매콤하게 즐기는 쫄깃한 닭발", category: .korean, image: "DakKal"),
        FoodCardSeed(name: "오일파스타", details: "올리브 오일 향이 가득한 파스타", category: .western, image: "OilPasta"),
        FoodCardSeed(name: "잔치국수", details: "담백한 멸치육수의 따뜻한 국수", category: .korean, image: "PartyNoodle"),
        FoodCardSeed(name: "제육볶음", details: "매콤달콤하게 볶아낸 돼지고기", category: .korean, image: "Jeyook"),
        FoodCardSeed(name: "항정살 덮밥", details: "고소한 항정살을 얹은 덮밥", category: .korean, image: "Hangjeongsal"),
        FoodCardSeed(name: "카츠", details: "바삭하게 튀긴 돼지고기 카츠", category: .japanese, image: "Katsu"),
        FoodCardSeed(name: "비빔면", details: "새콤달콤 양념에 비벼 먹는 면", category: .korean, image: "Bibimnoodle"),
        FoodCardSeed(name: "족발", details: "쫀득한 족발과 새콤한 무김치", category: .korean, image: "JokBal"),
        FoodCardSeed(name: "뼈해장국", details: "진한 사골 국물의 해장 한 그릇", category: .korean, image: "BoneSoup"),
        FoodCardSeed(name: "크림파스타", details: "부드러운 크림 소스가 듬뿍", category: .western, image: "CreamPasta"),
        FoodCardSeed(name: "회덮밥", details: "신선한 회와 야채를 비벼 먹는 덮밥", category: .japanese, image: "Hoedeopbap"),
        FoodCardSeed(name: "김치찌개", details: "얼큰한 김치와 돼지고기의 조화", category: .korean, image: "Kimjji"),
        FoodCardSeed(name: "고구마피자", details: "달콤한 고구마 무스가 어우러진 피자", category: .western, image: "SweeyPotato"),
        FoodCardSeed(name: "치킨마요 덮밥", details: "고소한 치킨과 마요 소스 덮밥", category: .etc, image: "ChickenMayo"),
        FoodCardSeed(name: "닭갈비", details: "매콤하게 볶아낸 춘천식 닭갈비", category: .korean, image: "DakGalbi"),
        FoodCardSeed(name: "간장치킨", details: "짭조름한 간장 양념 치킨", category: .korean, image: "SoyChicken"),
        FoodCardSeed(name: "초밥", details: "신선한 네타가 올라간 초밥", category: .japanese, image: "Sushi"),
        FoodCardSeed(name: "막국수", details: "메밀향 가득한 시원한 국수", category: .korean, image: "Makguksu"),
        FoodCardSeed(name: "콩나물 국밥", details: "시원한 콩나물과 얼큰한 국물", category: .korean, image: "SoyBeanSoup"),
        FoodCardSeed(name: "육개장", details: "소고기와 대파가 듬뿍인 얼큰한 국물", category: .korean, image: "Yukgaejang"),
        FoodCardSeed(name: "닭강정", details: "달콤바삭한 닭강정", category: .korean, image: "Dakgangjeong"),
        FoodCardSeed(name: "갈비찜", details: "부드럽게 조린 갈비의 풍미", category: .korean, image: "GalbiJJim"),
        FoodCardSeed(name: "삼계탕", details: "영양 가득한 보양식", category: .korean, image: "Samgyetang"),
        FoodCardSeed(name: "돈카츠", details: "겉바속촉 두툼한 돈카츠", category: .japanese, image: "Donkatsu"),
        FoodCardSeed(name: "통닭", details: "옛날식 통닭의 담백한 맛", category: .korean, image: "Tongdak"),
        FoodCardSeed(name: "소바", details: "쫄깃한 면발과 깔끔한 육수", category: .japanese, image: "Soba"),
        FoodCardSeed(name: "삼겹살", details: "노릇하게 구운 삼겹살 한 점", category: .korean, image: "Samgyeop"),
        FoodCardSeed(name: "사케동", details: "연어를 듬뿍 올린 덮밥", category: .japanese, image: "SakeDon"),
        FoodCardSeed(name: "규동", details: "달큰한 소고기와 양파 덮밥", category: .japanese, image: "Gyudong"),
        FoodCardSeed(name: "찜닭", details: "달콤짭짤한 간장 양념 찜닭", category: .korean, image: "JJimDak"),
        FoodCardSeed(name: "알밥", details: "톡톡 터지는 날치알 덮밥", category: .korean, image: "RBap"),
        FoodCardSeed(name: "숯불구이", details: "향긋한 숯불에 구워낸 고기", category: .korean, image: "SootBul"),
        FoodCardSeed(name: "스테이크 덮밥", details: "부드러운 스테이크와 데리야키 소스", category: .western, image: "SteakDupbap")
    ]
}
