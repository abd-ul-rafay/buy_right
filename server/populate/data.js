const data = [
    {
        name: 'Amazon Echo Dot',
        description: 'The Amazon Echo Dot is a compact and smart speaker that can fit in any room. With voice control and Alexa, you can play music, control smart home devices, make calls, and much more. It\'s the perfect addition to your home for convenience and entertainment.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694953099/BuyRight/All/euakqiess9o730ycchmx.png'],
        price: 39.99,
        quantity: 500,
        category: 'All'
      },
      {
        name: "Levi's 501 Original Fit Jeans",
        description: "Levi's 501 Original Fit Jeans are a timeless classic. Made with high-quality denim, these jeans offer a comfortable and stylish fit. Whether you're dressing up or keeping it casual, these jeans are a versatile addition to your wardrobe.",
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694953235/BuyRight/All/efigxlhdbzcm5jrqf3we.png'],
        price: 59.99,
        quantity: 1000,
        category: 'All'
      },
      {
        name: 'Apple iPhone 14 Pro Max',
        description: 'The Apple iPhone 14 Pro Max is the latest flagship smartphone with cutting-edge technology. Featuring a stunning display, powerful performance, and an advanced camera system, it\'s designed to elevate your mobile experience. Stay connected and capture memories like never before.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694250380/BuyRight/Electronics/zfvwt0k2ukmgfcq5glqo.png'],
        price: 1199.99,
        quantity: 200,
        category: 'Electronics'
      },
      {
        name: 'Sony WH-1000XM4 Wireless Noise-Canceling Headphones',
        description: 'Experience superior sound quality and noise cancellation with the Sony WH-1000XM4 headphones. Perfect for music lovers and travelers, these headphones provide immersive audio and comfort. Stay in your world of music with peace and clarity.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694953535/BuyRight/Electronics/guffxgoravz5dhv2vjow.png'],
        price: 299.99,
        quantity: 500,
        category: 'Electronics'
      },
      {
        name: 'Apple Watch Series 3',
        description: 'Stay connected and track your fitness with the Apple Watch Series 3. It features a sleek design and a range of health and fitness apps. Whether you\'re working out or staying organized, this smartwatch has you covered.',
        images: [
          'https://res.cloudinary.com/dahwtdeef/image/upload/v1694253038/BuyRight/Electronics/ozlvcp9dhcuxzlctjcrg.png',
          'https://res.cloudinary.com/dahwtdeef/image/upload/v1694953658/BuyRight/Electronics/bgchb4fssuoctmxipblk.png',
          'https://res.cloudinary.com/dahwtdeef/image/upload/v1694253041/BuyRight/Electronics/fsrnuqnh7ad6jm9w4f58.png'
        ],
        price: 320.0,
        quantity: 1000,
        category: 'Electronics'
      },
      {
        name: 'DJI Mavic Air 2 Drone',
        description: 'Take stunning aerial photos and videos with the DJI Mavic Air 2 Drone. With intelligent shooting modes and high-quality camera capabilities, this drone is perfect for capturing breathtaking moments from the sky. Explore the world of aerial photography with ease.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694953954/BuyRight/Electronics/ic0b53yvonktry6i4hu9.png'],
        price: 799.99,
        quantity: 200,
        category: 'Electronics'
      }, 
      {
        name: 'Bose SoundLink Revolve',
        description: 'The Bose SoundLink Revolve is a portable Bluetooth speaker that delivers deep, 360-degree sound. With a durable design and long battery life, it\'s perfect for outdoor adventures and indoor gatherings. Enjoy music in every direction with Bose quality audio.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694954118/BuyRight/Electronics/nj40e4peuhhdc4tjowy5.png'],
        price: 199.99,
        quantity: 500,
        category: 'Electronics'
      },
      {
        name: 'Nvidia GeForce Graphics Card',
        description: 'Upgrade your gaming experience with the Nvidia GeForce Graphics Card. With powerful graphics performance, it delivers smooth gameplay and realistic visuals. Take your gaming to the next level with the latest in graphics technology.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694954304/BuyRight/Electronics/wzwcaxsahmhekxhemrbu.png'],
        price: 499.99,
        quantity: 1000,
        category: 'Electronics'
      },
      {
        name: 'Nike Air Max 270 Sneakers',
        description: 'Step up your style with Nike Air Max 270 Sneakers. These sneakers offer a blend of comfort and fashion, perfect for daily wear or workouts. The iconic Air Max cushioning provides responsive support for all-day comfort.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694954496/BuyRight/Fashion/ogshsc6nfwozchg3e8nl.png'],
        price: 129.99,
        quantity: 500,
        category: 'Fashion'
      },
      {
        name: 'Michael Kors Jet Set Tote Bag',
        description: 'Carry your essentials in style with the Michael Kors Jet Set Tote Bag. It\'s a versatile and elegant accessory for any outfit. With spacious interior pockets, it keeps you organized on the go.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694954769/BuyRight/Fashion/csfgqhxe1u7pr4vik7hh.png'],
        price: 199.99,
        quantity: 200,
        category: 'Fashion'
      },
      {
        name: "Harry Potter and the Sorcerer's Stone",
        description: "Enter the magical world of Harry Potter with the first book, 'Harry Potter and the Sorcerer's Stone.' Join Harry, Hermione, and Ron on their adventures at Hogwarts School of Witchcraft and Wizardry. A must-read for fans of fantasy and adventure.",
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694954978/BuyRight/Books/dcbtycji4uty4jkrjikg.png'],
        price: 14.99,
        quantity: 1000,
        category: 'Books'
      },
      {
        name: 'NutriBullet Pro 900 Series Blender',
        description: 'Create healthy and delicious smoothies with the NutriBullet Pro 900 Series Blender. It\'s designed to extract nutrients from fruits and vegetables for a nutritious blend. Make nutritious drinks in seconds and kickstart your day with vitality.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694955567/BuyRight/Health/xz7u2tj7b04jj7ykckmw.png'],
        price: 79.99,
        quantity: 200,
        category: 'Health'
      }, 
      {
        name: 'Tranquil Azure Elegance: The Nordic Blue Sofa',
        description: 'This stylish Nordic sofa, upholstered in a serene shade of blue, adds a touch of sophistication to any living room. Its sleek design seamlessly blends with modern decor, while the accompanying ottoman enhances comfort and functionality. Perfect for relaxation and social gatherings, this sofa is the epitome of both form and function.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694959822/BuyRight/Furniture/rgzxmpbvv3ltwk7fqd4r.png'],
        price: 499.99,
        quantity: 500,
        category: 'Furniture'
      },
      {
        name: 'Sony PlayStation 5 (Gaming Console)',
        description: 'Experience next-gen gaming with the Sony PlayStation 5. With lightning-fast load times, immersive graphics, and a library of exciting games, it\'s a must-have for gamers. Elevate your gaming adventures with the power of PlayStation.',
        images: ['https://res.cloudinary.com/dahwtdeef/image/upload/v1694955707/BuyRight/Entertainment/k50ibypd5dpp7jii6por.png'],
        price: 499.99,
        quantity: 1000,
        category: 'Entertainment'
      }
];

export default data;
