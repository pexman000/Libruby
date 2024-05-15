# db/seeds.rb

# Méthode 1: Créer des produits individuels
20.times do |n|
    seller = Seller.first # Vous devrez adapter cette logique en fonction de la façon dont vous gérez les vendeurs
    Product.create!(
      name: "Product #{n+1}",
      description: "Description of Product #{n+1}",
      price: rand(10.0..100.0).round(2),
      stock: rand(1..100),
      seller: seller
    )
  end
  
  # Méthode 2: Créer des produits avec FactoryBot (si vous utilisez FactoryBot)
  # Utilisez les factories pour générer des données de manière plus dynamique
  # Veuillez vous assurer que vous avez correctement configuré vos factories pour les modèles User et Seller.
  # Consultez la documentation de FactoryBot pour plus de détails.
  