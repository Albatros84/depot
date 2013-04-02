class Product < ActiveRecord::Base
  default_scope :order=>:title
  validates :title, :length=>{:minimum=>4, :message=>"title must be at least 4 letters"}
  validates_presence_of :description, :title, :message=>"cant be blank"
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01, :message=>"must be greater than 0"}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
            :with => %r{\.(gif|jpg|png|jpeg)$}i,
            :message => 'must be a URL for GIF, JPG or PNG image.'
}
  has_many :line_items
  has_many :orders, :through=>:line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  private
  
  
  #gdgdgdg
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
    return true
    else
      error.add(:base, "Line item present")
      return false
    end
  end
  
  
end
