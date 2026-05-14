class DeliveryTime < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: '1~2日でで発送' },
   { id: 3, name: '2~3日でで発送' },
   { id: 4, name: '4~7日でで発送' }
 ]

  include ActiveHash::Associations
  has_many :items
  
end