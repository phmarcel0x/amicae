import 'temp_profile.dart';

class ProfilesBrain {
  int userNumber = 1;

  List<Profile> users = [
    Profile(
        iD: 01,
        name: "coolCat",
        imgSource: "assets/temp_avatars/cool_cat.jpg",
        major: "Applied Rizzing",
        classes: ["SKAT356", "DRIP203", "RIZZ258"],
        skills: ["backflip", "breakdance", "mewing"],
        bio:
        "Meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow meow"),
    Profile(
        iD: 02,
        name: "nerDog",
        imgSource: "assets/temp_avatars/nerd_dog.webp",
        major: "Software Engineering",
        classes: ["COMP232", "ENGR213", "COMP248", "MANA202"],
        skills: ["good at maths", "flutter", "C++", "Java"],
        bio:
        "Woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof woof"),
    Profile(
        iD: 03,
        name: "artisticAlly",
        imgSource: "assets/temp_avatars/artistic_ally.jpg",
        major: "Fine Arts",
        classes: ["ART101", "DESIGN202", "PHOT201", "SCULP305"],
        skills: ["painting", "sculpture", "photography", "design"],
        bio:
        "I believe in expressing myself through art, my brush speaks louder than words. I find beauty in simplicity and love experimenting with colors and textures."),
    Profile(
        iD: 04,
        name: "techTito",
        imgSource: "assets/temp_avatars/tech_tito.png",
        major: "Computer Science",
        classes: ["CS101", "ALG203", "WEB301", "AI505"],
        skills: ["machine learning", "web development", "Python", "JavaScript"],
        bio:
        "Building the future of technology, one line of code at a time. Passionate about machine learning and solving complex problems with elegant solutions."),
    Profile(
        iD: 05,
        name: "partyPatty",
        imgSource: "assets/temp_avatars/party_patty.jpg",
        major: "Event Management",
        classes: ["EVENT101", "HOSP202", "MARK301", "SOCI305"],
        skills: ["party planning", "social media marketing", "public speaking", "budgeting"],
        bio:
        "I live for the thrill of hosting unforgettable events! Whether it's a corporate gathering or a wild party, I'm the one making sure everyone has a great time."),
    Profile(
        iD: 06,
        name: "jazzJazz",
        imgSource: "assets/temp_avatars/jazz_jazz.jpg",
        major: "Music",
        classes: ["MUSC101", "JAZZ201", "GUITAR305", "MUSC408"],
        skills: ["jazz guitar", "improvisation", "music theory", "songwriting"],
        bio:
        "Music is the rhythm of my soul. I play jazz guitar and love creating unique sounds that tell a story. Improv is where I thrive and I’m always seeking new ways to express myself through music."),
    Profile(
        iD: 07,
        name: "adventureAndy",
        imgSource: "assets/temp_avatars/adventure_andy.jpg",
        major: "Outdoor Recreation",
        classes: ["OUTD101", "HIK101", "SURF305", "CAMP302"],
        skills: ["mountain climbing", "surfing", "camping", "kayaking"],
        bio:
        "I live for adventure! Whether it’s scaling mountains or riding the waves, I’m always up for a challenge. The outdoors is my playground, and I’m here to explore every inch of it."),
    Profile(
        iD: 08,
        name: "ecoEva",
        imgSource: "assets/temp_avatars/eco_eva.jpg",
        major: "Environmental Science",
        classes: ["ENVS101", "BIO202", "GEOG303", "CHEM101"],
        skills: ["sustainable living", "environmental advocacy", "planting trees", "green tech"],
        bio:
        "Dedicated to preserving the planet for future generations. I’m passionate about reducing waste, promoting sustainability, and finding innovative solutions to environmental issues."),
    Profile(
        iD: 09,
        name: "healthHelen",
        imgSource: "assets/temp_avatars/health_helen.jpg",
        major: "Nursing",
        classes: ["NUR101", "ANAT201", "PHAR202", "BIO301"],
        skills: ["first aid", "patient care", "nursing theory", "health promotion"],
        bio:
        "Compassionate, dedicated, and always striving to make a positive impact in the healthcare world. I aim to provide the best care to patients and contribute to the betterment of public health."),
    Profile(
        iD: 10,
        name: "foodieFay",
        imgSource: "assets/temp_avatars/foodie_fay.jpg",
        major: "Culinary Arts",
        classes: ["CULI101", "BAKE202", "FOOD303", "NUTR405"],
        skills: ["baking", "cooking", "food plating", "recipe development"],
        bio:
        "Cooking is my passion, and I love experimenting with new flavors. From sweet pastries to savory dishes, I’m always creating something delicious. My goal is to bring joy to others through food."),
    Profile(
        iD: 11,
        name: "techieTom",
        imgSource: "assets/temp_avatars/techie_tom.jpg",
        major: "Cybersecurity",
        classes: ["SEC101", "NETWORK201", "CRYPTO303", "OS408"],
        skills: ["network security", "cryptography", "ethical hacking", "penetration testing"],
        bio: "Passionate about protecting digital spaces from cyber threats. I’m all about securing systems and preventing attacks."),
    Profile(
        iD: 12,
        name: "coderClara",
        imgSource: "assets/temp_avatars/coder_clara.jpg",
        major: "Software Engineering",
        classes: ["CS102", "ALGO203", "SOFT404", "CS507"],
        skills: ["Java", "Flutter", "React", "SQL"],
        bio: "I write clean and efficient code. My mission is to build scalable software solutions that help businesses and improve user experience."),
    Profile(
        iD: 13,
        name: "skaterSasha",
        imgSource: "assets/temp_avatars/skater_sasha.jpg",
        major: "Physical Education",
        classes: ["PE101", "SKAT201", "YOGA305", "DANCE410"],
        skills: ["skateboarding", "yoga", "dance", "martial arts"],
        bio: "Living life on the edge! I skateboard, dance, and practice yoga, always pushing myself to new physical limits."),
    Profile(
        iD: 14,
        name: "chefCharles",
        imgSource: "assets/temp_avatars/chef_charles.jpg",
        major: "Culinary Arts",
        classes: ["CULI102", "FOOD201", "BAKING305", "CATERING409"],
        skills: ["gourmet cooking", "baking", "international cuisine", "wine pairing"],
        bio: "Creating culinary masterpieces with a passion for high-end cuisine. I love mixing traditional flavors with modern twists."),
    Profile(
        iD: 15,
        name: "fitnessFiona",
        imgSource: "assets/temp_avatars/fitness_fiona.jpg",
        major: "Sports Science",
        classes: ["SPRT101", "EXER203", "HEALTH301", "ANAT402"],
        skills: ["personal training", "fitness coaching", "nutrition", "yoga"],
        bio: "Fitness is my lifestyle. I help people achieve their fitness goals through personalized training and health guidance."),
    Profile(
        iD: 16,
        name: "gamerGabe",
        imgSource: "assets/temp_avatars/gamer_gabe.jpg",
        major: "Game Design",
        classes: ["GAME101", "GRAPHIC201", "CSE301", "VR404"],
        skills: ["game development", "3D modeling", "storytelling", "virtual reality"],
        bio: "Building worlds through code. I love crafting immersive experiences and stories in games, making players feel like they belong."),
    Profile(
        iD: 17,
        name: "photographerPaula",
        imgSource: "assets/temp_avatars/photographer_paula.jpg",
        major: "Photography",
        classes: ["PHOTO101", "LIGHT202", "DIGITAL303", "FILM405"],
        skills: ["portrait photography", "event photography", "photo editing", "lighting"],
        bio: "Capturing the world through my lens. I specialize in portrait photography and love capturing raw moments."),
    Profile(
        iD: 18,
        name: "designerDylan",
        imgSource: "assets/temp_avatars/designer_dylan.jpg",
        major: "Graphic Design",
        classes: ["DES102", "GRAPH201", "UXD303", "WEB401"],
        skills: ["UI/UX design", "Adobe Illustrator", "Photoshop", "branding"],
        bio: "Designing experiences that speak to the user. I craft beautiful and functional user interfaces that make digital interactions feel seamless."),
    Profile(
        iD: 20,
        name: "developerDanny",
        imgSource: "assets/temp_avatars/developer_danny.jpg",
        major: "Software Engineering",
        classes: ["CS103", "ALGO304", "SOFT506", "ML601"],
        skills: ["JavaScript", "Node.js", "Express", "MongoDB"],
        bio: "Building the next generation of web applications, one line of code at a time. Passionate about full-stack development."),
    Profile(
        iD: 21,
        name: "artistAlexa",
        imgSource: "assets/temp_avatars/artist_alexa.jpg",
        major: "Fine Arts",
        classes: ["PAINT101", "SKETCH202", "ARTTH301", "Sculpt405"],
        skills: ["oil painting", "drawing", "art history", "landscape painting"],
        bio: "Creating visual narratives that stir emotions. I believe that art should evoke both thought and feelings."),
    Profile(
        iD: 22,
        name: "historianHolly",
        imgSource: "assets/temp_avatars/historian_holly.jpg",
        major: "History",
        classes: ["HIST101", "HIST201", "ARCH202", "HIST304"],
        skills: ["research", "archival work", "public speaking", "writing"],
        bio: "Exploring the past to understand the present. I aim to share history with others through engaging storytelling."),
    Profile(
        iD: 23,
        name: "biologistBen",
        imgSource: "assets/temp_avatars/biologist_ben.jpg",
        major: "Biology",
        classes: ["BIO101", "GENETICS202", "ECOLOGY301", "CELLBIO405"],
        skills: ["microscopy", "genetic sequencing", "data analysis", "research"],
        bio: "Studying life in all its forms, from cellular biology to ecological systems. I want to make a lasting impact on the scientific community."),
    Profile(
        iD: 24,
        name: "filmmakerFay",
        imgSource: "assets/temp_avatars/filmmaker_fay.jpg",
        major: "Film Studies",
        classes: ["FILM101", "CINEMA201", "DIRECTING301", "SCRIPT401"],
        skills: ["filmmaking", "directing", "video editing", "screenwriting"],
        bio: "Bringing stories to life through the lens of a camera. I am passionate about telling stories that captivate and inspire."),
    Profile(
        iD: 25,
        name: "architectAva",
        imgSource: "assets/temp_avatars/architect_ava.jpg",
        major: "Architecture",
        classes: ["ARCH101", "DESIGN201", "CONSTR303", "URBAN410"],
        skills: ["3D modeling", "CAD", "sustainable architecture", "urban planning"],
        bio: "Designing spaces that blend aesthetics with functionality. I believe architecture shapes the way people live and interact."),
    Profile(
        iD: 26,
        name: "dataDan",
        imgSource: "assets/temp_avatars/data_dan.jpg",
        major: "Data Science",
        classes: ["DATA101", "STATS202", "ML304", "BIGDATA405"],
        skills: ["data analysis", "machine learning", "statistics", "Python"],
        bio: "Turning raw data into actionable insights. I work with big data to find patterns and trends that drive business decisions."),
    Profile(
        iD: 27,
        name: "physicistPhil",
        imgSource: "assets/temp_avatars/physicist_phil.jpg",
        major: "Physics",
        classes: ["PHYS101", "QUANT203", "THERM301", "ELECTRO405"],
        skills: ["quantum mechanics", "theoretical physics", "astronomy", "mathematics"],
        bio: "Exploring the mysteries of the universe, from quantum particles to cosmic phenomena. I aim to push the boundaries of human knowledge."),
    Profile(
        iD: 28,
        name: "linguistLena",
        imgSource: "assets/temp_avatars/linguist_lena.jpg",
        major: "Linguistics",
        classes: ["LING101", "PHONETICS201", "MORPHOLOGY301", "SOCIOLING410"],
        skills: ["language analysis", "translation", "phonetics", "sociolinguistics"],
        bio: "Studying the power of language and its impact on society. I aim to break language barriers and help people communicate effectively."),
    Profile(
        iD: 29,
        name: "entrepreneurEva",
        imgSource: "assets/temp_avatars/entrepreneur_eva.jpg",
        major: "Business Administration",
        classes: ["BIZ101", "MKTG202", "ENTR300", "FIN301"],
        skills: ["business strategy", "marketing", "public relations", "entrepreneurship"],
        bio: "Turning ideas into thriving businesses. I’m passionate about creating new ventures that solve real-world problems."),
  ];

  void swipeProfile() {
    // algorithm to recommend the next profile
    if (userNumber < users.length - 1) {
      userNumber += 1;
    } else {
      userNumber = 0;
    }
  }
}