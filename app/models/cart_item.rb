class CartItem < ApplicationRecord
  has_one_attached :image
  belongs_to :item
  belongs_to :customer

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def add_tax_price
    (self.price * 1.10).round
  end

  def subtotal
    item.add_tax_price * amount
  end

  def add_item
    CartItem.find_by(item_id: item.id)
  end

  def update_item(item_id:, amount:)
    items.find_by(item_is: item_is).update(amount: amount.to_i)
  end
end
