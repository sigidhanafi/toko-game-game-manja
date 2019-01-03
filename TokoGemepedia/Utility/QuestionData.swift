//
//  QuestionData.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class QuestionData {
    internal static func generateQuestion() -> QuizResult {
        let jsonString = """
        {
        "quizes" : [
        {
        "title" : "Siapakah karakter Avengers mu?",
        "image" : "Avengers",
        "result_array": [
        {
        "min": 0,
        "max": 6,
        "result": "Hawkeye",
        "desc": ""
        },
        {
        "min": 7,
        "max": 13,
        "result": "Spiderman",
        "desc": ""
        },
        {
        "min": 14,
        "max": 21,
        "result": "Captain America",
        "desc": ""
        },
        {
        "min": 22,
        "max": 29,
        "result": "Doctor Strange",
        "desc": ""
        },
        {
        "min": 30,
        "max": 36,
        "result": "Iron Man",
        "desc": ""
        }
        ],
        "questions" : [
        {
        "image": "",
        "name": "Jika menjadi super hero, pakaian apa yang kamu pilih?",
        "options": [
        {
        "answer": "Kaos biasa saja ah",
        "value": 1,
        "keyword": [
        "kaos",
        "jeans"
        ]
        },
        {
        "answer": "Pakaian yang ringan dan ketat agar mudah bergerak",
        "value": 3,
        "keyword": [
        "Sporty",
        "Speedo",
        "Olahraga"
        ]
        },
        {
        "answer": "Pakaian formal",
        "value": 5,
        "keyword": [
        "Jas",
        "Blazer",
        "Dasi",
        "kemeja"
        ]
        },
        {
        "answer": "Jubah keren yang misterius",
        "value": 7,
        "keyword": [
        "jubah",
        "hoody",
        "buff"
        ]
        },
        {
        "answer": "Armor canggih dengan AI",
        "value": 9,
        "keyword": [
        "iron man",
        "smart lamp",
        "wireless charging"
        ]
        }
        ]
        },
        {
        "image": "",
        "name": "Jika kamu harus mengorbankan nyawa mu menyelamatkan orang dibawah ini, siapa yg akan kamu pilih?",
        "options": [
        {
        "answer": "Anjing/Kucing",
        "value": 1,
        "keyword": [
        "Binatang",
        "Kucing",
        "Anjing"
        ]
        },
        {
        "answer": "Presiden mu",
        "value": 3,
        "keyword": [
        "Indonesia",
        "Merah Putih",
        "Bendera"
        ]
        },
        {
        "answer": "Perempuan/laki laki yang cakep",
        "value": 5,
        "keyword": [
        "Pomade",
        "Make up",
        "Kaca mata",
        "kemeja"
        ]
        },
        {
        "answer": "Orang tua bangka",
        "value": 7,
        "keyword": [
        "emas",
        "otomotif",
        "tool"
        ]
        },
        {
        "answer": "Anak kecil",
        "value": 9,
        "keyword": [
        "baju anak anak",
        "mainan"
        ]
        }
        ]
        },
        {
        "image": "",
        "name": "Kendaraan pilihan kamu apa?",
        "options": [
        {
        "answer": "Sepeda",
        "value": 1,
        "keyword": [
        "botol minum",
        "helm sepeda",
        "sepeda",
        "sporty"
        ]
        },
        {
        "answer": "Lari lah ngaain pake kendaraan",
        "value": 3,
        "keyword": [
        "botol minum",
        "sepatu",
        "earphone",
        "armband",
        "lari"
        ]
        },
        {
        "answer": "Motor besar",
        "value": 5,
        "keyword": [
        "Jaket motor",
        "motor",
        "sarung tangan motor"
        ]
        },
        {
        "answer": "Mobil jeep",
        "value": 7,
        "keyword": [
        "pewangi mobil",
        "mobil",
        "jeep"
        ]
        },
        {
        "answer": "Lamborghini",
        "value": 9,
        "keyword": [
        "iphone",
        "wireless charging",
        "jam tangan"
        ]
        }
        ]
        },
        {
        "image": "",
        "name": "Warna favorit mu?",
        "options": [
        {
        "answer": "Hitam",
        "value": 1,
        "keyword": [
        "hitam"
        ]
        },
        {
        "answer": "Merah",
        "value": 3,
        "keyword": [
        "merah"
        ]
        },
        {
        "answer": "Biru",
        "value": 5,
        "keyword": [
        "biru"
        ]
        },
        {
        "answer": "Hijau",
        "value": 7,
        "keyword": [
        "hijau"
        ]
        },
        {
        "answer": "Kuning",
        "value": 9,
        "keyword": [
        "kuning"
        ]
        }
        ]
        }
        ]
        }
        ]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(QuizResult.self, from: jsonData)
    }
}
