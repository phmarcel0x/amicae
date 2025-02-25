import 'package:flutter/material.dart';

enum Interests {
  // Creativity
  Drawing,     // 🎨
  Painting,    // 🖌️
  Writing,     // ✍️
  Photography, // 📸
  Crafting,    // ✂️
  Dancing,     // 💃
  Singing,     // 🎤
  Acting,      // 🎭
  Design,      // 🖼️
  MusicProduction, // 🎧
  Sewing,      // 🧵
  Knitting,    // 🧶

  // Sports
  Soccer,      // ⚽
  Basketball,  // 🏀
  Tennis,      // 🎾
  Swimming,    // 🏊‍♂️
  Running,     // 🏃‍♂️
  Cycling,     // 🚴‍♂️
  Yoga,        // 🧘‍♂️
  Surfing,     // 🏄‍♂️
  Boxing,      // 🥊
  Gymnastics,  // 🤸‍♂️
  Weightlifting, // 🏋️‍♂️
  Hiking,      // 🥾

  // Going out
  Clubbing,    // 💃
  Bars,        // 🍻
  Concerts,    // 🎶
  Festivals,   // 🎉
  Theater,     // 🎭
  Museums,     // 🖼️
  Shopping,    // 🛍️
  Picnics,     // 🧺

  // Staying in
  Reading,     // 📚
  Gaming,      // 🎮
  Cooking,     // 🍳
  Baking,      // 🧁
  Puzzles,     // 🧩
  BoardGames,  // 🎲
  HomeWorkout, // 🏋️‍♂️
  Gardening,   // 🌱

  // Film & TV
  Movies,      // 🎬
  Documentaries, // 🎥
  Animation,   // 🎨
  RealityTV,   // 📺
  Anime,       // 🐉
  Sitcoms,     // 😂
  SciFi,       // 🚀

  // Reading
  Fiction,     // 📖
  NonFiction,  // 📚
  Poetry,      // 📜
  Fantasy,     // 🦄
  Mystery,     // 🕵️‍♂️
  SelfHelp,    // 🧠
  Biography,   // 👤
  History,     // 📜

  // Music
  Classical,   // 🎻
  Rock,        // 🎸
  Pop,         // 🎤
  HipHop,      // 🎧
  Jazz,        // 🎷
  Blues,       // 🎺
  Country,     // 🎶
  EDM,         // 🎵
  Indie,       // 🎼
  KPop,        // 🇰🇷

  // Food & Drink
  Coffee,      // ☕
  Tea,         // 🍵
  Wine,        // 🍷
  CraftBeer,   // 🍺
  Vegetarian,  // 🥗
  Vegan,       // 🌱
  BakingSweets,// 🍰
  CookingSavory,// 🍲
  Sushi,       // 🍣
  Pizza,       // 🍕
  BBQ,         // 🍖

  // Traveling
  RoadTrips,   // 🚗
  Backpacking, // 🎒
  BeachTrips,  // 🏖️
  Camping,     // 🏕️
  CityTours,   // 🏙️
  CulturalTrips,// 🕌
  HikingTrails,// 🥾
  AdventureTrips, // 🏔️

  // Pets
  Dogs,        // 🐕
  Cats,        // 🐈
  Birds,       // 🐦
  Reptiles,    // 🦎
  Fish,        // 🐠
  Horses,      // 🐎
  SmallPets,   // 🐹

  // Values & Traits
  Environmentalism, // 🌍
  Volunteering, // 🙋‍♂️
  Kindness,     // ❤️
  Honesty,      // 💬
  Loyalty,      // 🛡️
  Compassion,   // 🤲
  Empathy,      // 🤝

  // Values & Allyship
  Feminism,     // 👩‍⚖️
  LGBTQIAAlly,  // 🏳️‍🌈
  AntiRacism,   // ✊🏿
  MentalHealthAwareness, // 🧠
  BodyPositivity, // 💪
  DisabilityAdvocacy, // ♿
  Sustainability, // 🌱
  AnimalRights, // 🐾
}


class UserInterest {
  const UserInterest(this.title, this.emoji);

  final String title;
  final String emoji;
}
